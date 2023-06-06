import 'package:shift_app/controllers/shift_controller.dart';
import 'package:shift_app/models/notes.dart';
import 'package:shift_app/models/userModel.dart';
import 'package:shift_app/utils/notes_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';


class NotesController extends GetxController {
  late UserModel user;
  final userInput = TextEditingController();
  var node = 0.obs;
  var noteState = Rx<NotesState>(NotesState.LOADING);
  late int lastItem;

  List<Note> usernotes = <Note>[].obs;

  Future<void> addItem(int id) async {
  
    await FirebaseFirestore.instance
        .collection('note')
        .doc()
        .set(
      {
        'userName': user.name.toString(),
        'userNote': userInput.text.toString(),
      },
     
    ).then(
      (value) => {
        getData(),
        usernotes.add(Note(
              userName: user.name.toString(), userNote: userInput.text))
      },
    );

    update();
  }

  

  void removeItem(String? id,int i) {
     FirebaseFirestore.instance.collection('notes').doc(id.toString()).delete().catchError((onError) {
      Get.snackbar("error while delete in", onError.toString());
    });;
     print(id);
    usernotes.removeAt(i);

  }

  Future<void> getData() async {
    noteState.value = NotesState.LOADING;
    try {
      QuerySnapshot _taskSnap = await FirebaseFirestore.instance
          .collection('note')
          .orderBy('userName')
          .get();

      usernotes.clear();

      for (var item in _taskSnap.docs) {
        usernotes.add(
          Note(
              id: item.id,
              userName: item['userName'],
              userNote: item['userNote']),
        );
      }
      lastItem=usernotes.length;
      noteState.value = NotesState.DONE;
      update();
    } catch (e) {
      print(e.toString());
    }
  }

  /*showDeleteAlertDialog(
    BuildContext context,
    int i,
  ) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Hayır"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop('hayır');
      },
    );
    Widget continueButton = TextButton(
      child: Text("Evet"),
      onPressed: () {
        if (usernotes[i].userName == user.name) {
          removeItem(i);

          Navigator.of(context, rootNavigator: true).pop("evet");
        } else {
          Navigator.of(context, rootNavigator: true).pop("hayır");
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Başkasının notunu silemezsiniz",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.05)),
              duration: Duration(milliseconds: 500)));
        }
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Uyarı"),
      content: Text("Bu notu herkesden silmek istiyor musun?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }*/

  @override
  void onInit() {
    // ignore: unused_local_variable
    final shiftController = Get.find<ShiftController>();
    user = shiftController.loggedInUser;
    getData();
    //user = loginController.user;

    super.onInit();
  }
}
