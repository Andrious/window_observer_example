//
//
//

import 'package:window_observer_example/src/view.dart';

class MyApp extends AppStatefulWidget {
  //StatefulWidget {
  MyApp({super.key});

  // The Route Delegate
  static final routerDelegate = AppRouterDelegate(PageRoutes());

  /// Go to the next route
  static void nextRoute(BuildContext context) {
    final state = context.findRootAncestorStateOfType<_MyAppState>();
    state?.nextRoute(context);
  }

  // @override
  // State createState() =>  _MyAppState();

  @override
  AppState<StatefulWidget> createAppState() => _MyAppState();
}

class _MyAppState extends AppState<MyApp> {
  _MyAppState()
      : super(
          title: 'Demo App',
          routerConfig: GoRouter(
            routes: <RouteBase>[
              GoRoute(
                path: '/',
                builder: (BuildContext context, GoRouterState state) {
                  return Page1(key: UniqueKey());
                },
                routes: <RouteBase>[
                  GoRoute(
                    path: 'page2',
                    builder: (BuildContext context, GoRouterState state) {
                      return const Page2();
                    },
                    routes: <RouteBase>[
                      GoRoute(
                        path: 'page3',
                        builder: (BuildContext context, GoRouterState state) {
                          return const Page3();
                        },
                        routes: <RouteBase>[
                          GoRoute(
                            path: 'page4',
                            builder:
                                (BuildContext context, GoRouterState state) {
                              return const Page4();
                            },
                            routes: <RouteBase>[
                              GoRoute(
                                path: 'page5',
                                builder: (BuildContext context,
                                    GoRouterState state) {
                                  return const Page5();
                                },
                                routes: <RouteBase>[
                                  GoRoute(
                                    path: 'page6',
                                    builder: (BuildContext context,
                                        GoRouterState state) {
                                      return const Page6();
                                    },
                                    routes: <RouteBase>[
                                      GoRoute(
                                        path: 'page7',
                                        builder: (BuildContext context,
                                            GoRouterState state) {
                                          return const Page7();
                                        },
                                        routes: <RouteBase>[
                                          GoRoute(
                                            path: 'page8',
                                            builder: (BuildContext context,
                                                GoRouterState state) {
                                              return const Page8();
                                            },
                                            routes: <RouteBase>[
                                              GoRoute(
                                                path: 'page9',
                                                builder: (BuildContext context,
                                                    GoRouterState state) {
                                                  return const Page9();
                                                },
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );

  // @override
  // Widget buildIn(BuildContext context) => const MaterialApp(
  //       home: Page1(),
  //     );

  //  @override
  //   Widget buildIn(BuildContext context) => MaterialApp(
  //         home: Page1(key: UniqueKey()),
  //       );

  // @override
  // Widget buildIn(BuildContext context) => MaterialApp.router(
  //       routerDelegate: MyApp.routerDelegate,
  //       routeInformationParser:
  //           AppRouterInformationParser(PageRoutes().widgets),
  //     );

  /// Simply turn to the Router and determine the next page to go to.
  void nextRoute(BuildContext context) {
    //
    String path = '';
    RouteBase? routeBase;
    final router = GoRouter.of(context);
    final matches = router.routerDelegate.currentConfiguration.matches;
    if (matches.isNotEmpty) {
      final routeMatch = matches.last;
      path = routeMatch.subloc;
      var routes = routeMatch.route.routes;
      if (routes.isNotEmpty) {
        routeBase = routes.first;
      }
      for (final routeMatch in matches) {
        path = routeMatch.subloc;
        // Determine if this is a recursive path and find the next path
        var routes = routeMatch.route.routes;
        if (routes.isNotEmpty) {
          routeBase = routes.first;
        }
      }
    }
    if (routeBase != null) {
      final goRoute = routeBase as GoRoute;
      path = '$path/${goRoute.path}';
      path = path.replaceAll('//', '/');
      router.go(path);
    }
  }

// /// The State object is no longer in paused state and now receptive to user input.
// /// The application is visible again.
// @override
// void resumedAppLifecycleState() {
//   setState(() {});
// }
}

class PageRoutes extends AppPages {
  factory PageRoutes() => _this ??= PageRoutes._();
  PageRoutes._()
      : super({
          '1': Page1(key: UniqueKey()),
          '2': const Page2(),
          '3': const Page3(),
          '4': const Page4(),
          '5': const Page5(),
          '6': const Page6(),
          '7': const Page7(),
          '8': const Page8(),
          '9': const Page9(),
        });
  static PageRoutes? _this;
}

class Page1 extends CounterWidget {
  const Page1({super.key, super.title = 'Page 1'});
  @override
  State<StatefulWidget> createState() => _Page1State();
}

class _Page1State extends CounterState<Page1> {
  @override
  void initState() {
    // Supply the next page
    nextWidget = '2';
    super.initState();
  }
}

/// The second page displayed in this app.
class Page2 extends CounterWidget {
  const Page2({super.key, super.title = 'Page 2'});
  @override
  State<StatefulWidget> createState() => _Page2State();
}

class _Page2State extends CounterState<Page2> {
  @override
  void initState() {
    prevWidget = '1';
    nextWidget = '3';
    super.initState();
  }
}

/// The second page displayed in this app.
class Page3 extends CounterWidget {
  const Page3({super.key, super.title = 'Page 3'});
  @override
  State<StatefulWidget> createState() => _Page3State();
}

class _Page3State extends CounterState<Page3> {
  @override
  void initState() {
    prevWidget = '2';
    nextWidget = '4';
    super.initState();
  }
}

/// The second page displayed in this app.
class Page4 extends CounterWidget {
  const Page4({super.key, super.title = 'Page 4'});
  @override
  State<StatefulWidget> createState() => _Page4State();
}

class _Page4State extends CounterState<Page4> {
  @override
  void initState() {
    prevWidget = '3';
    nextWidget = '5';
    super.initState();
  }
}

/// The second page displayed in this app.
class Page5 extends CounterWidget {
  const Page5({super.key, super.title = 'Page 5'});
  @override
  State<StatefulWidget> createState() => _Page5State();
}

class _Page5State extends CounterState<Page5> {
  @override
  void initState() {
    prevWidget = '4';
    nextWidget = '6';
    super.initState();
  }
}

/// The second page displayed in this app.
class Page6 extends CounterWidget {
  const Page6({super.key, super.title = 'Page 6'});
  @override
  State<StatefulWidget> createState() => _Page6State();
}

class _Page6State extends CounterState<Page6> {
  @override
  void initState() {
    prevWidget = '5';
    nextWidget = '7';
    super.initState();
  }
}

/// The second page displayed in this app.
class Page7 extends CounterWidget {
  const Page7({super.key, super.title = 'Page 7'});
  @override
  State<StatefulWidget> createState() => _Page7State();
}

class _Page7State extends CounterState<Page7> {
  @override
  void initState() {
    prevWidget = '6';
    nextWidget = '8';
    super.initState();
  }
}

/// The second page displayed in this app.
class Page8 extends CounterWidget {
  const Page8({super.key, super.title = 'Page 8'});
  @override
  State<StatefulWidget> createState() => _Page8State();
}

class _Page8State extends CounterState<Page8> {
  @override
  void initState() {
    prevWidget = '7';
    nextWidget = '9';
    super.initState();
  }
}

/// The second page displayed in this app.
class Page9 extends CounterWidget {
  const Page9({super.key, super.title = 'Page 9'});
  @override
  State<StatefulWidget> createState() => _Page9State();
}

class _Page9State extends CounterState<Page9> {
  @override
  void initState() {
    prevWidget = '8';
    super.initState();
  }
}
