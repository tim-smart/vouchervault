import 'package:bloc_stream/bloc_stream.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:vouchervault/hooks/use_bloc_stream.dart';

S useBlocStreamState<B extends BlocStream<S>, S>() {
  final bloc = useBlocStream<B>();
  final state = useStream(bloc.skip(1), initialData: bloc.value);
  return state.data;
}
