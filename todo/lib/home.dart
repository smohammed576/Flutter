import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/constants/colors.dart';
import 'package:todo/models/task.dart';
import 'package:uuid/uuid.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> list = [];
  final TextEditingController _textController = TextEditingController();
  int updateIndex = -1;
  bool? selected;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> saveTask() async {
    final prefs = await SharedPreferences.getInstance();
    final json = list.map((task) => task.toJson()).toList();
    prefs.setString('tasks', jsonEncode(json));
    loadData();
  }

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final string = prefs.getString('tasks');
    if (string != null) {
      final List<dynamic> json = jsonDecode(string);
      setState(() {
        list = json.map((task) => Task.fromJson(task)).toList();
      });
    }
  }

  updateTask(Task task, int index) {
    setState(() {
      list[index] = task;

      updateIndex = -1;
      _textController.clear();
    });
  }

  void deleteTask(index) {
    setState(() {
      list.removeAt(index);
    });
    saveTask();
  }

  void removeChecked() {
    setState(() {
      list.removeWhere((task) => task.checked);
    });
    saveTask();
  }

  @override
  Widget build(BuildContext context) {
    final bool hasChecked = list.any((task) => task.checked);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Takenlijstje',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? darkTheme.cardColor
            : lightTheme.cardColor,
        foregroundColor: Colors.white,
        onPressed: () {
          _displayModalBottomSheet();
        },
        child: Icon(Icons.add),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (list.isEmpty)
              Expanded(
                flex: 1,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.start,
                        children: [
                          Transform.rotate(
                            angle: 50,
                            child: SizedBox(
                              width: 155,
                              child: Text(
                                'Voeg je eerste taak toe',
                                style: GoogleFonts.handlee(fontSize: 25),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Image.asset(
                            'assets/arrow.png',
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : null,
                            fit: BoxFit.contain,
                            width: 250,
                            height: 300,
                            alignment: Alignment.topRight,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            if (list.isNotEmpty)
              Expanded(
                child: ReorderableListView.builder(
                  onReorder: (int old, int newIndex) {
                    setState(() {
                      if (old < newIndex) {
                        newIndex -= 1;
                      }
                      final item = list.removeAt(old);
                      list.insert(newIndex, item);
                      saveTask();
                    });
                  },
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    final task = list[index];
                    return Dismissible(
                      key: Key(task.id),
                      direction: DismissDirection.endToStart,
                      onDismissed: (_) => deleteTask(index),
                      background: Container(),
                      secondaryBackground: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? darkTheme.cardColor
                              : lightTheme.cardColor,
                        ),
                      ),
                      child: ListTile(
                        onTap: () {
                          setState(() {
                            task.checked = !task.checked;
                          });
                          saveTask();
                        },
                        leading: Radio<bool>(
                          activeColor:
                              Theme.of(context).brightness == Brightness.dark
                              ? darkTheme.cardColor
                              : lightTheme.cardColor,
                          value: true,
                          groupValue: task.checked ? true : null,
                          onChanged: (value) {
                            setState(() {
                              task.checked = !task.checked;
                            });
                            saveTask();
                          },
                        ),
                        title: Text(
                          task.text,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: task.checked
                                ? TextDecoration.lineThrough
                                : null,
                            color: task.checked ? darkTheme.primaryColor : null,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            if (hasChecked == true)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: TextButton(
                  onPressed: () {
                    removeChecked();
                  },
                  child: Text(
                    'Wis afgevinkte taken',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      decorationColor:
                          Theme.of(context).brightness == Brightness.dark
                          ? darkTheme.cardColor
                          : lightTheme.cardColor,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? darkTheme.cardColor
                          : lightTheme.cardColor,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _displayModalBottomSheet() {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Row(
            children: [
              Expanded(
                child: TextField(autofocus: true, controller: _textController),
              ),
              SizedBox(width: 10),
              IconButton(
                style: IconButton.styleFrom(
                  backgroundColor:
                      Theme.of(context).brightness == Brightness.dark
                      ? darkTheme.cardColor
                      : lightTheme.cardColor,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  if (_textController.text.trim().isNotEmpty) {
                    var uuid = Uuid();
                    String id = uuid.v4();
                    setState(() {
                      list.add(
                        Task(id: id, text: _textController.text, checked: false),
                      );
                      _textController.clear();
                    });
                    saveTask();
                  }
                },
                icon: Icon(Icons.keyboard_arrow_up),
              ),
            ],
          ),
        );
      },
    );
  }
}
