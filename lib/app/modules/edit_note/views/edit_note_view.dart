import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/edit_note_controller.dart';
import '../../../data/models/note_model.dart';
import '../../home/controllers/home_controller.dart';

class EditNoteView extends GetView<EditNoteController> {
  Note note = Get.arguments;
  final HomeController homeC = Get.find();

  @override
  Widget build(BuildContext context) {
    controller.titleC.text = note.title!;
    controller.descC.text = note.desc!;
    return Scaffold(
      appBar: AppBar(
        title: Text('EDIT NOTE'),
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
                  controller.editNote(note.id!);
                  await homeC.getAllNotes();
                  Get.back();
                }
              },
              child: Text(
                  controller.isLoading.isFalse ? "EDIT NOTE" : "LOADING..."),
            ),
          ),
        ],
      ),
    );
  }
}
