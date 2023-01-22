import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_to_do_app/App_pages/Completed_Tasks.dart';
import 'package:flutter_to_do_app/ToDoItem.dart';
import 'package:provider/provider.dart';
import 'package:flutter_to_do_app/firebase_services/user_authentication.dart';
import 'package:flutter_to_do_app/custom_colors.dart';
import 'package:flutter_to_do_app/App_pages/To_Do_page.dart';

class Homepage extends StatefulWidget {
  Homepage({super.key});
  final DatabaseReference ref = FirebaseDatabase.instance.ref();
  final textController = TextEditingController();

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String email =
      FirebaseAuth.instance.currentUser?.providerData[0].email.toString() ?? "";
  int selectedIndex = 0;

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  final screens = [const ToDoPage(), const CompletedTasks()];

  AlertDialog addNewTask(final todoItemProvider) {
    titleController.clear();
    descriptionController.clear();
    return AlertDialog(
      title: const Text(
        "Add new task",
        style: TextStyle(
            fontFamily: 'Lato', fontWeight: FontWeight.w500, fontSize: 28),
      ),
      contentPadding: const EdgeInsets.all(20),
      actions: [
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          SizedBox(
            height: 40,
            child: ElevatedButton(
                style:
                    const ButtonStyle(elevation: MaterialStatePropertyAll(2)),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(
                      fontSize: 18, color: Colors.white, fontFamily: 'Lato'),
                )),
          ),
          const Padding(padding: EdgeInsets.only(right: 15)),
          SizedBox(
            height: 40,
            child: ElevatedButton(
                style:
                    const ButtonStyle(elevation: MaterialStatePropertyAll(2)),
                onPressed: () {
                  if (_formkey.currentState!.validate()) {
                    print("correct input");
                    todoItemProvider.addNewTask(titleController.text.toString(),
                        descriptionController.text.toString());
                    Navigator.pop(context);
                  }
                },
                child: const Text(
                  "Add",
                  style: TextStyle(
                      fontSize: 18, color: Colors.white, fontFamily: 'Lato'),
                )),
          ),
          const Padding(padding: EdgeInsets.only(right: 10)),
        ])
      ],
      content: SizedBox(
        width: 150,
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(padding: EdgeInsets.only(bottom: 10)),
              const Text(
                "Title",
                style: TextStyle(
                    fontSize: 19,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w200),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 20)),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter a title";
                  }
                  if (value.length > 60) {
                    return "Title should be between 0 to 60 letters";
                  }
                  return null;
                },
                controller: titleController,
                minLines: 1,
                maxLines: 1,
                style: const TextStyle(fontSize: 18, height: 1.5),
                decoration: const InputDecoration(
                    errorStyle: TextStyle(fontSize: 14),
                    isDense: true,
                    counterText: "",
                    contentPadding: EdgeInsets.only(bottom: 10)),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 16)),
              const Text(
                "Description",
                style: TextStyle(
                    fontSize: 19,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w500),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 20)),
              TextFormField(
                controller: descriptionController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter description";
                  }
                  if (value.length > 150) {
                    return "Description should be between 0 to 150 letters";
                  }
                  return null;
                },
                minLines: 1,
                maxLines: 3,
                style: const TextStyle(fontSize: 18, height: 1.5),
                decoration: const InputDecoration(
                    errorStyle: TextStyle(fontSize: 14),
                    counterText: "",
                    isDense: true,
                    contentPadding: EdgeInsets.only(bottom: 10)),
              )
            ],
          ),
        ),
      ),
    );
  }

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
                  builder: (context) => addNewTask(todoItemProvider));
            },
            backgroundColor: CustomColors.themeColor,
            child: const Icon(Icons.add, color: Colors.white, size: 34)),
        appBar: AppBar(
            elevation: 1.3,
            actions: [
              TextButton(
                  onPressed: () {
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
