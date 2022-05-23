import 'package:shift_app/routes/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'routes/pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(StarterApp());
}

class StarterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme:
          ThemeData(primaryColor: Colors.grey[900], ),
      smartManagement: SmartManagement.full,
      debugShowCheckedModeBanner: false,
      initialRoute: Routers.home,
      getPages: Pages.getPage,
    );
  }
}
