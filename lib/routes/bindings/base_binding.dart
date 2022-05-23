import 'package:shift_app/controllers/base_controller.dart';
import 'package:shift_app/controllers/login_controller.dart';
import 'package:shift_app/controllers/note_controller.dart';
import 'package:shift_app/controllers/shift_controller.dart';
import 'package:get/instance_manager.dart';

class BaseBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<BaseController>(() => BaseController(),);
    Get.lazyPut<LoginController>(() => LoginController(),);
    Get.lazyPut<ShiftController>(() =>ShiftController(),);
    Get.lazyPut<NotesController>(() =>NotesController(),);
  }

}