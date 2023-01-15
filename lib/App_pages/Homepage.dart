import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_to_do_app/App_pages/Completed_Tasks.dart';
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

  final screens = [ToDoPage(), const CompletedTasks()];

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
                  builder: (context) => addNewTask());
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

AlertDialog addNewTask() {
  return AlertDialog(
    title: const Text(
      "Add new task",
      style: TextStyle(
          fontFamily: 'Lato', fontWeight: FontWeight.w500, fontSize: 28),
    ),
    contentPadding: const EdgeInsets.all(20),
    actions: [
      SizedBox(
        height: 40,
        child: ElevatedButton(
            style: const ButtonStyle(elevation: MaterialStatePropertyAll(3)),
            onPressed: () {},
            child: const Text(
              "Add",
              style: TextStyle(
                  fontSize: 18, color: Colors.white, fontFamily: 'Lato'),
            )),
      )
    ],
    content: SizedBox(
      width: 150,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Padding(padding: EdgeInsets.only(bottom: 10)),
          Text(
            "Title",
            style: TextStyle(
                fontSize: 19, fontFamily: 'Lato', fontWeight: FontWeight.w200),
          ),
          Padding(padding: EdgeInsets.only(bottom: 20)),
          TextField(
            maxLines: 3,
            maxLength: 60,
            minLines: 1,
            style: TextStyle(fontSize: 18, height: 1.5),
            decoration: InputDecoration(
                counterText: "",
                isDense: true,
                contentPadding: EdgeInsets.only(bottom: 10)),
          ),
          Padding(padding: EdgeInsets.only(bottom: 16)),
          Text(
            "Description",
            style: TextStyle(
                fontSize: 19, fontFamily: 'Lato', fontWeight: FontWeight.w500),
          ),
          Padding(padding: EdgeInsets.only(bottom: 20)),
          TextField(
            maxLength: 200,
            minLines: 1,
            maxLines: 10,
            style: TextStyle(fontSize: 18, height: 1.5),
            decoration: InputDecoration(
                counterText: "",
                isDense: true,
                contentPadding: EdgeInsets.only(bottom: 10)),
          )
        ],
      ),
    ),
  );
}
