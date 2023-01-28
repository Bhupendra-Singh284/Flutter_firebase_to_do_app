import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_to_do_app/AppPagesWidgets.dart';
import 'package:flutter_to_do_app/App_pages/Completed_Tasks.dart';
import 'package:flutter_to_do_app/ToDoItem.dart';
import 'package:provider/provider.dart';
import 'package:flutter_to_do_app/firebase_services/user_authentication.dart';
import 'package:flutter_to_do_app/custom_colors.dart';
import 'package:flutter_to_do_app/App_pages/To_Do_page.dart';

class Homepage extends StatefulWidget {
  Homepage({super.key, required this.providerTodoItem});

  final ToDoItem providerTodoItem;
  final textController = TextEditingController();

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final DatabaseReference ref = FirebaseDatabase.instance.ref();

  String email = FirebaseAuth.instance.currentUser?.providerData[0].email
          .toString()
          .replaceAll('.', ',') ??
      "";

  int selectedIndex = 0;

  @override
  void initState() {
    read();
    super.initState();
  }

  void read() async {
    widget.providerTodoItem.setData();
    widget.providerTodoItem.readTodoTaskData();
    widget.providerTodoItem.readCompletedTaskData();
  }

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  final screens = [const ToDoPage(), const CompletedTasks()];

  Container createBottomNavigationBar() {
    return Container(
        decoration: const BoxDecoration(boxShadow: [
          BoxShadow(
              spreadRadius: 0.8,
              blurRadius: 2,
              color: Color.fromARGB(255, 160, 160, 162))
        ]),
        child: BottomNavigationBar(
            selectedLabelStyle: const TextStyle(
                fontFamily: 'Lato', fontWeight: FontWeight.w500),
            unselectedLabelStyle: const TextStyle(fontFamily: 'Lato'),
            elevation: 0,
            backgroundColor: CustomColors.themeColor,
            unselectedItemColor: Colors.white.withOpacity(0.7),
            selectedItemColor: Colors.white,
            selectedFontSize: 17,
            selectedIconTheme: const IconThemeData(size: 30),
            unselectedFontSize: 14,
            currentIndex: selectedIndex,
            onTap: (index) => setState(() {
                  selectedIndex = index;
                }),
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.fact_check_outlined), label: "All To Do's"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.done), label: "Completed")
            ]));
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthenticateUsers>(context);
    final todoItemProvider = Provider.of<ToDoItem>(context);
    email = email.replaceAll('.', ',');

    return Scaffold(
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: createBottomNavigationBar(),
        backgroundColor: Colors.white,
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
            elevation: 3,
            onPressed: () {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) => AppPageWidgets.addOrEditTask(
                      -1,
                      todoItemProvider,
                      false,
                      titleController,
                      descriptionController,
                      _formkey,
                      context));
            },
            backgroundColor: CustomColors.themeColor,
            child: const Icon(Icons.add, color: Colors.white, size: 34)),
        appBar: AppBar(
            elevation: 1.3,
            actions: [
              TextButton(
                  onPressed: () {
                    todoItemProvider.signOutUser();
                    authProvider.signoutUser();
                  },
                  child: const Text(
                    "Log out",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        decoration: TextDecoration.underline),
                  ))
            ],
            centerTitle: true,
            automaticallyImplyLeading: false,
            title: const Text(
              "To Do App",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 27,
                  color: Colors.white,
                  fontFamily: 'Lato'),
            )),
        body: screens[selectedIndex]);
  }
}
