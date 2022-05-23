import 'package:shift_app/controllers/note_controller.dart';
import 'package:get/get.dart';

class NotesBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<NotesController>(
      NotesController());
  }

}