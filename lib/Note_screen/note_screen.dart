import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:noteapp/controller/note_screen_controller.dart';
import 'package:noteapp/model/notes_model.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  List<Color> myColorList = [
    Colors.amber,
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.blue,
    Colors.green,
  ];
  var box = Hive.box<NotesModel>("noteBox");
  var keysList = [];
  int selectedIndex = 0;
  List selecteddataList = [];
  DateTime selectedDate = DateTime.now();

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final dateController = TextEditingController();
  final categoryController = TextEditingController();
  @override
  void initState() {
    selecteddataList = box.keys.toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("My Notes", style: TextStyle(color: Colors.black)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) => StatefulBuilder(
                    builder: (context, insetState) {
                      return Container(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              TextField(
                                controller: titleController,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "Title",
                                    hintText: "Title"),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextField(
                                controller: descriptionController,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "Description",
                                    hintText: "Description"),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextField(
                                controller: dateController,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "Select Date",
                                    hintText: "Select Date",
                                    suffixIcon: InkWell(
                                        onTap: () async {
                                          final DateTime? dateTime =
                                              await showDatePicker(
                                                  context: context,
                                                  initialDate: selectedDate,
                                                  firstDate: DateTime(2000),
                                                  lastDate: DateTime(3000));
                                          if (dateTime != null) {
                                            setState(() {});
                                            selectedDate = dateTime;
                                          }
                                          dateController.text =
                                              "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
                                        },
                                        child: Icon(Icons.calendar_month))),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextField(
                                controller: categoryController,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "Category",
                                    hintText: "Category"),
                              ),
                              SizedBox(height: 10),
                              Container(
                                height: 50,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: myColorList.length,
                                  itemBuilder: (context, index) => InkWell(
                                    onTap: () {
                                      selectedIndex = index;
                                      selecteddataList.add(selectedIndex);
                                      print(selecteddataList);
                                      insetState(() {});
                                      setState(() {});
                                    },
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      color: myColorList[index],
                                    ),
                                  ),
                                  separatorBuilder: ((context, index) =>
                                      SizedBox(
                                        width: 10,
                                      )),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                      onPressed: () {
                                        box.add(NotesModel(
                                            title: titleController.text,
                                            description:
                                                descriptionController.text,
                                            date: dateController.text,
                                            category: categoryController.text));
                                        keysList = box.keys.toList();
                                        setState(() {});
                                        Navigator.pop(context);
                                        titleController.clear();
                                        descriptionController.clear();
                                        dateController.clear();
                                        categoryController.clear();
                                      },
                                      child: Text("Save")),
                                  SizedBox(width: 20),
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        titleController.clear();
                                        descriptionController.clear();
                                        dateController.clear();
                                        categoryController.clear();
                                      },
                                      child: Text("Cancel")),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ));
          SizedBox(
            height: 50,
          );
        },
        child: Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: GridView.builder(
          itemCount: keysList.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 25,
            crossAxisSpacing: 25,
            mainAxisExtent: 180,
          ),
          itemBuilder: (context, index) => Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: myColorList[selecteddataList[index]],
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(box.get(keysList[index])?.title ?? "",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15)),
                      SizedBox(height: 10),
                      Text(
                        box.get(keysList[index])?.description ?? "",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(box.get(keysList[index])?.category ?? "",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15)),
                      Text(
                        box.get(keysList[index])?.date ?? "",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              onPressed: () {
                                //showModalBottomSheet(context);
                              },
                              icon: Icon(Icons.edit)),
                          IconButton(
                              onPressed: () {
                                box.delete(keysList[index]);
                                keysList = box.keys.toList();
                                setState(() {});
                              },
                              icon: Icon(Icons.delete)),
                        ],
                      ),
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
