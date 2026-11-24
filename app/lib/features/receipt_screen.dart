import 'package:drift/drift.dart' show OrderingTerm;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:eri/core/money.dart';
import 'package:eri/core/time.dart';
import 'package:eri/features/claims_widgets.dart';
import 'package:eri/features/widgets.dart';
import 'package:eri/providers.dart';
import 'package:eri/receipts/receipt.dart';
import 'package:eri/receipts/receipt_service.dart';
import 'package:eri/theme/eri_theme.dart';
import 'package:eri/theme/motion.dart';

/// "Is this screenshot real?" The vendor picks (or shares in) a receipt; Eri reads it on the phone and
/// compares it with the money that actually landed. The bank alert is the proof, never the picture.
class ReceiptScreen extends ConsumerStatefulWidget {
  const ReceiptScreen({super.key, this.sharedPath});

  /// A screenshot shared into Eri from another app ("Share → Eri").
  final String? sharedPath;

  @override
  ConsumerState<ReceiptScreen> createState() => _ReceiptScreenState();
}

class _ReceiptScreenState extends ConsumerState<ReceiptScreen> {
  ReceiptResult? result;
  bool busy = false;
  String? error;

  @override
  void initState() {
    super.initState();
    final p = widget.sharedPath;
    if (p != null) WidgetsBinding.instance.addPostFrameCallback((_) => _checkFile(XFile(p)));
  }

  Future<void> _run(Future<ReceiptResult> Function() f) async {
    setState(() {
      busy = true;
      error = null;
      result = null;
    });
    try {
      final r = await f();
      if (mounted) setState(() => result = r);
    } catch (e) {
      if (mounted) setState(() => error = 'Eri couldn’t read that image. Try another screenshot.');
    } finally {
      if (mounted) setState(() => busy = false);
    }
  }

  Future<void> _checkFile(XFile f) =>
      _run(() async => ref.read(receiptsProvider).checkImage(f.path, await f.readAsBytes()));

  Future<void> _pick() async {
    final f = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (f != null) await _checkFile(f);
  }

  /// Preview / debug only: receipts written from the newest real credit, one honest and one with the amount
  /// edited, so the check can be tried without a phone. Synthetic text.
  Future<void> _sample({required bool edited}) async {
    final db = ref.read(dbProvider);
    final latest =
        await (db.select(db.bankEvents)
              ..where((t) => t.direction.equals('credit'))
              ..orderBy([(t) => OrderingTerm.desc(t.occurredAt)])
              ..limit(1))
            .getSingleOrNull();
    final kobo = (latest?.amountKobo ?? 450000) * (edited ? 10 : 1);
    final when = latest?.occurredAt ?? DateTime.now();
    final text =
        'Transfer receipt\nSuccessful\nAmount  ${naira(kobo)}.00\nSender  ${latest?.counterparty ?? 'TUNDE BAKARE'}\n'
        'Beneficiary  ADAEZE STORES\n${latest?.bank ?? 'Moniepoint'}\n'
        '${when.day} ${const ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'][when.month - 1]} ${when.year} · ${clock(when)}';
    await _run(() => ref.read(receiptsProvider).checkText(text));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Check a receipt')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 32),
        children: [
          const Text(
            'Eri reads the screenshot on this phone and compares it with the money that really landed. The picture never leaves your phone.',
            style: TextStyle(color: EriColors.mutedForeground, height: 1.4),
          ),
          const SizedBox(height: 16),
          PressScale(
            enabled: ocrAvailable && !busy,
            child: FilledButton.icon(
              onPressed: ocrAvailable && !busy ? _pick : null,
              icon: const Icon(Icons.image_outlined),
              label: const Text('Choose a screenshot'),
            ),
          ),
          if (!ocrAvailable)
            const Padding(
              padding: EdgeInsets.only(top: 8),
              child: Text(
                'Reading screenshots works in the Android app. In this preview, try a sample:',
                style: TextStyle(color: EriColors.mutedForeground, fontSize: 13),
              ),
            ),
          if (kIsWeb || kDebugMode) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: busy ? null : () => _sample(edited: false),
                    child: const Text('Sample: real'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    onPressed: busy ? null : () => _sample(edited: true),
                    child: const Text('Sample: edited'),
                  ),
                ),
              ],
            ),
          ],
          const SizedBox(height: 20),
          if (busy)
            const Center(
              child: Padding(padding: EdgeInsets.all(24), child: CircularProgressIndicator()),
            ),
          if (error != null) EriCard(child: Text(error!)),
          // the verdict is the moment: it rises in once, the reasons follow
          if (result != null) EnterOnce(key: ObjectKey(result), child: _VerdictCard(result!)),
        ],
      ),
    );
  }
}

class _VerdictCard extends StatelessWidget {
  const _VerdictCard(this.r);
  final ReceiptResult r;

  @override
  Widget build(BuildContext context) {
    final v = Theme.of(context).extension<EriVerdicts>()!;
    final (label, color, icon) = switch (r.verdict.verdict) {
      Verdict.landed => ('Landed', v.landed, Icons.check_circle),
      Verdict.notReceived => ('Not received', v.notReceived, Icons.cancel),
      Verdict.mismatch => ('Looks edited', v.notReceived, Icons.warning_rounded),
      Verdict.unreadable => ('Can’t read it', v.suspicious, Icons.help),
    };
    final f = r.fields;
    final rows = [
      if (f.amountKobo != null) ('Amount', naira(f.amountKobo!)),
      if (f.sender != null) ('From', f.sender!),
      if (f.bank != null) ('Bank', f.bank!),
      if (f.time != null) ('Time on receipt', '${f.time!.day}/${f.time!.month} · ${clock(f.time!)}'),
    ];
    return EriCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(EriRadius.pill)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: Colors.white, size: 18),
                const SizedBox(width: 6),
                Text(
                  label,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          for (final reason in r.verdict.reasons)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 7),
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(child: Text(reason, style: const TextStyle(height: 1.4))),
                ],
              ),
            ),
          CanaryNote(sender: f.sender, imageHash: r.imageHash),
          if (r.verdict.verdict == Verdict.mismatch || r.verdict.verdict == Verdict.notReceived)
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: WarnVendorsButton(sender: f.sender, imageHash: r.imageHash),
            ),
          if (rows.isNotEmpty) ...[
            const Divider(height: 24),
            const Text('Read from the screenshot', style: TextStyle(color: EriColors.mutedForeground, fontSize: 13)),
            const SizedBox(height: 6),
            for (final (k, val) in rows)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(k, style: const TextStyle(color: EriColors.mutedForeground)),
                    ),
                    Text(
                      val,
                      style: const TextStyle(fontWeight: FontWeight.w600, fontFeatures: tabular),
                    ),
                  ],
                ),
              ),
          ],
        ],
      ),
    );
  }
}
