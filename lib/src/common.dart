/*
//
//   Superclass for CounterState
//

import 'package:window_observer_example/src/_imports.dart';

abstract class StatefulStateWidget extends StatefulWidget {
  const StatefulStateWidget({super.key, this.title});
  final String? title;

  @override
  State<StatefulWidget> createState();
}

// ignore: prefer_mixin
abstract class StateXXXX<T extends StatefulStateWidget> extends State<T>
    with RouteAware
    implements WidgetsBindingObserver {
  StateXXXX() : stateRouteObserver = StateXRouteObserver() {
    currentState = this;
  }

  final StateXRouteObserver stateRouteObserver;

  static late StateXXXX currentState;

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

  @override
  void initState() {
    super.initState();
    // Registers the given object as a binding observer. Binding
    // observers are notified when various application events occur
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Subscribe this to be informed about changes to route.
    stateRouteObserver.subscribe(this);
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

  @override
  void activate() {
    super.activate();
    // Register this given observer.
    WidgetsBinding.instance.addObserver(this);
    // Subscribe this to be informed about changes to route.
    stateRouteObserver.subscribe(this);
  }

  @override
  void deactivate() {
    super.deactivate();
    // Unregisters this given observer.
    WidgetsBinding.instance.removeObserver(this);
    // No longer informed about changes to its route.
    stateRouteObserver.unsubscribe(this);
  }

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

  // Called when the top route has been popped off, and the current route shows up.
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
        inactiveAppLifecycleState();
        break;
      case AppLifecycleState.paused:
        pausedAppLifecycleState();
        break;
      case AppLifecycleState.detached:
        detachedAppLifecycleState();
        break;
      case AppLifecycleState.resumed:
        resumedAppLifecycleState();
        break;
      default:
        unknownAppLifecycleState();
    }
    if (kDebugMode) {
      print(
          '########### ${state.toString().replaceFirst('AppLifecycleState.', '')} in $this');
    }
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

  /// Subclasses are encouraged to implement these methods
  /// so to handle their corresponding events.
  ///
  void inactiveAppLifecycleState() {
    /// The State object is set to an inactive state and is not receiving user input.
    /// The pause state is likely to occur soon after.
  }

  void pausedAppLifecycleState() {
    /// The application is not currently visible to the user, not responding to
    /// user input, and running in the background.
  }

  void detachedAppLifecycleState() {
    /// The State object is detached from the widget tree.
    /// It very likely the dispose() function will be called sometime later.
  }

  void resumedAppLifecycleState() {
    /// The State object is no longer in paused state and now receptive to user input.
    /// The application is visible again.
  }

  void unknownAppLifecycleState() {
    /// This should never be called, but there you are.
  }
}

/// A helper class. Manages the use of a RouteObserver that subscribes State objects.
class StateXRouteObserver {
  StateXRouteObserver() {
    // Only need to instantiate once.
    routeObserver ??= RouteObserver<PageRoute>();
  }
  // Supply the means to 'observe' the Flutter's routing mechanism
  static RouteObserver<PageRoute>? routeObserver;

  bool subscribe(State state) {
    bool subscribed = state is RouteAware;
    if (subscribed) {
      final modelRoute = ModalRoute.of(state.context);
      subscribed = modelRoute != null && modelRoute is PageRoute;
      if (subscribed) {
        final latest = modelRoute.isActive;
        // So to be informed when there are changes to route.
        routeObserver?.subscribe(state as RouteAware, modelRoute);
      }
    }
    return subscribed;
  }

  bool unsubscribe(State state) {
    bool subscribed = state is RouteAware;
    if (subscribed) {
      routeObserver?.unsubscribe(state as RouteAware);
    }
    return subscribed;
  }
}
*/
