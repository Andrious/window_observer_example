//

import 'package:window_observer_example/src/view.dart';

class AppRouterDelegate extends RouterDelegate<RouteConfiguration>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<RouteConfiguration> {
  /// Supply the pages
  AppRouterDelegate(this.pages) : navigatorKey = GlobalKey<NavigatorState>();

  final AppPages pages;

  @override
  final GlobalKey<NavigatorState> navigatorKey;

  String? _selectedPage;
  String? _selectedRoute;
  bool show404 = true;

  /// get current route based on the show404 flag and _selectedItem & _selectedRoute value
  @override
  RouteConfiguration get currentConfiguration {
    if (show404) {
      return RouteConfiguration.error();
    }

    if (_selectedRoute != null && _selectedPage == null) {
      return RouteConfiguration.newRoute(_selectedRoute);
    }

    if (_selectedRoute != null && _selectedPage != null) {
      return RouteConfiguration.nestedItemRoute(_selectedRoute, _selectedPage);
    }

    if (_selectedPage != null) {
      return RouteConfiguration.details(_selectedPage);
    }

//    return RouteConfiguration.list();
    return RouteConfiguration.details(pages.widgets.keys.first);
  }

  // code same as with pages except it uses notify listeners instead of setState and adds Navigator Key
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        if (show404)
          const MaterialPage(
            key: ValueKey('Error Page'),
            child: Center(
              child: Text('404'),
            ),
          ),
        if (_selectedPage != null)
          MaterialPage(
            key: ValueKey(_selectedPage!),
            child: pages.selectPage(_selectedPage!),
          ),
      ],
      onPopPage: (route, result) {
        //
        if (!route.didPop(result)) {
          return false;
        }

        if (_selectedPage != null && _selectedRoute != null) {
          _selectedPage = null;
          notifyListeners();
          return true;
        }

        _selectedRoute = null;
        _selectedPage = null;
        setInitialRoutePath(RouteConfiguration.details('1'));

        notifyListeners();

        return true;
      },
    );
  }

  // update app state to set new route based on the configuration set
  @override
  Future<void> setNewRoutePath(RouteConfiguration configuration) async {
    isInvalidCartItem(id) => id < 0 || id % 2 != 0 || id >= 10;
    if (configuration.show404) {
      _selectedPage = null;
      _selectedRoute = null;
      show404 = true;
      return;
    }

    if (configuration.isDetailsPage) {
      // if (configuration.id! >= 10) {
      //   show404 = true;
      //   return;
      // }
      _selectedPage = configuration.selectedPage;
    } else if (configuration.isNewPage) {
      // if (configuration.selectedRoute != cartRoute) {
      //   show404 = true;
      //   return;
      // }
      _selectedRoute = configuration.selectedRoute;
    } else if (configuration.isNestedPage) {
      if (isInvalidCartItem(configuration.selectedPage!)) {
        show404 = true;
        return;
      }

      _selectedPage = configuration.selectedPage;
      _selectedRoute = configuration.selectedRoute;
    } else {
      _selectedPage = null;
      _selectedRoute = null;
    }

    show404 = false;
  }

  void _handleItemTapped(String page) {
    _selectedPage = page;
    notifyListeners();
  }

  void _handleRouteTapped(String route) {
    _selectedPage = null;
    _selectedRoute = route;
    notifyListeners();
  }

  ///
  void nextWidget(String? widget) {
    if (widget != null) {
      setNewRoutePath(RouteConfiguration.details(widget));
      notifyListeners();
    }
  }
}

class AppRouterInformationParser
    extends RouteInformationParser<RouteConfiguration> {
  AppRouterInformationParser(this.pages);

  final Map<String, Widget> pages;

  @override
  Future<RouteConfiguration> parseRouteInformation(
      RouteInformation routeInformation) async {
    //
    final uri = Uri.parse(routeInformation.location!);
    // Handle '/'
    if (uri.pathSegments.isEmpty) {
//      return RouteConfiguration.list();
      return RouteConfiguration.details(pages.keys.first);
    }

    // Handle '/items/:itemId'
    // Handle '/route/:itemId'
    if (uri.pathSegments.length == 2) {
      //
      var secondSegment = uri.pathSegments[1];

      var id = int.tryParse(secondSegment);

      if (id == null) return RouteConfiguration.error();

      if (uri.pathSegments[0] != 'items') {
        //
        return RouteConfiguration.nestedItemRoute(
            uri.pathSegments[0], 'item $id');
      }
      // return example items 0
      return RouteConfiguration.details('item $id');
    }

    // Handle '/route'
    if (uri.pathSegments.length == 1) {
      //
      if (!pages.keys.contains(uri.pathSegments[0])) {
        return RouteConfiguration.error();
      }
      return RouteConfiguration.newRoute(uri.pathSegments[0]);
    }
    // Handle /404
    return RouteConfiguration.error();
  }

  /// Supplies the appropriate Route Information from the specified uri string.
  @override
  RouteInformation? restoreRouteInformation(RouteConfiguration configuration) {
    if (configuration.show404) {
      return const RouteInformation(location: '/404');
    }
    if (configuration.isListPage) {
      return RouteInformation(location: '/', state: pages[0]);
    }
    if (configuration.isNewPage) {
      return RouteInformation(location: '/${configuration.selectedRoute!}');
    }

    if (configuration.isNestedPage) {
      return RouteInformation(
          location:
              '/${configuration.selectedRoute!}/${configuration.selectedPage}');
    }
    if (configuration.isDetailsPage) {
      return RouteInformation(location: '/page${configuration.selectedPage}');
    }
    return null;
  }
}

class RouteConfiguration {
  final String? selectedPage;
  final String? selectedRoute;
  final bool show404;
  final pages = <String, Widget>{};

  RouteConfiguration.list()
      : selectedRoute = null,
        selectedPage = null,
        show404 = false;

  RouteConfiguration.newRoute(this.selectedRoute)
      : selectedPage = null,
        show404 = false;

  RouteConfiguration.nestedItemRoute(this.selectedRoute, this.selectedPage)
      : show404 = false;

  RouteConfiguration.details(this.selectedPage)
      : selectedRoute = null,
        show404 = false;

  RouteConfiguration.error()
      : selectedRoute = null,
        selectedPage = null,
        show404 = true;

  bool get isListPage => selectedPage == null && selectedRoute == null;

  bool get isDetailsPage => selectedPage != null && selectedRoute == null;

  bool get isNewPage => selectedRoute != null && selectedPage == null;

  bool get isNestedPage => selectedRoute != null && selectedPage != null;
}

class AppPages {
  AppPages(this.widgets);

  final Map<String, Widget> widgets;

  // Return the specified widget
  Widget selectPage(String? key) {
    Widget? widget;
    if (key != null) {
      widget = widgets[key];
    }
    return widget ?? const SizedBox();
  }
}
