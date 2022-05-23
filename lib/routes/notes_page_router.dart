
import 'package:shift_app/routes/bindings/notes_bindings.dart';
import 'package:shift_app/screens/Notes_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotesPageRouter extends StatefulWidget{
  static const navigatorIndex=2;

  @override
  State<StatefulWidget> createState()=>_NotesPageRouterState();
  static Route onGenerateRouter(RouteSettings settings){
    if(settings.name=='/'){
      return GetPageRoute(settings: settings,page: ()=>NotesScreen(),binding: NotesBinding(),);
    }
    throw('no page');
  }
}

class _NotesPageRouterState extends State<NotesPageRouter>{
  @override
  Widget build(BuildContext context) {
    return Navigator(key: Get.nestedKey(NotesPageRouter.navigatorIndex,),
    initialRoute: '/',
    onGenerateRoute: NotesPageRouter.onGenerateRouter,);
  }

}