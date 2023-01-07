import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_to_do_app/firebase_services/user_authentication.dart';
import 'package:flutter_to_do_app/reusable_widgets/form_elements.dart';

class Homepage extends StatelessWidget {
  Homepage({super.key});

  //create an instance of firebase realtime database for read and write
  final DatabaseReference ref = FirebaseDatabase.instance.ref("post");
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthenticateUsers>(context);

    String displayName() {
      return FirebaseAuth.instance.currentUser?.providerData[0].email ?? "";
    }

    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false, title: const Text("Homepage")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Hello${displayName()}"),
              TextField(
                controller: textController,
                decoration:
                    const InputDecoration(hintText: "What is on your mind"),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 20)),
              TextButton(
                  style: Formelements.userLoginorSignupbuttonStyle(),
                  onPressed: () async {
                    showDialog(
                        context: context,
                        builder: ((context) => const AlertDialog()));
                    await ref
                        .set({'value': textController.text.toString()})
                        .then((value) => "Data saved successfully")
                        .catchError((onError) {
                          print(onError.toString());
                        });
                  },
                  child: Formelements.createCustomText(
                      "Write to database", 20, Colors.white, false)),
              const Padding(padding: EdgeInsets.only(bottom: 20)),
              TextButton(
                  style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.deepOrange)),
                  onPressed: () {
                    authProvider.signoutUser();
                  },
                  child: Formelements.createText("Sign Out"))
            ],
          ),
        ));
  }
}
