import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

import '../../../data/db/db_manager.dart';

class AddNoteController extends GetxController {
  RxBool isLoading = false.obs;
  DatabaseManager database = DatabaseManager.instance;

  TextEditingController titleC = TextEditingController();
  TextEditingController descC = TextEditingController();

  void addNote() async {
    if (titleC.text.isNotEmpty && descC.text.isNotEmpty) {
      isLoading.value = true;
      Database db = await database.db;
      await db.insert(
        'notes',
        {
          "title": titleC.text,
          "desc": descC.text,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      isLoading.value = false;

      Get.back();
    }
  }
}
