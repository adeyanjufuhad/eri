import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:eri/matching/text_match.dart';

// Canary network (PLAN.md Day 4): when a vendor catches a fake, other Eri vendors get warned.
// Only SHA-256 hashes leave the phone: of the receipt image bytes, and of the sender's normalised name.
// Never names, phone numbers, images or text. Backend: Neon project "eri" (table scam_fingerprints, RLS:
// guests may only insert, never read; counts come from the canary_count() function).
//
// These URLs are public endpoints, not secrets: requests use a short-lived anonymous guest token.
const canaryAuthUrl = 'https://ep-still-truth-bjcua7vk.neonauth.c-3.eu-west-2.aws.neon.tech/neondb/auth';
const canaryApiUrl = 'https://ep-still-truth-bjcua7vk.apirest.c-3.eu-west-2.aws.neon.tech/neondb/rest/v1';

enum FingerprintKind { image, name }

String _sha(String s) => sha256.convert(utf8.encode(s)).toString();

/// Same person, same hash on every phone: "CHIOMA OKAFOR", "Chioma  Okafor." → one fingerprint.
String nameFingerprint(String name) => _sha('eri-canary-v1|name|${normalize(name)}');

/// A fresh random id for this install (hashed again before it's ever sent).
String newInstallId() {
  final r = Random.secure();
  return List.generate(32, (_) => r.nextInt(256).toRadixString(16).padLeft(2, '0')).join();
}

class CanaryClient {
  CanaryClient({required this.installId, http.Client? client}) : _http = client ?? http.Client();

  final String installId;
  final http.Client _http;
  String? _token;
  DateTime _tokenUntil = DateTime.fromMillisecondsSinceEpoch(0);

  String get _reporter => _sha('eri-reporter|$installId');

  Future<Map<String, String>> _headers() async {
    if (_token == null || DateTime.now().isAfter(_tokenUntil)) {
      final r = await _http.get(Uri.parse('$canaryAuthUrl/token/anonymous')).timeout(const Duration(seconds: 10));
      if (r.statusCode != 200) throw http.ClientException('guest token ${r.statusCode}');
      _token = (jsonDecode(r.body) as Map<String, dynamic>)['token'] as String;
      _tokenUntil = DateTime.now().add(const Duration(minutes: 10)); // short-lived; refresh well before expiry
    }
    return {'Authorization': 'Bearer $_token', 'Content-Type': 'application/json'};
  }

  /// "Warn other vendors". Safe to call twice: one report per install per fingerprint (the server ignores repeats).
  Future<void> report({String? imageHash, String? sender}) async {
    final rows = [
      if (imageHash != null) {'kind': 'image', 'hash': imageHash, 'reporter': _reporter},
      if (sender != null && normalize(sender).isNotEmpty)
        {'kind': 'name', 'hash': nameFingerprint(sender), 'reporter': _reporter},
    ];
    for (final row in rows) {
      final r = await _http
          .post(
            Uri.parse('$canaryApiUrl/scam_fingerprints'),
            headers: {...await _headers(), 'Prefer': 'return=minimal'},
            body: jsonEncode(row),
          )
          .timeout(const Duration(seconds: 10));
      if (r.statusCode != 201 && r.statusCode != 409) throw http.ClientException('report ${r.statusCode}');
    }
  }

  /// How many different Eri vendors flagged this fingerprint in the last 30 days.
  Future<int> count(FingerprintKind kind, String hash) async {
    final r = await _http
        .post(
          Uri.parse('$canaryApiUrl/rpc/canary_count'),
          headers: await _headers(),
          body: jsonEncode({'p_kind': kind.name, 'p_hash': hash}),
        )
        .timeout(const Duration(seconds: 10));
    if (r.statusCode != 200) throw http.ClientException('count ${r.statusCode}');
    return jsonDecode(r.body) as int;
  }

  /// The strongest signal for a sender and/or image: the higher of the two counts. 0 when offline.
  Future<int> flags({String? sender, String? imageHash}) async {
    try {
      final counts = await Future.wait([
        if (sender != null && normalize(sender).isNotEmpty) count(FingerprintKind.name, nameFingerprint(sender)),
        if (imageHash != null) count(FingerprintKind.image, imageHash),
      ]);
      return counts.fold<int>(0, max);
    } catch (_) {
      return 0; // no network: say nothing rather than guess
    }
  }
}
