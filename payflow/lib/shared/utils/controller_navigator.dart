import 'package:flutter/widgets.dart';

abstract class ControllerNavigator {
  static final navigator = GlobalKey<NavigatorState>();

  static void removeAllRoutesAndPushNew(String routeName) {
    final context = navigator.currentState!.overlay!.context;
    while (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }

    Navigator.of(context).pushNamed(
      routeName,
    );
  }
}