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

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthenticateUsers>(context);
    email = email.replaceAll('.', ',');

    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: CustomColors.themeColor,
            unselectedItemColor: Colors.white.withOpacity(0.7),
            selectedItemColor: Colors.white,
            selectedFontSize: 20,
            currentIndex: selectedIndex,
            onTap: (index) => setState(() {
                  selectedIndex = index;
                }),
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.fact_check_outlined), label: "To Do's"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.done), label: "Completed")
            ]),
        backgroundColor: Colors.white,
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
            onPressed: () {},
            backgroundColor: CustomColors.themeColor,
            child: const Icon(Icons.add, color: Colors.white, size: 34)),
        appBar: AppBar(
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
              style: TextStyle(fontSize: 27, color: Colors.white),
            )),
        body: screens[selectedIndex]);
  }
}
