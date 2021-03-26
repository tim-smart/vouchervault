import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class _RouteCallbacks with RouteAware {
  const _RouteCallbacks({
    this.handleDidPopNext = const None(),
    this.handleDidPush = const None(),
    this.handleDidPop = const None(),
    this.handleDidPushNext = const None(),
  });

  final Option<VoidCallback> handleDidPopNext;
  final Option<VoidCallback> handleDidPush;
  final Option<VoidCallback> handleDidPop;
  final Option<VoidCallback> handleDidPushNext;

  @override
  void didPopNext() {
    handleDidPopNext.map((f) => f());
  }

  @override
  void didPush() {
    handleDidPush.map((f) => f());
  }

  @override
  void didPop() {
    handleDidPop.map((f) => f());
  }

  @override
  void didPushNext() {
    handleDidPushNext.map((f) => f());
  }
}

void useRouteObserver(
  RouteObserver<ModalRoute> routeObserver, {
  Option<VoidCallback> didPopNext = const None(),
  Option<VoidCallback> didPush = const None(),
  Option<VoidCallback> didPop = const None(),
  Option<VoidCallback> didPushNext = const None(),
  List<Object?> keys = const [],
}) {
  final context = useContext();
  final route = ModalRoute.of(context);

  useEffect(() {
    if (route == null) return () {};

    final callbacks = _RouteCallbacks(
      handleDidPop: didPop,
      handleDidPopNext: didPopNext,
      handleDidPush: didPush,
      handleDidPushNext: didPushNext,
    );
    routeObserver.subscribe(callbacks, route);
    return () => routeObserver.unsubscribe(callbacks);
  }, [route, routeObserver, ...keys]);
}
