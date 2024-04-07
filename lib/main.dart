import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:resmpk/helpers/app_style.dart';
import 'package:resmpk/home/cubit/home_cubit.dart';
import 'package:resmpk/injection.dart';
import 'package:resmpk/routers/app_route.dart';
import 'package:resmpk/services/request_service.dart';
import 'package:resmpk/services/storage/local_storage_service.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  final GeolocatorPlatform geolocator = GeolocatorPlatform.instance;
  LocalStorageService localStorage = LocalStorageService()..init();
  RequestService requestService = RequestService()..init(localStorage);
  FlutterNativeSplash.remove();

  configureDependencies();
  getIt.registerSingleton<AppRouter>(AppRouter());
  await initializeDateFormatting('pl', null);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(
          create: (context) {
            return HomeCubit(
              request: requestService,
              localStorage: localStorage,
              geolocator: geolocator,
            )..init();
          },
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

final scaffoldKey = GlobalKey<ScaffoldMessengerState>();

class _MyAppState extends State<MyApp> {
  final _appRouter = getIt<AppRouter>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      locale: const Locale('pl', 'PL'),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [Locale('pl')],
      theme: ThemeData(
        primarySwatch: AppColors.orangeMaterial,
        colorScheme: const ColorScheme.light(
          primary: AppColors.primary,
          background: AppColors.white,
          onBackground: AppColors.white,
        ),
      ),
      scaffoldMessengerKey: scaffoldKey,
      routerDelegate: _appRouter.delegate(
        navigatorObservers: () => [AutoRouteObserver()],
      ),
      routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}

class AutoRouteObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    log('Route pushed: ${route.settings.name}');
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    log('Route popped: ${route.settings.name}');
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace();
    if (oldRoute != null && newRoute != null) {
      log('Route replaced: ${oldRoute.settings.name} -> ${newRoute.settings.name}');
    }
  }
}
