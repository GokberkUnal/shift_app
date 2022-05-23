import 'package:shift_app/controllers/shift_controller.dart';
import 'package:get/instance_manager.dart';


class ShiftBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ShiftController>(
      ShiftController(),
    );
   
  }
}
