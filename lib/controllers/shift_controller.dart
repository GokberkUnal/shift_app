import 'package:intl/intl.dart';
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
  late String currentWeekIndex;
  late String weekText;

  @override
  void onInit() {
    final loginController = Get.find<LoginController>();
    loggedInUser = loginController.loggedInUser;
    String index = getCurrentWeekIndex();
    weekText=getCurrentWeekIndex2();

    getWeek(index);

    super.onInit();
  }

  String getCurrentWeek() {
    var now = new DateTime.now();
    var formatter = new DateFormat('MM-yyyy');
    String formattedDate = formatter.format(now);
    print(formattedDate); // 2016-01-25
    return formattedDate;
  }

  int getCurrentWeekOfMonth() {
    // Current date and time of system
    String date = DateTime.now().toString();

// This will generate the time and date for first day of month
    String firstDay = date.substring(0, 8) + '01' + date.substring(10);

// week day for the first day of the month
    int weekDay = DateTime.parse(firstDay).weekday;

    DateTime testDate = DateTime.now();

    int weekOfMonth;

//  If your calender starts from Monday
    weekDay--;
    weekOfMonth = ((testDate.day + weekDay) / 7).ceil();
    print('Week of the month: $weekOfMonth');
    weekDay++;
    return weekOfMonth;
  }

  String getCurrentWeekIndex() {
    var weekOfMonth = getCurrentWeekOfMonth();
    DateTime testDate = DateTime.now();
    var formatter = new DateFormat('MM');
    var currentmonth = formatter.format(testDate);
    /*var now = new DateTime.now();
    var formatter = new DateFormat('yyyyMM');
    currentWeekIndex = formatter.format(now);
   // 2016-01-25
    return currentWeekIndex;*/
    currentWeekIndex=("$weekOfMonth$currentmonth");
    print("$weekOfMonth$currentmonth");
    return ("$weekOfMonth$currentmonth").toString();
  }

  String getCurrentWeekIndex2() {
    List months = [
      'jan',
      'feb',
      'mar',
      'apr',
      'may',
      'jun',
      'jul',
      'aug',
      'sep',
      'oct',
      'nov',
      'dec'
    ];
    var now = new DateTime.now();
    var current_mon = now.month;
    var weekOfMonth = getCurrentWeekOfMonth();    /*var now = new DateTime.now();
    var formatter = new DateFormat('yyyyMM');
    String current = formatter.format(now);
   // 2016-01-25*/
  
    return "$weekOfMonth. week of $current_mon";
  }

  void getWeek(String index) async {
    shiftState.value = ShiftState.LOADING;
    List<Day> days = <Day>[].obs;
    List<Slot> slots = <Slot>[].obs;

    await FirebaseFirestore.instance
        .collection('week')
        .doc(index)
        .get()
        .then((weekValue) async => {
              for (int i = 0; i < 5; i++)
                {
                  await FirebaseFirestore.instance
                      .collection('week')
                      .doc(index)
                      .collection('day')
                      .doc("$i")
                      .get()
                      .then((dayValue) async => {
                            for (int j = 0; j < 5; j++)
                              {
                                await FirebaseFirestore.instance
                                    .collection('week')
                                    .doc(index)
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
                            days.add(Day.fromMap(
                                dayValue, i.toString(), List.from(slots))),
                            slots.clear()
                          }),
                  slots.clear(),
                  print("i $i"),
                },
              week = Week.fromMap(weekValue.data(), '1', List.from(days)),
              days.clear(),
              shiftState.value = ShiftState.DONE,
            });
  }

  Future<void> takeDate(String index, int i, int j,String weekId) async {
    week.week[i].slots[j].userColor = loggedInUser.color;
    week.week[i].slots[j].userName = loggedInUser.name;
    week.week[i].slots[j].isEmptyFlag = false;
    await FirebaseFirestore.instance
        .collection("week")
        .doc(weekId)
        .collection("day")
        .doc("$i")
        .collection("slot")
        .doc("$j")
        .update({
      "userName": loggedInUser.name,
      "userColor": loggedInUser.color,
      "isEmptyFlag": false
    }).then((value) => {print("date taken")});
    update();
  }

  Future<void> deleteDate(String index, int i, int j,String weekId) async {
    week.week[i].slots[j].userColor = Colors.grey.shade900.value;
    week.week[i].slots[j].userName = '+';
    week.week[i].slots[j].isEmptyFlag = true;
    await FirebaseFirestore.instance
        .collection("week")
        .doc(weekId)
        .collection("day")
        .doc("$i")
        .collection("slot")
        .doc("$j")
        .update({
      "userName": "+",
      "userColor": 4280361249,
      "isEmptyFlag": true
    }).then((value) => {print("date deleted")});
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

  showDeleteAlertDialog(String index, BuildContext context, int i, int j,String weekId) {
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
        deleteDate(index, i, j,weekId);

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

  showDateAlertDialog(String index, BuildContext context, int i, int j,String weekId) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Hayır"),
      onPressed: () {
        deleteDate(index, i, j,weekId);
        Navigator.of(context, rootNavigator: true).pop('hayır');
      },
    );
    Widget continueButton = TextButton(
      child: Text("Evet"),
      onPressed: () {
        takeDate(index, i, j,weekId);

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
