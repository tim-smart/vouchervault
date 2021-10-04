import 'dart:async';

import 'package:bloc_stream/bloc_stream.dart';
import 'package:brightness_volume/brightness_volume.dart';
import 'package:fpdart/fpdart.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:vouchervault/hooks/use_route_observer.dart';

class _BrightnessBloc extends BlocStream<bool> {
  _BrightnessBloc({this.enabled = true}) : super(false);
  final bool enabled;
}

typedef _BrightnessAction = Action<_BrightnessBloc, bool>;

_BrightnessAction _goDark() => (b, add) => b.value
    ? BVUtils.resetCustomBrightness().then((_) => add(false))
    : Future.value();

_BrightnessAction _goBright() => (b, add) async {
      if (!b.enabled) return;
      await BVUtils.setBrightness(1);
      add(true);
    };

void useFullBrightness(
  RouteObserver<ModalRoute> routeObserver, {
  bool enabled = true,
}) {
  final bloc = useMemoized(() => _BrightnessBloc(enabled: enabled), [enabled]);

  useEffect(() {
    bloc.add(_goBright());
    return () {
      bloc.add(_goDark());
      bloc.close();
    };
  }, [bloc]);

  // If something gets pushed on top of the route, then go dark again.
  useRouteObserver(
    routeObserver,
    didPushNext: some(() {
      bloc.add(_goDark());
    }),
    didPopNext: some(() {
      bloc.add(_goBright());
    }),
    keys: [bloc],
  );
}
