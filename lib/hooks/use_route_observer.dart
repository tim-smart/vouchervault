import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fpdt/function.dart';
import 'package:fpdt/option.dart' show Option, None;
import 'package:fpdt/option.dart' as O;

class _RouteObserverHook extends Hook<void> {
  const _RouteObserverHook(
    this.routeObserver, {
    this.didPopNext = const None(),
    this.didPush = const None(),
    this.didPop = const None(),
    this.didPushNext = const None(),
    List<Object?> keys = const [],
  }) : super(keys: keys);

  final RouteObserver<ModalRoute> routeObserver;
  final Option<VoidCallback> didPopNext;
  final Option<VoidCallback> didPush;
  final Option<VoidCallback> didPop;
  final Option<VoidCallback> didPushNext;

  @override
  _RouteObserverHookState createState() => _RouteObserverHookState();
}

class _RouteObserverHookState extends HookState<void, _RouteObserverHook>
    implements RouteAware {
  ModalRoute? _route;

  @override
  void build(BuildContext context) {
    if (_route != null) return;

    _route = ModalRoute.of(context);
    if (_route != null) {
      hook.routeObserver.subscribe(this, _route!);
    }
  }

  @override
  void dispose() {
    if (_route != null) {
      hook.routeObserver.unsubscribe(this);
    }
  }

  void didPopNext() {
    hook.didPopNext.chain(O.map((f) => f()));
  }

  void didPush() {
    hook.didPush.chain(O.map((f) => f()));
  }

  void didPop() {
    hook.didPop.chain(O.map((f) => f()));
  }

  void didPushNext() {
    hook.didPushNext.chain(O.map((f) => f()));
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
  use(_RouteObserverHook(
    routeObserver,
    didPop: didPop,
    didPopNext: didPopNext,
    didPush: didPush,
    didPushNext: didPushNext,
    keys: keys,
  ));
}
