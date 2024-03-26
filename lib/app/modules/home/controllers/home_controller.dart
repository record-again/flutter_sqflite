import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

import '../../../data/db/db_manager.dart';
import '../../../data/models/note_model.dart';

class HomeController extends GetxController {
  RxList allNote = <Note>[].obs;
  DatabaseManager database = DatabaseManager.instance;

  Future<void> getAllNotes() async {
    Database db = await database.db;
    List<Map<String, dynamic>> data = await db.query("notes");

    if (data.isNotEmpty) {
      allNote(Note.toJsonList(data));
      allNote.refresh();
    } else {
      allNote.clear();
      allNote.refresh();
    }
  }

  Future deleteNote(int id) async {
    Database db = await database.db;
    await db.delete(
      "notes",
      where: 'id = ?',
      whereArgs: [id],
    );
    await getAllNotes();
  }

  @override
  void onInit() {
    getAllNotes();
    super.onInit();
  }
}
