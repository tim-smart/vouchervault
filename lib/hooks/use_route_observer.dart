import 'package:flutter/widgets.dart';
import 'package:flutter_elemental/flutter_elemental.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class _RouteObserverHook extends Hook<void> {
  const _RouteObserverHook(
    this.routeObserver, {
    this.didPopNext = const Option.none(),
    this.didPush = const Option.none(),
    this.didPop = const Option.none(),
    this.didPushNext = const Option.none(),
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

  @override
  void didPopNext() {
    hook.didPopNext.map((f) => f());
  }

  @override
  void didPush() {
    hook.didPush.map((f) => f());
  }

  @override
  void didPop() {
    hook.didPop.map((f) => f());
  }

  @override
  void didPushNext() {
    hook.didPushNext.map((f) => f());
  }
}

void useRouteObserver(
  RouteObserver<ModalRoute> routeObserver, {
  Option<VoidCallback> didPopNext = const Option.none(),
  Option<VoidCallback> didPush = const Option.none(),
  Option<VoidCallback> didPop = const Option.none(),
  Option<VoidCallback> didPushNext = const Option.none(),
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
