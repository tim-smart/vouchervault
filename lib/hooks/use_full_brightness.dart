import 'package:brightness_volume/brightness_volume.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:offset_iterator_riverpod/offset_iterator_riverpod.dart';
import 'package:vouchervault/hooks/use_route_observer.dart';

StateIterator<bool> _brighnessIterator() => StateIterator(initialState: false);

typedef _BrightnessAction = StateIteratorAction<bool>;

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
  final iter = useMemoized(() => _brighnessIterator(), []);
  useEffect(() {
    iter.iterator.run();
  }, [iter]);

  useEffect(() {
    iter.add(_goBright(enabled));
    return () {
      iter.add(_goDark());
      iter.close();
    };
  }, [iter, enabled]);

  // If something gets pushed on top of the route, then go dark again.
  useRouteObserver(
    routeObserver,
    didPushNext: some(() {
      iter.add(_goDark());
    }),
    didPopNext: some(() {
      iter.add(_goBright(enabled));
    }),
    keys: [iter, enabled],
  );
}
