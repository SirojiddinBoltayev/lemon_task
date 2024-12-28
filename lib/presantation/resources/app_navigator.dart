
import '../../router/router.dart';

class AppNavigator {
  AppNavigator._();

  static pushReplacement(String name,{Object? extra}) async {
    AppRouter.router.pushReplacement(name,extra: extra);
  }

  static push(String name, {Object? extra}) async {
    AppRouter.router.push(name,extra: extra);
  }

  static go(String name, {Object? extra}) async {
    AppRouter.router.go(name,extra: extra);
  }

  static replace(String name, {Object? extra}) async {
    AppRouter.router.replace(name,extra: extra);
  }

  static pushNamed(String route, {Object? extra}) {
    AppRouter.router.pushNamed(route,extra: extra);
  }

  static pop() async {
    AppRouter.router.pop();
  }

// static back(BuildContext context) {}
}
