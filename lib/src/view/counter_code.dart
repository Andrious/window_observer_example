//
//     Superclass for the Counters
//

import 'package:window_observer_example/src/view.dart';

abstract class CounterWidget extends StatefulWidget {
  const CounterWidget({super.key, this.title});
  final String? title;
  @override
  State<StatefulWidget> createState();
}

/// Supplies a counter and interface to the widgets above.
abstract class CounterState<T extends CounterWidget> extends StateX<T> {
  //
  int _counter = 0;

  // Subclass will assign a value
  String? prevWidget;
  String? nextWidget;

  final row = <Widget>[];

  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      print('###########  initState() in $this');
    }
    // final state = widget.prevState;
    // if (state == null) {
    //   row.add(const SizedBox());
    // } else {
    if (prevWidget != null) {
      row.add(_prevButton(prevWidget!));
    }
//    }
    if (nextWidget == null) {
      row.add(const SizedBox());
    } else {
      row.add(_nextButton(nextWidget!));
    }
  }

  @override
  void activate() {
    super.activate();
    if (kDebugMode) {
      print('###########  activate() in $this');
    }
  }

  @override
  void deactivate() {
    super.deactivate();
    if (kDebugMode) {
      print('###########  deactivate() in $this');
    }
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (kDebugMode) {
      print('###########  didUpdateWidget() in $this');
    }
  }

  @override
  void dispose() {
    if (kDebugMode) {
      print('###########  dispose() in $this');
    }
    super.dispose();
  }

  /// The State object is set to an inactive state and is not receiving user input.
  /// The pause state is likely to occur soon after.
  @override
  void inactiveLifecycleState() {
    if (kDebugMode) {
      print('###########  inactiveLifecycleState() in $this');
    }
  }

  /// The application is not currently visible to the user, not responding to
  /// user input, and running in the background.
  @override
  void pausedLifecycleState() {
    if (kDebugMode) {
      print('###########  pausedLifecycleState() in $this');
    }
  }

  /// The State object is detached from the widget tree.
  /// It very likely the dispose() function will be called sometime later.
  @override
  void detachedLifecycleState() {
    if (kDebugMode) {
      print('###########  detachedLifecycleState() in $this');
    }
  }

  /// The State object is no longer in paused state and now receptive to user input.
  /// The application is visible again.
  @override
  void resumedLifecycleState() {
    if (kDebugMode) {
      print('###########  resumedLifecycleState() in $this');
    }
  }

  // Called when the top route has been popped off, and the current route shows up.
  @override
  void didPopNext() {
    super.didPopNext();
    if (kDebugMode) {
      print('###########  didPopNext() in $this');
    }
  }

  // Called when the current route has been pushed.
  @override
  void didPush() {
    super.didPush();
    if (kDebugMode) {
      print('###########  didPush() in $this');
    }
  }

  // Called when the current route has been popped off.
  @override
  void didPop() {
    super.didPop();
    if (kDebugMode) {
      print('###########  didPop() in $this');
    }
  }

  // Called when a new route has been pushed, and the current route is no longer visible.
  @override
  void didPushNext() {
    super.didPushNext();
    if (kDebugMode) {
      print('###########  didPushNext() in $this');
    }
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    if (kDebugMode) {
      print('###########  didChangeMetrics() in $this');
    }
  }

  @override
  void didChangeTextScaleFactor() {
    super.didChangeTextScaleFactor();
    if (kDebugMode) {
      print('###########  didChangeTextScaleFactor() in $this');
    }
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();

    /// Brightness changed.
    if (kDebugMode) {
      print('###########  didChangePlatformBrightness() in $this');
    }
  }

  @override
  void didChangeLocales(List<Locale>? locales) {
    super.didChangeLocales(locales);
    if (kDebugMode) {
      print('###########  didChangeLocales() in $this');
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (kDebugMode) {
      print('###########  didChangeDependencies() in $this');
    }
  }

  @override
  void reassemble() {
    super.reassemble();
    if (kDebugMode) {
      print('###########  reassemble() in $this');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print('###########  build() in $this   counter: $_counter');
    }
    return Scaffold(
      appBar: AppBar(title: Text(widget.title ?? '')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 90),
                child: Text(
                  widget.title ?? '',
                  style: const TextStyle(fontSize: 50),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Text('You have pushed the button this many times:'),
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            if (row.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: row,
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => _counter++),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _prevButton(String title) => Flexible(
        child: ElevatedButton(
          key: Key(title),
          onPressed: () async {
            Navigator.pop(context);
          },
          child: Text('Page $title'),
        ),
      );

  Widget _nextButton(String widget) => Flexible(
        child: ElevatedButton(
          onPressed: () {
            // State object is no longer the 'active' State object.
//            canSetState = false;

            // Navigator.push(
            //   context,
            //   MaterialPageRoute<void>(
            //     builder: (BuildContext context) =>
            //         MyApp.routerDelegate.pages.selectPage(widget),
            //   ),
            // );
            //
            // MyApp.routerDelegate.nextWidget(widget);

            MyApp.nextRoute(context);

//            canSetState = true;
          },
          child: Text('Page $nextWidget'),
        ),
      );
}
