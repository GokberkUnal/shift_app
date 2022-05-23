import 'package:shift_app/controllers/login_controller.dart';
import 'package:shift_app/models/day.dart';
import 'package:shift_app/models/slot.dart';

import 'package:shift_app/models/userModel.dart';
import 'package:shift_app/models/week.dart';
import 'package:shift_app/utils/shift_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ShiftController extends GetxController {
  var shiftState = Rx<ShiftState>(ShiftState.LOADING);

  late UserModel loggedInUser;
  User? user = FirebaseAuth.instance.currentUser;
  bool isAvailable = false;
  List<Day> wk = <Day>[].obs;
  late Week week;

  @override
  void onInit() {
    final loginController = Get.find<LoginController>();
    loggedInUser = loginController.loggedInUser;
    getWeek();
    
    

    super.onInit();
  }



   void getWeek() async {
    shiftState.value=ShiftState.LOADING;
    List<Day> days = <Day>[].obs;
    List<Slot> slots = <Slot>[].obs;
    
    await FirebaseFirestore.instance
        .collection('week')
        .doc('0')
        .get()
        .then((weekValue) async => {
              for (int i = 0; i < 5; i++)
                {
                  await FirebaseFirestore.instance
                      .collection('week')
                      .doc('0')
                      .collection('day')
                      .doc("$i")
                      .get()
                      .then((dayValue) async => {
                        
                            for (int j = 0; j < 5; j++)
                              {
                                
                                await FirebaseFirestore.instance
                                    .collection('week')
                                    .doc('0')
                                    .collection('day')
                                    .doc("$i")
                                    .collection('slot')
                                    .doc("$j")
                                    .get()
                                    .then((value) => {
                                      
                                          slots.add(Slot.fromMap(
                                              value.data(), j.toString()))
                                        }),
                                print("$j"),
                              },
                               
                            days.add(
                                Day.fromMap(dayValue, i.toString(), List.from(slots))),
                                slots.clear()
                               
                          }),
                          slots.clear(),
                  print("i $i"),
                },
              week = Week.fromMap(weekValue.data(), '0', List.from(days)),days.clear(),
              shiftState.value=ShiftState.DONE,
            });
  }

  Future<void> takeDate(int i, int j) async {
    week.week[i].slots[j].userColor = loggedInUser.color;
    week.week[i].slots[j].userName = loggedInUser.name;
    week.week[i].slots[j].isEmptyFlag = false;
    await FirebaseFirestore.instance.collection("week").doc("0").collection("day").doc("$i").collection("slot").doc("$j").update({"userName":loggedInUser.name,"userColor": loggedInUser.color,"isEmptyFlag":false}).then((value) => {print("date taken")});
    update();
  }

  Future<void> deleteDate(int i, int j) async {
    week.week[i].slots[j].userColor = Colors.grey.shade900.value;
    week.week[i].slots[j].userName = '+';
    week.week[i].slots[j].isEmptyFlag = true;
    await FirebaseFirestore.instance.collection("week").doc("0").collection("day").doc("$i").collection("slot").doc("$j").update({"userName":"+","userColor": 4280361249 ,"isEmptyFlag":true}).then((value) => {print("date deleted")});
    update();
  }

  void isAvailableCheck(int i) {
    for (int j = 0; j < week.week[i].slots.length; j++) {
      if (loggedInUser.name == week.week[i].slots[j].userName) {
        isAvailable = true;
        break;
      }
    }
  }

  

  showDeleteAlertDialog(BuildContext context, int i, int j) {
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
        deleteDate(i, j);

        Navigator.of(context, rootNavigator: true).pop("evet");
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Uyarı"),
      content: Text("Silmek istediğine emin misin?"),
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
  }

  showDateAlertDialog(BuildContext context, int i, int j) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Hayır"),
      onPressed: () {
        deleteDate(i, j);
        Navigator.of(context, rootNavigator: true).pop('hayır');
      },
    );
    Widget continueButton = TextButton(
      child: Text("Evet"),
      onPressed: () {
        takeDate(i, j);

        Navigator.of(context, rootNavigator: true).pop("evet");
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Uyarı"),
      content: Text("Gerçekten bugün gitmek mi istiyorsun?"),
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
  }
}
