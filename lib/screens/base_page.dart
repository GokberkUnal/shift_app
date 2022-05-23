import 'package:shift_app/controllers/base_controller.dart';
import 'package:shift_app/routes/login_page_router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class BasePage extends GetView<BaseController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.cyan[900],
        centerTitle: true,
        
        elevation: 0,
      ),
      body: GetBuilder<BaseController>(
          builder: (tx) => PageView(
                physics: new NeverScrollableScrollPhysics(),
                controller: controller.pageViewController,
                children: <Widget>[LoginPageRouter()],
              )),
    );
  }
}
