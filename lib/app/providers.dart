import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:offset_iterator_persist/offset_iterator_persist.dart';

final storageProvider = Provider<Storage>((ref) => NullStorage());
