//
//   Superclass for CounterState
//

import 'dart:ui' show AppExitResponse;

import 'package:window_observer_example/src/view.dart';

// ignore: prefer_mixin
abstract class StateX<T extends StatefulWidget> extends State<T>
    with RouteAware
    implements WidgetsBindingObserver {
  StateX() : stateRouteObserver = StateXRouteObserver() {
    currentState = this;
  }

  final StateXRouteObserver stateRouteObserver;

  static late StateX currentState;

  // Whether the State object will remain active.
  static bool? keepActive = true;

  // Indicating if this State object is currently actively visible to the user.
  bool get canSetState => _canSetState;

  set canSetState(bool? set) {
    if (set != null) {
      if (keepActive!) {
        _canSetState = true;
      } else {
        _canSetState = set;
      }
    }
  }

  // Allow the setState() method to fire.
  bool _canSetState = true;

  /// Simply turn to the Router and determine the next page to go to.
  void nextRoute(String path) {
    //
    if (router == null) {
      Navigator.pushNamed(context, path);
    } else {
      router?.push(path);
    }
  }

  @override
  void initState() {
    super.initState();
    // Registers the given object as a binding observer. Binding
    // observers are notified when various application events occur
    WidgetsBinding.instance.addObserver(this);
    app ??= context.findAncestorWidgetOfExactType<MaterialApp>()!;
  }

  static MaterialApp? app;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // // Subscribe this to be informed about changes to route.
    // stateRouteObserver.subscribe(this);
    if (app!.routerDelegate != null || app!.routerConfig != null) {
      router ??= GoRouter.of(context);
    }
  }

  // Used to navigate from screen to screen.
  static GoRouter? router;

  @override
  void dispose() {
    super.dispose();
  }

  /// Determine if the setState() method should be called.
  @override
  void setState(VoidCallback fn) {
    if (canSetState && mounted) {
      super.setState(fn);
      if (kDebugMode) {
        print('########### setState() in $this');
      }
    }
  }

  /// Implement this
  @override
  Widget build(BuildContext context);

  /// This is not reliable in that any other 'observer' happens to return true
  /// will prevent this function from firing.  Use RouteObserver instead.
  @override
  Future<bool> didPopRoute() async {
    if (kDebugMode) {
      print('###########  didPopRoute() in $this');
    }
    return false;
  }

  /// This is not reliable in that any other 'observer' happens to return true
  /// will prevent this function from firing.  Use RouteObserver instead.
  @override
  Future<bool> didPushRoute(String route) async {
    if (kDebugMode) {
      print('###########  didPushRoute() in $this');
    }
    return false;
  }

  @override
  Future<bool> didPushRouteInformation(RouteInformation routeInformation) {
    if (kDebugMode) {
      print('###########  didPushRouteInformation() in $this');
    }
    return didPushRoute(routeInformation.location!);
  }

  // Called when the top route has been popped off, and this route now is visible.
  @override
  void didPopNext() {
    if (kDebugMode) {
      print('###########  didPopNext() in $this');
    }
    currentState = this;
  }

  // Called when the current route has been pushed.
  @override
  void didPush() {
    if (kDebugMode) {
      print('###########  didPush() in $this');
    }
    currentState = this;
  }

  // Called when the current route has been popped off.
  @override
  void didPop() {
    if (kDebugMode) {
      print('###########  didPop() in $this');
    }
  }

  // Called when a new route has been pushed, and the current route is no longer visible.
  @override
  void didPushNext() {
    if (kDebugMode) {
      print('###########  didPushNext() in $this');
    }
  }

  @override
  void didChangeMetrics() {
    if (kDebugMode) {
      print('###########  didChangeMetrics() in $this');
    }
  }

  @override
  void didChangeTextScaleFactor() {
    if (kDebugMode) {
      print('###########  didChangeTextScaleFactor() in $this');
    }
  }

  @override
  void didChangePlatformBrightness() {
    /// Brightness changed.
    if (kDebugMode) {
      print('###########  didChangePlatformBrightness() in $this');
    }
  }

  @override
  void didChangeLocales(List<Locale>? locales) {
    /// Locale changed.
    if (kDebugMode) {
      print('###########  didChangeLocales() in $this');
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    /// First, process the State object's own event functions.
    switch (state) {
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.resumed:
        break;
      default:
    }
    if (kDebugMode) {
      print(
          '########### ${state.toString().replaceFirst('AppLifecycleState.', '')} in $this');
    }
  }

  @override
  Future<AppExitResponse> didRequestAppExit() async {
    if (kDebugMode) {
      print('###########  didRequestAppExit() in $this');
    }
    return AppExitResponse.exit;
  }

  @override
  void didHaveMemoryPressure() {
    if (kDebugMode) {
      print('###########  didHaveMemoryPressure() in $this');
    }
  }

  @override
  void didChangeAccessibilityFeatures() {
    if (kDebugMode) {
      print('###########  didChangeAccessibilityFeatures() in $this');
    }
  }
}

///
abstract class StatefulXWidget extends StatefulWidget {
  ///
  const StatefulXWidget({super.key});

  @override
  StatefulElement createElement() => StatefulXElement(this);
}

///
class StatefulXElement extends StatefulElement {
  ///
  StatefulXElement(super.widget);

  @override
  void didChangeDependencies() {
    if (kDebugMode) {
      print('###########  didChangeDependencies() in $this');
    }
    super.didChangeDependencies();
  }

  @override
  void markNeedsBuild() {
    if (kDebugMode) {
      print('###########  markNeedsBuild() in $this');
    }
    super.markNeedsBuild();
  }

  // @override
  // InheritedWidget dependOnInheritedElement(Element ancestor, {Object? aspect}) {
  //   if (kDebugMode) {
  //     print('###########  dependOnInheritedElement() in $this with $ancestor');
  //   }
  //   return super.dependOnInheritedElement(ancestor, aspect: aspect);
  // }

  @override
  void performRebuild() => super.performRebuild();

  @override
  void update(StatefulWidget newWidget) => super.update(newWidget);

  @override
  Element? updateChild(Element? child, Widget? newWidget, Object? newSlot) =>
      super.updateChild(child, newWidget, newSlot);
}

/// A helper class. Manages the use of a RouteObserver that subscribes State objects.
class StateXRouteObserver {
  // Supply the means to 'observe' the Flutter's routing mechanism
  static RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

  bool subscribe(State state) {
    bool subscribed = state is RouteAware;
    if (subscribed) {
      final modelRoute = ModalRoute.of(state.context);
      subscribed = modelRoute != null && modelRoute is PageRoute;
      if (subscribed) {
        // So to be informed when there are changes to route.
        routeObserver.subscribe(state as RouteAware, modelRoute);
      }
    }
    return subscribed;
  }

  bool unsubscribe(State state) {
    bool subscribed = state is RouteAware;
    if (subscribed) {
      routeObserver.unsubscribe(state as RouteAware);
    }
    return subscribed;
  }
}
