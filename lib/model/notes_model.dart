import 'package:hive/hive.dart';
part 'notes_model.g.dart';

@HiveType(typeId: 1)
class NotesModel {
  @HiveField(1)
  String title = "";
  @HiveField(2)
  String description = "";
  @HiveField(3)
  String date;
  @HiveField(4)
  String category = "";

  NotesModel({
    required this.title,
    required this.description,
    required this.date,
    required this.category,
  });
}
