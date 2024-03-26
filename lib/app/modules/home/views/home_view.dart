import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_sqflite/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';
import '../../../data/models/note_model.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ALL NOTES'),
        centerTitle: true,
        backgroundColor: Colors.yellow,
      ),
      body: FutureBuilder(
        future: controller.getAllNotes(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Obx(
            () => (controller.allNote.length == 0)
                ? Center(
                    child: Text("Tidak ada data"),
                  )
                : ListView.builder(
                    itemCount: controller.allNote.length,
                    itemBuilder: (context, index) {
                      Note note = controller.allNote[index];
                      return ListTile(
                        onTap: () => Get.toNamed(
                          Routes.EDIT_NOTE,
                          arguments: note,
                        ),
                        leading: CircleAvatar(
                          child: Text("${note.id}"),
                        ),
                        title: Text("${note.title}"),
                        subtitle: Text("${note.desc}"),
                        trailing: IconButton(
                          onPressed: () => controller.deleteNote(note.id!),
                          icon: Icon(Icons.delete),
                        ),
                      );
                    },
                  ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(Routes.ADD_NOTE),
        child: Icon(Icons.add),
      ),
    );
  }
}
