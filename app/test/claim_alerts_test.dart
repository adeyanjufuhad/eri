import 'package:drift/native.dart';
import 'package:eri/claims/claim_alerts.dart';
import 'package:eri/claims/claim_service.dart';
import 'package:eri/data/db.dart';
import 'package:eri/listener/ingest.dart';
import 'package:eri/listener/notification_bridge.dart';
import 'package:eri/parsing/bank_alert.dart' as p;
import 'package:flutter_test/flutter_test.dart';

class _Bridge extends NotificationBridge {
  _Bridge({required this.on});
  final bool on;
  final sent = <(int, String, String)>[];
  @override
  Future<bool> chatChecks() async => on;
  @override
  Future<bool> notifyClaim(int id, String title, String body) async {
    sent.add((id, title, body));
    return true;
  }
}

void main() {
  late EriDb db;
  setUp(() => db = EriDb(NativeDatabase.memory()));
  tearDown(() => db.close());

  final t0 = DateTime(2026, 11, 27, 14);
  p.RawNotification n(String pkg, String title, String text, int minute) => p.RawNotification(
    package: pkg,
    title: title,
    text: text,
    postedAt: t0.add(Duration(minutes: minute)),
  );

  test('no money after 10 minutes → one phone warning, never repeated', () async {
    final bridge = _Bridge(on: true);
    final claims = Claims(db, onFlagged: (c) => warnOnPhone(bridge, c));
    await ingest(db, [n('com.whatsapp', 'Tunde Bakare', 'I don pay, check am ₦45,000', 0)], claims: claims);
    expect(bridge.sent, isEmpty); // still inside the 10 minutes

    final flagged = await claims.resolve(now: t0.add(const Duration(minutes: 11)));
    expect(flagged.single.status, 'not_received');
    expect(bridge.sent, hasLength(1));
    final (id, title, body) = bridge.sent.single;
    expect(id, flagged.single.id);
    expect(title, 'No money from Tunde Bakare yet');
    expect(body, contains('₦45,000'));
    expect(body, contains('Don’t send the goods yet'));

    await claims.resolve(now: t0.add(const Duration(minutes: 12)));
    expect(bridge.sent, hasLength(1)); // already warned
  });

  test('the money arrives → no warning at all', () async {
    final bridge = _Bridge(on: true);
    final claims = Claims(db, onFlagged: (c) => warnOnPhone(bridge, c));
    await ingest(db, [n('com.whatsapp', 'Chioma Okafor', "I've paid ₦25,000", 0)], claims: claims);
    await ingest(db, [
      n('team.opay.pay', 'OPay', 'You have received ₦25,000.00 from CHIOMA OKAFOR.', 2),
    ], claims: claims);
    await claims.resolve(now: t0.add(const Duration(minutes: 30)));
    expect(bridge.sent, isEmpty);
  });

  test('chat checks turned off → nothing reaches the phone', () async {
    final bridge = _Bridge(on: false);
    final claims = Claims(db, onFlagged: (c) => warnOnPhone(bridge, c));
    await ingest(db, [n('com.whatsapp', 'Tunde Bakare', 'I don pay ₦45,000', 0)], claims: claims);
    await claims.resolve(now: t0.add(const Duration(minutes: 11)));
    expect(bridge.sent, isEmpty);
  });

  test('warning text for a different amount; none for verified', () {
    PaymentClaim claim(String status) => PaymentClaim(
      id: 1,
      app: 'WhatsApp',
      sender: 'Ada Obi',
      amountKobo: 4500000,
      previewHash: 'x',
      claimedAt: t0,
      expiresAt: t0.add(const Duration(minutes: 10)),
      status: status,
      dismissed: false,
    );
    final w = claimWarning(claim('mismatch'))!;
    expect(w.title, 'Different amount from Ada Obi');
    expect(w.body, contains('₦45,000 on WhatsApp'));
    expect(claimWarning(claim('verified')), isNull);
    expect(claimWarning(claim('pending')), isNull);
  });
}
