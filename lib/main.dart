import 'package:flutter/material.dart';
import 'package:noteapp/Note_screen/note_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:noteapp/model/notes_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(NotesModelAdapter());
  Box<NotesModel> box = await Hive.openBox<NotesModel>('noteBox');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NoteScreen(),
    );
  }
}
