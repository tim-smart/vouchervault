import 'dart:async';
import 'dart:io';

import 'package:bloc_stream/bloc_stream.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:screen/screen.dart';
import 'package:vouchervault/hooks/use_route_observer.dart';

class _BrightnessBloc extends BlocStream<Option<double>> {
  _BrightnessBloc({this.enabled = true}) : super(none());
  final bool enabled;
}

typedef _BrightnessAction = FutureOr<void> Function(
    _BrightnessBloc, void Function(Option<double>));

Future<double> _getBrightness() =>
    Platform.isAndroid ? Future.value(-1) : Screen.brightness;

_BrightnessAction _goDark() =>
    (b, add) => b.value.filter((_) => b.enabled).fold(
          () => Future.microtask(() {}),
          (brightness) =>
              Screen.setBrightness(brightness).then((_) => add(none())),
        );

_BrightnessAction _goBright() => (b, add) async {
      if (!b.enabled) return;
      final brightness = await _getBrightness();
      await Screen.setBrightness(1);
      add(some(brightness));
    };

_BrightnessAction _close() => (b, add) => b.close();

void useFullBrightness(
  RouteObserver<ModalRoute> routeObserver, {
  bool enabled = true,
}) {
  final bloc = useMemoized(() => _BrightnessBloc(enabled: enabled));

  useEffect(() {
    bloc.add(_goBright());
    return () {
      bloc.add(_goDark());
      bloc.add(_close());
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
