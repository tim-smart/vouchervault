import 'package:brightness_volume/brightness_volume.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_bloc_stream/riverpod_bloc_stream.dart';
import 'package:vouchervault/hooks/use_route_observer.dart';

class _BrightnessBloc extends BlocStream<bool> {
  _BrightnessBloc() : super(false);
}

typedef _BrightnessAction = BlocStreamAction<bool>;

_BrightnessAction _goDark() => (value, add) =>
    value ? BVUtils.resetCustomBrightness().then((_) => add(false)) : null;

_BrightnessAction _goBright(bool enabled) => (value, add) {
      if (!enabled) return null;
      return BVUtils.setBrightness(1).then((_) => add(true));
    };

void useFullBrightness(
  RouteObserver<ModalRoute> routeObserver, {
  bool enabled = true,
}) {
  final bloc = useMemoized(() => _BrightnessBloc(), []);

  useEffect(() {
    bloc.add(_goBright(enabled));
    return () {
      bloc.add(_goDark());
      bloc.close();
    };
  }, [bloc, enabled]);

  // If something gets pushed on top of the route, then go dark again.
  useRouteObserver(
    routeObserver,
    didPushNext: some(() {
      bloc.add(_goDark());
    }),
    didPopNext: some(() {
      bloc.add(_goBright(enabled));
    }),
    keys: [bloc, enabled],
  );
}
