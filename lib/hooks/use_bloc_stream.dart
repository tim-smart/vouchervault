import 'package:bloc_stream/bloc_stream.dart';
import 'package:flutter_bloc_stream/flutter_bloc_stream.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

B useBlocStream<B extends BlocStream>() {
  final context = useContext();
  return useMemoized(() => BlocStreamProvider.of<B>(context));
}
