//
//
//

import 'package:window_observer_example/src/view.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  final imperial = !kIsWeb && true;
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //
  @override
  Widget build(BuildContext context) {
    if (widget.imperial) {
      return MaterialApp(
        title: 'Demo App',
        routes: {
          '/': (_) => const HomePage(),
          '/page1': (_) => const Page1(),
          '/page2': (_) => const Page2(),
          '/page3': (_) => const Page3(),
          '/page4': (_) => const Page4(),
          '/page5': (_) => const Page5(),
          '/page6': (_) => const Page6(),
          '/page7': (_) => const Page7(),
          '/page8': (_) => const Page8(),
          '/page9': (_) => const Page9(),
        },
        navigatorObservers: [StateXRouteObserver.routeObserver!],
      );
    } else {
      return MaterialApp.router(
        title: 'Demo App',
        routerConfig: GoRouter(
          routes: <RouteBase>[
            GoRoute(
              path: '/',
              builder: (BuildContext context, GoRouterState state) {
                return const HomePage();
              },
            ),
            GoRoute(
              path: '/page1',
              builder: (BuildContext context, GoRouterState state) {
                return const Page1();
              },
            ),
            GoRoute(
              path: '/page2',
              builder: (BuildContext context, GoRouterState state) {
                return const Page2();
              },
            ),
            GoRoute(
              path: '/page3',
              builder: (BuildContext context, GoRouterState state) {
                return const Page3();
              },
            ),
            GoRoute(
              path: '/page4',
              builder: (BuildContext context, GoRouterState state) {
                return const Page4();
              },
            ),
            GoRoute(
              path: '/page5',
              builder: (BuildContext context, GoRouterState state) {
                return const Page5();
              },
            ),
            GoRoute(
              path: '/page6',
              builder: (BuildContext context, GoRouterState state) {
                return const Page6();
              },
            ),
            GoRoute(
              path: '/page7',
              builder: (BuildContext context, GoRouterState state) {
                return const Page7();
              },
            ),
            GoRoute(
              path: '/page8',
              builder: (BuildContext context, GoRouterState state) {
                return const Page8();
              },
            ),
            GoRoute(
              path: '/page9',
              builder: (BuildContext context, GoRouterState state) {
                return const Page9();
              },
            ),
          ],
          debugLogDiagnostics: true,
        ),
      );
    }
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    assert(() {
      if (kDebugMode) {
        print('###########  build() in $this');
      }
      return true;
    }());
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(bottom: 90),
              child: Text(
                'Home',
                style: TextStyle(fontSize: 50),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: ElevatedButton(
                onPressed: () async {
                  final app =
                      context.findAncestorWidgetOfExactType<MaterialApp>()!;
                  if (app.routerDelegate == null && app.routerConfig == null) {
                    await Navigator.pushNamed(context, '/page1');
                  } else {
                    final router = GoRouter.of(context);
                    router.push('/page1');
                  }
                },
                child: const Text('Page 1'),
              ),
            ),
          ],
        ),
      ),
    );
  }
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
