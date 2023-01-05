import 'package:flutter/material.dart';
import 'package:flutter_to_do_app/firebase_services/user_authentication.dart';
import 'package:provider/provider.dart';
import 'package:flutter_to_do_app/reusable_widgets/form_elements.dart';
import 'package:flutter_to_do_app/custom_colors.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  bool isVisible = false;

  @override
  void initState() {
    emailController.addListener(() {
      setState(() {});
    });
    passwordController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    popNavigator() {
      Navigator.pop(context);
    }

    //return homepage in a scaffold widget
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Sign Up",
            style: TextStyle(fontSize: 30),
          ),
        ),
        backgroundColor: CustomColors.signInScreensBackgroundColor,
        body: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _formkey,
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(padding: EdgeInsets.only(top: 30)),
                    Formelements.createCustomText(
                        "Create account", 45, Colors.white, false),
                    const Padding(padding: EdgeInsets.all(7)),
                    Formelements.createText(
                        "please enter your sign up details"),
                    const Padding(padding: EdgeInsets.all(20)),
                    Formelements.createEmailfield(
                        emailController, passwordController),
                    const Padding(padding: EdgeInsets.only(bottom: 30)),
                    Formelements.createPasswordfield(
                        emailController, passwordController, context),
                    const Padding(padding: EdgeInsets.all(20)),
                    SizedBox(
                      height: 50,
                      width: 335,
                      child: TextButton(
                          style: Formelements.userLoginorSignupbuttonStyle(),
                          onPressed: () async {
                            if (_formkey.currentState!.validate()) {
                              final authProvider =
                                  Provider.of<AuthenticateUsers>(context,
                                      listen: false);
                              print("Valid form");
                              await authProvider.createUser(
                                  emailController.text.toString(),
                                  passwordController.text.toString());
                              if (authProvider.isUseravailable()) {
                                popNavigator();
                              }
                            }
                          },
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(color: Colors.white, fontSize: 24),
                          )),
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 12)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Formelements.createText("Already have an account?"),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: const ButtonStyle(
                              // Defer to the widget's default.
                              overlayColor: MaterialStatePropertyAll(
                                  Color.fromARGB(255, 21, 109, 181)),
                              foregroundColor: MaterialStatePropertyAll(
                                  Color.fromARGB(255, 255, 255, 255)),
                            ),
                            child: Formelements.createCustomText(
                                ",Login", 22, Colors.white, true))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
