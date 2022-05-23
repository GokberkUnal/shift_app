import 'package:shift_app/controllers/note_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class NotesScreen extends GetView<NotesController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Notlar'),
          backgroundColor: Colors.cyan[900],
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.red,
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: GetBuilder<NotesController>(
          init: NotesController(),
          builder: (value) => Column(children: [
            Container(
                height: MediaQuery.of(context).size.height * 0.75,
                child: Container(
                  child: ListView.builder(
                      itemCount: controller.usernotes.length,
                      itemBuilder: (BuildContext ctx, int i) {
                        return Dismissible(
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.13,
                              alignment: Alignment.topLeft,
                              child: Column(
                                children: [
                                  Card(
                                      margin: EdgeInsets.zero,
                                      child: ListTile(
                                        title: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              alignment: Alignment.topLeft,
                                              child: new Text(
                                                controller.usernotes[i].userName
                                                    .toString(),
                                                style: new TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 30),
                                                textAlign: TextAlign.start,
                                              ),
                                            ),
                                            new Text(controller
                                                .usernotes[i].userNote
                                                .toString()),
                                          ],
                                        ),
                                      )),
                                ],
                              ),
                              padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.height * 0.009),
                            ),
                            key: UniqueKey(),
                            background: Container(
                              alignment: Alignment.centerRight,
                              color: Colors.red,
                              child: Icon(Icons.delete),
                            ),
                            onDismissed: (direction) {
                              controller.removeItem(controller.usernotes[i].id.toString(),i);
                            });
                      }),
                )), ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
          ),
          child: const Text('Not ekle'),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (_) {
                return GestureDetector(
                    onTap: () {},
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Notlar:',
                              style: TextStyle(fontSize: 22),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 3,
                                color: Colors.black,
                              ),
                            ),
                            child: TextField(
                              cursorColor: Colors.black,
                              controller: controller.userInput,
                              keyboardType: TextInputType.multiline,
                              minLines: 10,
                              maxLines: 10,
                            ),
                          ),
                          Align(),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.20,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.30,
                            child: TextButton(
                              child: Text('Notu ekle'),
                              style: TextButton.styleFrom(
                                primary: Colors.white,
                                backgroundColor: Colors.cyan[900],
                                onSurface: Colors.cyan[900],
                              ),
                              onPressed: () {
                                controller.addItem(controller.lastItem);
                                 Navigator.of(context,).pop("kaydedildi");
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    behavior: HitTestBehavior.opaque);
              },
            );
          },
        ),
          ]),
        ));
  }
}
