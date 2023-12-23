import 'package:flutter/material.dart';
import 'dart:async';
import 'package:hive/hive.dart';
import 'package:TaskVault/data/database.dart';
import 'package:TaskVault/util/dialog_box.dart';
import 'package:TaskVault/util/todo_tile.dart';

/// modifications..................................................

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Add delay
    Timer(Duration(seconds: 5), () {
      // Go to the next screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // child: FlutterLogo(size: 150),
        child: Image.asset(
          'assets/images/TVB.png',
          height: 200,
        ),
      ),
    );
  }
}

//// mod end.......................................................

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //reference the hive box
  final _mybox = Hive.box('mybox');
  ToDodataBase db = ToDodataBase();

  @override
  void initState() {
    // if first tym opening app create default data
    if (_mybox.get("TODOLIST") == null) {
      db.createinitialData();
    } else {
      //ther already exists data
      db.loadData();
    }
    super.initState();
  }

  //text controller
  final _controller = TextEditingController();

  // checkbox was changed
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  // save new task

  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  // create new task
  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return dialogbox(
            controller: _controller,
            onSave: saveNewTask,
            onCancel: () => Navigator.of(context).pop(),
          );
        });
  }

// delete task

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(
            child: Text(
          'Task Vault',
          style: TextStyle(
            color: Colors.white,
          ),
        )),
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 35, 35, 35),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: db.toDoList[index][0],
            taskCompleted: db.toDoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}
