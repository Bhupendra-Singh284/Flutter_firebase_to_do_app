import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_to_do_app/firebase_services/user_authentication.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthenticateUsers>(context);

    String displayName() {
      return authProvider.user?.email ?? "NO USER";
    }

    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false, title: const Text("Homepage")),
        body: Column(
          children: [
            Text("Hello${displayName()}"),
            TextButton(
                style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Colors.deepOrange)),
                onPressed: () {
                  authProvider.signoutUser();
                },
                child: const Text("Sign out"))
          ],
        ));
  }
}
