import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../../../data/db/db_manager.dart';

class EditNoteController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController titleC = TextEditingController();
  TextEditingController descC = TextEditingController();

  DatabaseManager database = DatabaseManager.instance;

  void editNote(int id) async {
    Database db = await database.db;
    await db.update(
      "notes",
      {
        "id": id,
        "title": titleC.text,
        "desc": descC.text,
      },
      where: "id = ?",
      whereArgs: [id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
