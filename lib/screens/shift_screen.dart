import 'package:shift_app/controllers/shift_controller.dart';
import 'package:shift_app/routes/notes_page_router.dart';
import 'package:shift_app/utils/shift_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ShiftScreen extends GetView<ShiftController> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
          appBar: AppBar(
              toolbarHeight: MediaQuery.of(context).size.height * 0.1,
              title: Image.asset(
                'assets/images/logo.png',
                height: 100,
                width: MediaQuery.of(context).size.width,
              ),
              backgroundColor: Colors.cyan[900],
              actions: <Widget>[
                PopupMenuButton(
                    icon: Icon(Icons.menu),
                    color: Colors.grey.shade900,
                    itemBuilder: (context) => [
                          PopupMenuItem<int>(
                            padding: EdgeInsets.all(0),
                            value: 0,
                            child: TextButton.icon(
                              label: Text(
                                "Notlar ",
                                style: TextStyle(color: Colors.white),
                              ),
                              icon: Icon(
                                Icons.notes,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Get.to(() => NotesPageRouter());
                              },
                            ),
                          ),
                        ])
              ]),
          body:Obx((){
            if(controller.shiftState()==ShiftState.LOADING){return Center(child: CircularProgressIndicator(
                color: Colors.black,
              ));}else{return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height*0.02,),
              Container(
                height: MediaQuery.of(context).size.height*0.049,
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(onPressed: () {}, icon: Icon(Icons.arrow_left,size: MediaQuery.of(context).size.height*0.03,)),
                    Text("38. Hafta",style: (TextStyle(fontSize: MediaQuery.of(context).size.height*0.05,)),),
                    IconButton(onPressed: () {}, icon: Icon(Icons.arrow_right,size: MediaQuery.of(context).size.height*0.03,)),
                  ],
                ),
              ),
               SizedBox(height: MediaQuery.of(context).size.height*0.02,),
              Container(alignment: Alignment.center,
                height: MediaQuery.of(context).size.height * 0.75,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.week.week.length,
                    itemBuilder: (BuildContext ctx, int i) {
                      return Column(
                        children: [
                          Container(
                              height: MediaQuery.of(context).size.height * 0.1,
                              width: MediaQuery.of(context).size.width * 0.2,
                              child: Card(
                                color: Colors.cyan[900],
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      controller.week.week[i].day,
                                     
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                     controller.week.week[i].date,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                
                                  ],
                                ),
                              )),
                               SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                          Container(
                              height: MediaQuery.of(context).size.height * 0.60,
                              width: MediaQuery.of(context).size.width * 0.2,
                              child: GetBuilder<ShiftController>(
                                  init: ShiftController(),
                                  builder: (value) => ListView.builder(
                                      itemCount: controller.week.week[i].slots.length,
                                      itemBuilder: (BuildContext ctx, int j) {
                                        return Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.1,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.2,
                                          child: TextButton(
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty
                                                        .all<Color>(Color(controller
                                                            .week.week[i]
                                                            .slots[j]
                                                            .userColor!.toInt()) )),
                                            onPressed: () {
                                              controller.isAvailableCheck(i);
                                              if (controller.isAvailable ==
                                                  true) {
                                                    
                                                    if (controller.week.week[i].slots[j]
                                                          .userName ==
                                                      controller.loggedInUser.name) {
                                                    controller
                                                        .showDeleteAlertDialog(
                                                            context, i, j);
                                                            
                                                  }
                                                  else{
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        content: Text(
                                                            "Ayn?? g??ne alamazs??n",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                fontSize: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.05)),
                                                        duration: Duration(
                                                            milliseconds:
                                                                500)));

                                                  }
                                                  controller.isAvailable=false;
                                              } else {
                                                controller.isAvailable = false;
                                                if (controller.week.week[i].slots[j]
                                                        .isEmptyFlag ==
                                                    false) {
                                                   
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(SnackBar(
                                                            content: Text(
                                                                "Ba??kas??n??n yerini alamazs??n",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                    fontSize: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.05)),
                                                            duration: Duration(
                                                                milliseconds:
                                                                    500)));
                                                  
                                                } else {
                                                  controller
                                                      .showDateAlertDialog(
                                                          context, i, j);
                                                }
                                              }
                                            },
                                            child: Text(
                                              controller.week.week[i].slots[j].userName
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        );
                                      })))
                        ],
                      );
                    }),
              ),
            ],
          );}})
    ));
  }
}
