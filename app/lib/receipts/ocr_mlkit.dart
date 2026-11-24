import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

/// Reads the text on a receipt screenshot with Google ML Kit, ON THE PHONE (no network, the image stays put).
/// Lines that sit on the same visual row are joined ("Amount   ₦25,000.00"), because receipts put the label
/// on the left and the value on the right and ML Kit returns them as separate blocks.
Future<String> ocrImage(String path) async {
  final recognizer = TextRecognizer(script: TextRecognitionScript.latin);
  try {
    final result = await recognizer.processImage(InputImage.fromFilePath(path));
    final lines = [for (final b in result.blocks) ...b.lines]
      ..sort((a, b) => a.boundingBox.top.compareTo(b.boundingBox.top));
    final rows = <List<TextLine>>[];
    for (final l in lines) {
      final mid = l.boundingBox.center.dy;
      final row = rows
          .where((r) => (r.first.boundingBox.center.dy - mid).abs() < r.first.boundingBox.height * 0.5)
          .firstOrNull;
      row == null ? rows.add([l]) : row.add(l);
    }
    return rows
        .map((r) => (r..sort((a, b) => a.boundingBox.left.compareTo(b.boundingBox.left))).map((l) => l.text).join('  '))
        .join('\n');
  } finally {
    await recognizer.close();
  }
}

const ocrAvailable = true;
