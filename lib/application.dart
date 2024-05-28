import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../application/core/enumerations/palette_enumeration.dart';

import '../application/features/details/details_handler.dart';
import '../application/features/home/home_handler.dart';
import '../application/features/jars/jars_handler.dart';

/// The application's root.
/// 
/// The entire global configuration and [MaterialApp] is provided here.
/// Such as themes, routes, and default settings.
class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {

  @override
  Widget build(BuildContext context) {
    // Sets the application to show the device navigation bar only.
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: <SystemUiOverlay> [SystemUiOverlay.bottom],
    );

    // Set the orientation mode to freeze at portrait mode only.
    SystemChrome.setPreferredOrientations(<DeviceOrientation> [DeviceOrientation.portraitUp]);

    // Set the navigation bar color.
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Palette.background.color,
    ));

    return MaterialApp.router(
      // Freeze the text scaler regardless of the device's font size.
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: const TextScaler.linear(1.0),
          ),
          child: child!,
        );
      },
      routerConfig: _router,
      theme: _theme,
      debugShowCheckedModeBanner: false,
    );
  }

  /// The application's router.
  /// 
  /// When redirecting a view never use the default navigator, always use this router from [GoRouter] navigator.
  /// Check the architecture document for more information.
  final GoRouter _router = GoRouter(
    initialLocation: '/home',
    routes: <RouteBase> [
      GoRoute(
        builder: (BuildContext context, GoRouterState state) => Details(state.pathParameters['title']!),
        path: '/details/:title',
      ),
      GoRoute(
        builder: (BuildContext context, GoRouterState state) => const Home(),
        path: '/home',
      ),
      GoRoute(
        builder: (BuildContext context, GoRouterState state) => JARs(state.pathParameters['title']!),
        path: '/jars/:title',
      ),
    ],
  );

  /// The application's theme style.
  /// 
  /// The global configuration, set everything related to [ThemeData] here.
  final ThemeData _theme = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: Palette.background.color,
      toolbarHeight: 37.5 + 30,
      titleSpacing: 15,
      shape: Border(
        bottom: BorderSide(
          color: Palette.divider.color,
          width: 1,
        ),
      ),
      surfaceTintColor: Palette.background.color,
    ),
    scaffoldBackgroundColor: Palette.background.color,
  );
}