import 'package:hive_flutter/hive_flutter.dart';
import 'package:noteapp/model/notes_model.dart';
import 'package:hive/hive.dart';

class NoteScreenController {
  var box = Hive.box<NotesModel>("noteBox");
  deleteNotes(int itemKey) {
    box.delete(itemKey);
  }
}
