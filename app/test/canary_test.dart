import 'dart:convert';

import 'package:eri/canary/canary.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

void main() {
  test('one person, one fingerprint, and no name in it', () {
    expect(nameFingerprint('CHIOMA OKAFOR'), nameFingerprint('  Chioma  Okafor. '));
    expect(nameFingerprint('CHIOMA OKAFOR'), isNot(nameFingerprint('TUNDE BAKARE')));
    expect(nameFingerprint('CHIOMA OKAFOR'), matches(RegExp(r'^[0-9a-f]{64}$')));
    expect(nameFingerprint('CHIOMA OKAFOR').toLowerCase(), isNot(contains('chioma')));
  });

  test('reports send only hashes, with a guest token; counts come back; offline → 0', () async {
    final sent = <Map<String, dynamic>>[];
    final client = MockClient((req) async {
      if (req.url.path.endsWith('/token/anonymous')) return http.Response(jsonEncode({'token': 'guest'}), 200);
      expect(req.headers['Authorization'], 'Bearer guest');
      if (req.url.path.endsWith('/scam_fingerprints')) {
        sent.add(jsonDecode(req.body) as Map<String, dynamic>);
        return http.Response('', sent.length == 1 ? 201 : 409); // a repeat is fine
      }
      if (req.url.path.endsWith('/rpc/canary_count')) return http.Response('3', 200);
      return http.Response('', 404);
    });
    final c = CanaryClient(installId: newInstallId(), client: client);

    await c.report(imageHash: 'a' * 64, sender: 'Tunde Bakare');
    expect(sent.map((r) => r['kind']), ['image', 'name']);
    for (final r in sent) {
      expect(r.keys.toSet(), {'kind', 'hash', 'reporter'});
      expect(r['hash'], matches(RegExp(r'^[0-9a-f]{64}$')));
      expect(jsonEncode(r).toLowerCase(), isNot(contains('tunde')));
    }
    expect(await c.flags(sender: 'Tunde Bakare'), 3);

    final offline = CanaryClient(
      installId: 'x',
      client: MockClient((_) async => throw http.ClientException('no network')),
    );
    expect(await offline.flags(sender: 'Tunde Bakare'), 0);
  });
}
