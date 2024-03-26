import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_note_controller.dart';
import '../../home/controllers/home_controller.dart';

class AddNoteView extends GetView<AddNoteController> {
  final HomeController homeC = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ADD NOTE'),
        centerTitle: true,
        backgroundColor: Colors.yellow,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            controller: controller.titleC,
            decoration: InputDecoration(
              labelText: "Title",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          TextField(
            controller: controller.descC,
            decoration: InputDecoration(
              labelText: "Description",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          Obx(
            () => ElevatedButton(
              onPressed: () async {
                if (controller.isLoading.isFalse) {
                  controller.addNote();
                  await homeC.getAllNotes();
                  Get.back();
                }
              },
              child: Text(
                  controller.isLoading.isFalse ? "ADD NOTE" : "LOADING..."),
            ),
          ),
        ],
      ),
    );
  }
}
