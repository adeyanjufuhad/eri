import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eri/receipts/share_stub.dart' if (dart.library.io) 'package:eri/receipts/share_io.dart' as impl;

/// "Share → Eri" listener, behind a provider so tests (no platform plugins) can replace it.
final sharedImagesProvider = Provider<void Function() Function(void Function(String path) onImage)>(
  (_) => impl.listenForSharedImages,
);
