import 'package:brightness_volume/brightness_volume.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fpdt/fpdt.dart';
import 'package:fpdt/option.dart';
import 'package:fpdt/state_reader_task_either.dart' as SRTE;
import 'package:fpdt/task_either.dart' as TE;
import 'package:vouchervault/hooks/use_route_observer.dart';

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
StateRTEMachine<bool, void, String> _createSM(bool initial) =>
    StateRTEMachine(initial, null);

typedef _BrightnessOp<R> = StateReaderTaskEither<bool, void, String, R>;
_BrightnessOp<bool> _get() => SRTE.get();

final _set = TE.tryCatchK(
  (double brightness) => BVUtils.setBrightness(brightness),
  (err, stackTrace) => 'Could not set brightness: $err',
);

final _reset = TE.tryCatch(
  () => BVUtils.resetCustomBrightness(),
  (err, stackTrace) => 'Could not reset brightness $err',
);

final _goDark =
    _get().p(SRTE.flatMapTaskEither((_) => _reset)).p(SRTE.chainPut(false));

final _goBright =
    _get().p(SRTE.flatMapTaskEither((_) => _set(1))).p(SRTE.chainPut(true));
