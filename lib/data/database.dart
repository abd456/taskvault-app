import 'package:hive_flutter/hive_flutter.dart';

class ToDodataBase{
  List toDoList = [];

  //reference our box
  final _mybox = Hive.box('mybox');

  //run this  if first time opening
  void createinitialData() {
    toDoList = [
      ["Make Tutorial",false],
      ["Do Exercise",false],
    ];
  }

  //load data from database
  void loadData(){
    toDoList = _mybox.get("TODOLIST");
  }
  
  //update database
  void updateDataBase(){
    _mybox.put("TODOLIST", toDoList);
  }

}
