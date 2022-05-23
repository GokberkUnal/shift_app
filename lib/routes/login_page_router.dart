import 'package:shift_app/routes/bindings/login_binding.dart';
import 'package:shift_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPageRouter extends StatefulWidget{
  static const navigatorIndex=0;

  @override
  State<StatefulWidget> createState()=>_LoginPageRouterState();
  static Route onGenerateRouter(RouteSettings settings){
    if(settings.name=='/'){
      return GetPageRoute(settings: settings,page: ()=>LoginScreen(),binding: LoginBinding(),);
    }
    throw('no page');
  }
}

class _LoginPageRouterState extends State<LoginPageRouter>{
  @override
  Widget build(BuildContext context) {
    return Navigator(key: Get.nestedKey(LoginPageRouter.navigatorIndex,),
    initialRoute: '/',
    onGenerateRoute: LoginPageRouter.onGenerateRouter,);
  }

}