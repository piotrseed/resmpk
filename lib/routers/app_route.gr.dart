// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flutter/cupertino.dart' as _i5;
import 'package:flutter/material.dart' as _i8;
import 'package:resmpk/home/view/details_screen.dart' as _i1;
import 'package:resmpk/home/view/home_screen.dart' as _i2;
import 'package:resmpk/home/view/search_screen.dart' as _i3;
import 'package:resmpk/models/connections.dart' as _i6;
import 'package:resmpk/models/stop.dart' as _i7;

abstract class $AppRouter extends _i4.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    DetailsRoute.name: (routeData) {
      final args = routeData.argsAs<DetailsRouteArgs>();
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.DetailsScreen(
          key: args.key,
          connections: args.connections,
          stop: args.stop,
        ),
      );
    },
    HomeRoute.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.HomeScreen(),
      );
    },
    SearchRoute.name: (routeData) {
      final args = routeData.argsAs<SearchRouteArgs>();
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.SearchScreen(
          key: args.key,
          stops: args.stops,
          onTap: args.onTap,
        ),
      );
    },
  };
}

/// generated route for
/// [_i1.DetailsScreen]
class DetailsRoute extends _i4.PageRouteInfo<DetailsRouteArgs> {
  DetailsRoute({
    _i5.Key? key,
    required List<_i6.Connections> connections,
    required _i7.Stop stop,
    List<_i4.PageRouteInfo>? children,
  }) : super(
          DetailsRoute.name,
          args: DetailsRouteArgs(
            key: key,
            connections: connections,
            stop: stop,
          ),
          initialChildren: children,
        );

  static const String name = 'DetailsRoute';

  static const _i4.PageInfo<DetailsRouteArgs> page =
      _i4.PageInfo<DetailsRouteArgs>(name);
}

class DetailsRouteArgs {
  const DetailsRouteArgs({
    this.key,
    required this.connections,
    required this.stop,
  });

  final _i5.Key? key;

  final List<_i6.Connections> connections;

  final _i7.Stop stop;

  @override
  String toString() {
    return 'DetailsRouteArgs{key: $key, connections: $connections, stop: $stop}';
  }
}

/// generated route for
/// [_i2.HomeScreen]
class HomeRoute extends _i4.PageRouteInfo<void> {
  const HomeRoute({List<_i4.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}

/// generated route for
/// [_i3.SearchScreen]
class SearchRoute extends _i4.PageRouteInfo<SearchRouteArgs> {
  SearchRoute({
    _i8.Key? key,
    required List<_i7.Stop> stops,
    required dynamic Function(_i7.Stop) onTap,
    List<_i4.PageRouteInfo>? children,
  }) : super(
          SearchRoute.name,
          args: SearchRouteArgs(
            key: key,
            stops: stops,
            onTap: onTap,
          ),
          initialChildren: children,
        );

  static const String name = 'SearchRoute';

  static const _i4.PageInfo<SearchRouteArgs> page =
      _i4.PageInfo<SearchRouteArgs>(name);
}

class SearchRouteArgs {
  const SearchRouteArgs({
    this.key,
    required this.stops,
    required this.onTap,
  });

  final _i8.Key? key;

  final List<_i7.Stop> stops;

  final dynamic Function(_i7.Stop) onTap;

  @override
  String toString() {
    return 'SearchRouteArgs{key: $key, stops: $stops, onTap: $onTap}';
  }
}
