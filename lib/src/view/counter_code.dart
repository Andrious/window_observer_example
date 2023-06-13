//
//     Superclass for the Counters
//

import 'package:window_observer_example/src/view.dart';

abstract class CounterWidget extends StatefulXWidget {
  const CounterWidget({super.key, this.title});
  final String? title;
  @override
  State createState();
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
    assert(() {
      if (kDebugMode) {
        print('###########  initState() in $this');
      }
      return true;
    }());
    if (prevWidget != null) {
      row.add(_prevButton(prevWidget!));
    }
    if (nextWidget == null) {
      row.add(const SizedBox());
    } else {
      row.add(_nextButton(nextWidget!));
    }
  }

  @override
  Widget build(BuildContext context) {
    assert(() {
      if (kDebugMode) {
        print('###########  build() in $this   counter: $_counter');
      }
      return true;
    }());
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
            // Navigator.push(
            //   context,
            //   MaterialPageRoute<void>(
            //     builder: (BuildContext context) =>
            //         MyApp.routerDelegate.pages.selectPage(widget),
            //   ),
            // );
            //
            // MyApp.routerDelegate.nextWidget(widget);

            super.nextRoute('/page$nextWidget');
          },
          child: Text('Page $nextWidget'),
        ),
      );
}
