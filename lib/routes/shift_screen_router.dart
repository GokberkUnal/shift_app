import 'package:shift_app/screens/shift_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import 'bindings/shift_bindings.dart';


class ShiftScreenRouter extends StatefulWidget {
  static const navigatorIndex = 1;

  @override
  _ShiftScreenRouterState createState() => _ShiftScreenRouterState();

  static Route onGenerateRouter(RouteSettings settings) {
    if (settings.name == '/') {
      return GetPageRoute(
          settings: settings,
          page: () => ShiftScreen(),
          binding: ShiftBinding());
    }

    throw Exception('no page');
  }
}

class _ShiftScreenRouterState extends State<ShiftScreenRouter> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Get.nestedKey(ShiftScreenRouter.navigatorIndex),
      initialRoute: '/',
      onGenerateRoute: ShiftScreenRouter.onGenerateRouter,
    );
  }
}
