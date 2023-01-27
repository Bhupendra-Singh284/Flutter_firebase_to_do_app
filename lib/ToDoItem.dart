import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_to_do_app/reusable_widgets/checkbox.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ToDoItem extends ChangeNotifier {
  var refTodoTask;
  var refCompletedTask;
  bool _tododataChecked = false;
  bool _completedtaskDataChecked = false;

  bool tododataChecked() {
    return _tododataChecked;
  }

  bool completedTaskdataChecked() {
    return _completedtaskDataChecked;
  }

  var todoTaskskeys = [];
  var completedTaskKeys = [];

  void signOutUser() {
    todoTasks.clear();
    completedTasks.clear();
    todoTaskskeys.clear();
    completedTaskKeys.clear();
    _tododataChecked = false;
    _completedtaskDataChecked = false;
  }

  void setData() {
    refTodoTask = FirebaseDatabase.instance.ref().child(
        "${FirebaseAuth.instance.currentUser!.providerData[0].email.toString().replaceAll('.', ',')}/TodoTask+");
    refCompletedTask = FirebaseDatabase.instance.ref().child(
        "${FirebaseAuth.instance.currentUser!.providerData[0].email.toString().replaceAll('.', ',')}/CompletedTask+");
  }

  void readTodoTaskData() async {
    final pref = await refTodoTask.get();

    final task = pref.children.toList();

    if (task.isEmpty) {
      _tododataChecked = true;
      notifyListeners();
      return;
    }

    for (int i = 0; i < task.length; i++) {
      todoTaskskeys.add(task[i].key.toString());
      final map = task[i].value as Map;
      todoTasks[map["title"]] = map["description"];
    }

    _tododataChecked = true;
    notifyListeners();
  }

  void readCompletedTaskData() async {
    final pref = await refCompletedTask.get();

    final task = pref.children.toList();

    if (task.isEmpty) {
      _completedtaskDataChecked = true;
      notifyListeners();
      return;
    }

    for (int i = 0; i < task.length; i++) {
      completedTaskKeys.add(task[i].key.toString());
      final map = task[i].value as Map;
      completedTasks[map["title"]] = map["description"];
    }

    _completedtaskDataChecked = true;
    notifyListeners();
  }

  final todoTasks = {};
  final completedTasks = {};

  bool isListEmpty() {
    print("checking list");

    return todoTasks.isEmpty;
  }

  bool isCompletedTaskListEmpty() {
    return completedTasks.isEmpty;
  }

  int sizeofList() {
    return todoTasks.length;
  }

  void addNewTask(String inputTitle, String inputDescription,
      bool addinCompletedList) async {
    if (addinCompletedList) {
      completedTasks[inputTitle] = inputDescription;
      final key = refCompletedTask.push().key;
      refCompletedTask
          .child(key.toString())
          .set({"title": inputTitle, "description": inputDescription});
      completedTaskKeys.add(key.toString());
    } else {
      todoTasks[inputTitle] = inputDescription;
      final key = refTodoTask.push().key;
      refTodoTask
          .child(key.toString())
          .set({"title": inputTitle, "description": inputDescription});
      todoTaskskeys.add(key.toString());
      print(key.toString());
    }
    notifyListeners();
  }

  void deleteCompletedTask(int index) {
    Timer(const Duration(milliseconds: 130), (() {
      refCompletedTask.child(completedTaskKeys[index].toString()).remove();
      completedTaskKeys.removeAt(index);
      completedTasks.remove(completedTasks.keys.elementAt(index));
      notifyListeners();
    }));
  }

  void deleteTask(bool addToCompletedList, int index) {
    if (addToCompletedList) {
      addNewTask(todoTasks.keys.elementAt(index),
          todoTasks.values.elementAt(index), true);
    }
    Timer(Duration(milliseconds: addToCompletedList ? 0 : 150), (() {
      refTodoTask.child(todoTaskskeys[index].toString()).remove();
      todoTaskskeys.removeAt(index);
      todoTasks.remove(todoTasks.keys.elementAt(index));

      notifyListeners();
    }));
  }

  Padding createList(bool showCompletedList, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: ListView.separated(
          separatorBuilder: (context, index) {
            return const SizedBox(height: 30);
          },
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount:
              showCompletedList ? completedTasks.length : todoTasks.length,
          itemBuilder: (context, index) {
            return showCompletedList
                ? createTile(completedTasks, true, index)
                : createTile(todoTasks, false, index);
          }),
    );
  }

  Container createTile(Map task, bool completedListTile, int index) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
                color: Color.fromARGB(255, 205, 200, 200),
                offset: Offset(1, 1),
                blurRadius: 1,
                spreadRadius: 0.1)
          ]),
      child: ListTile(
        onTap: () {},
        horizontalTitleGap: 8,
        dense: true,
        isThreeLine: false,
        contentPadding: const EdgeInsets.all(7),
        shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 0,
              color: const Color.fromARGB(255, 196, 194, 194).withOpacity(0.7),
            ),
            borderRadius: BorderRadius.circular(20)),
        trailing: SizedBox(
          width: 76,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              completedListTile
                  ? const Text("")
                  : Material(
                      color: Colors.transparent,
                      child: IconButton(
                        isSelected: true,
                        splashColor: const Color.fromARGB(255, 126, 172, 250),
                        splashRadius: 20,
                        iconSize: 26,
                        constraints: const BoxConstraints(),
                        padding: const EdgeInsets.only(right: 10),
                        icon: const Icon(Icons.edit_note_rounded),
                        color: Colors.blue.withOpacity(0.9),
                        onPressed: () {
                          print("tapped edit button");
                        },
                      ),
                    ),
              const Padding(padding: EdgeInsets.only(right: 5)),
              Material(
                color: Colors.transparent,
                child: IconButton(
                  splashColor: const Color.fromARGB(255, 126, 172, 250),
                  splashRadius: 20,
                  constraints: const BoxConstraints(),
                  padding: const EdgeInsets.only(right: 8),
                  iconSize: 26,
                  icon: const Icon(Icons.delete_rounded),
                  color:
                      const Color.fromARGB(253, 41, 152, 249).withOpacity(0.9),
                  onPressed: () {
                    completedListTile
                        ? deleteCompletedTask(index)
                        : deleteTask(false, index);
                    print("tapped delete button");
                  },
                ),
              )
            ],
          ),
        ),
        leading: completedListTile
            ? IconButton(
                onPressed: () {},
                iconSize: 29,
                icon: const Icon(Icons.check_box_outlined))
            : Mycheckbox(
                index: index,
              ),
        subtitle: Text(
          task[task.keys.elementAt(index)].toString(),
          style: const TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 15,
            color: Color.fromARGB(255, 178, 174, 174),
            fontWeight: FontWeight.w200,
          ),
        ),
        title: Text(
          task.keys.elementAt(index).toString(),
          style: const TextStyle(
              fontSize: 18,
              color: Color.fromARGB(255, 60, 59, 59),
              fontFamily: 'Lato_bold',
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
