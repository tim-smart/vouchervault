import 'package:flutter/material.dart' hide Action;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fpdt/fpdt.dart';
import 'package:fpdt/option.dart';
import 'package:fpdt/state_reader_task_either.dart' as SRTE;
import 'package:screen_brightness/screen_brightness.dart';
import 'package:vouchervault/hooks/hooks.dart';

void useFullBrightness(
  RouteObserver<ModalRoute> routeObserver, {
  bool enabled = true,
}) {
  final bloc = useMemoized(() => _createSM(enabled), [enabled]);

  useEffect(() {
    if (enabled) {
      bloc.evaluate(_goBright);
    }

    return () {
      bloc.evaluate(_goDark);
      bloc.close();
    };
  }, [bloc, enabled]);

  // If something gets pushed on top of the route, then go dark again.
  useRouteObserver(
    routeObserver,
    didPushNext: some(() {
      bloc.evaluate(_goDark);
    }),
    didPopNext: some(() {
      if (!enabled) return;
      bloc.evaluate(_goBright);
    }),
    keys: [bloc, enabled],
  );
}

// State
StateRTEMachine<bool, ScreenBrightness, String> _createSM(bool initial) =>
    StateRTEMachine(initial, ScreenBrightness());

typedef _BrightnessOp<R>
    = StateReaderTaskEither<bool, ScreenBrightness, String, R>;
_BrightnessOp<bool> _get() => SRTE.get();
_BrightnessOp<ScreenBrightness> _ask() => SRTE.ask();

final _goDark = _get().p(SRTE.call(_reset)).p(SRTE.chainPut(false));
final _goBright = _get().p(SRTE.call(_fullBrightness)).p(SRTE.chainPut(true));

_BrightnessOp<Unit> _set(double brightness) => _ask()
    .p(SRTE.chainTryCatchK(
      (s) => s.setScreenBrightness(brightness),
      (err, stackTrace) => 'Could not set brightness: $err',
    ))
    .p(SRTE.call(SRTE.right(unit)));

final _fullBrightness = _set(1);

final _BrightnessOp<Unit> _reset = _ask()
    .p(SRTE.chainTryCatchK(
      (s) => s.resetScreenBrightness(),
      (err, stackTrace) => 'Could not reset brightness $err',
    ))
    .p(SRTE.call(SRTE.right(unit)));
