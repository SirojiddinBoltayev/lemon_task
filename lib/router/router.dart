import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:lemon_task/presantation/pages/home/home.dart';

import '../presantation/pages/home/create_card_screen/create_card_screen.dart';
import '../presantation/pages/home/create_card_screen/nfc_scan_credit_card.dart';
import '../presantation/pages/home/create_card_screen/scan_credit_card2.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  static GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    observers: [],
    routes: [
      // GoRoute(
      //   path: "/",
      //   name: SplashScreen.screenName,
      //   builder: (context, state) {
      //     return const SplashScreen();
      //   },
      // ),
      GoRoute(
        path: "/",
        name: HomePage.routeName,
        builder: (context, state) {
          return const HomePage();
        },
      ),
      GoRoute(
        path: "/create_card",
        name: CreateCardScreen.routeName,
        builder: (context, state) {
          return const CreateCardScreen();
        },
      ),
      GoRoute(
        path: "/camera_screen",
        name: CameraPage.routeName,
        builder: (context, state) {
          final data = state.extra as Map<String, dynamic>;
          return  CameraPage(
            onScan: data['onScan'],
          );
        },
      ),
      GoRoute(
        path: "/nfc_scan_credit_card",
        name: NfcScanCreditCard.routeName,
        builder: (context, state) {
          final data = state.extra as Map<String, dynamic>;
          return  NfcScanCreditCard(
            onSuccess: data['onSuccess'],
          );
        },
      ),
    ],
    initialLocation: '/',
  );
}
