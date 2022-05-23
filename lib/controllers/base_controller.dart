import 'package:shift_app/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';


class BaseController extends GetxController {
  static BaseController get to => Get.find();

  final _pageViewController = PageController(keepPage: true);

  get pageViewController => _pageViewController;

  void signout() {
    Get.offAllNamed(Routers.initialRoute);
  }



  @override
  void dispose() {
    pageViewController.dispose();
    super.dispose();
  }
}
