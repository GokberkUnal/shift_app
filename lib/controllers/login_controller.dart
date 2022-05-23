
import 'package:shift_app/models/userModel.dart';
import 'package:shift_app/models/week.dart';
import 'package:shift_app/screens/shift_screen.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class LoginController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Rxn<User> firebaseUser = Rxn<User>();
  User? get user => firebaseUser.value;
  late UserModel loggedInUser;
  final passwordcont = TextEditingController();
  final emailcont = TextEditingController();
  late int userColor;
  bool isColorPicked = false;
  late Week week;
  @override
  // ignore: must_call_super
  void onInit() {
    signOut();
    SystemChrome.setPreferredOrientations([ DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,]);
 
    firebaseUser.bindStream(_auth.authStateChanges());
    print(" Auth Change :   ${_auth.currentUser}");

  }

  void signOut()async{
    await FirebaseAuth.instance.signOut();
  }

  void login(String email, String password, int color) async {
    await _auth
        .signInWithEmailAndPassword(
            email: email.trim(), password: password.trim())
        .then((value) async => {
              await addColor(color),
              await getUser(),
              Get.offAll(ShiftScreen()),
            })
        .catchError((onError) {
      Get.snackbar("error while sign in", onError.toString());
    });
  }
 

  Future<void>getUser() async {
    await FirebaseFirestore.instance
        .collection('user')
        .doc(user!.uid)
        .get()
        .then(
          (value) =>
              this.loggedInUser = UserModel.fromMap(value.data(), user!.uid),
        );
    print(loggedInUser.name);
  }

  Future<void> addColor(int color) async {
    await FirebaseFirestore.instance.collection('user').doc(user!.uid).update(
        {"userColor": color}).then((_) async => {print("color updated")});
  }

 

  void pickColor(BuildContext context) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text('Pick Your Color'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        userColor = Colors.blue.value;
                        isColorPicked = true;
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(20),
                        primary: Colors.blue, // <-- Button color
                        onPrimary: Colors.red, // <-- Splash color
                      ),
                      child: null,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        userColor = Colors.red.value;
                        isColorPicked = true;
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(20),
                        primary: Colors.red, // <-- Button color
                        onPrimary: Colors.red, // <-- Splash color
                      ),
                      child: null,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        userColor = Colors.green.value;
                        isColorPicked = true;
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(20),
                        primary: Colors.green, // <-- Button color
                        onPrimary: Colors.red, // <-- Splash color
                      ),
                      child: null,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        userColor = Colors.yellow.value;
                        isColorPicked = true;
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(20),
                        primary: Colors.yellow, // <-- Button color
                        onPrimary: Colors.red, // <-- Splash color
                      ),
                      child: null,
                    ),
                  ],
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        userColor = Colors.purple.value;
                        isColorPicked = true;
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(20),
                        primary: Colors.purple, // <-- Button color
                        onPrimary: Colors.red, // <-- Splash color
                      ),
                      child: null,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        userColor = Colors.pink.shade100.value;
                        isColorPicked = true;
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(20),
                        primary: Colors.pink[100], // <-- Button color
                        onPrimary: Colors.red, // <-- Splash color
                      ),
                      child: null,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        userColor = Colors.orange.value;
                        isColorPicked = true;
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(20),
                        primary: Colors.orange, // <-- Button color
                        onPrimary: Colors.red, // <-- Splash color
                      ),
                      child: null,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        userColor = Colors.tealAccent.value;
                        isColorPicked = true;
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(20),
                        primary: Colors.tealAccent, // <-- Button color
                        onPrimary: Colors.red, // <-- Splash color
                      ),
                      child: null,
                    ),
                  ],
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        userColor = Colors.indigoAccent.shade200.value;
                        isColorPicked = true;
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(20),
                        primary: Colors.indigoAccent[200], // <-- Button color
                        onPrimary: Colors.red, // <-- Splash color
                      ),
                      child: null,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        userColor = Colors.deepOrangeAccent.shade100.value;
                        isColorPicked = true;
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(20),
                        primary:
                            Colors.deepOrangeAccent[100], // <-- Button color
                        onPrimary: Colors.red, // <-- Splash color
                      ),
                      child: null,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        userColor = Colors.brown.value;
                        isColorPicked = true;
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(20),
                        primary: Colors.brown, // <-- Button color
                        onPrimary: Colors.red, // <-- Splash color
                      ),
                      child: null,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        userColor = Colors.limeAccent.value;
                        isColorPicked = true;
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(20),
                        primary: Colors.limeAccent, // <-- Button color
                        onPrimary: Colors.red, // <-- Splash color
                      ),
                      child: null,
                    ),
                  ],
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        userColor = Colors.purpleAccent.value;
                        isColorPicked = true;
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(20),
                        primary: Colors.purpleAccent, // <-- Button color
                        onPrimary: Colors.red, // <-- Splash color
                      ),
                      child: null,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        userColor = Colors.cyanAccent.value;
                        isColorPicked = true;
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(20),
                        primary: Colors.cyanAccent, // <-- Button color
                        onPrimary: Colors.red, // <-- Splash color
                      ),
                      child: null,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        userColor = Colors.teal.shade900.value;
                        isColorPicked = true;
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(20),
                        primary: Colors.teal[900], // <-- Button color
                        onPrimary: Colors.red, // <-- Splash color
                      ),
                      child: null,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        userColor = Colors.redAccent.shade200.value;
                        isColorPicked = true;
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(20),
                        primary: Colors.redAccent[200], // <-- Button color
                        onPrimary: Colors.redAccent[900], // <-- Splash color
                      ),
                      child: null,
                    ),
                  ],
                ),
              ],
            ),
          ));
}
