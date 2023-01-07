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
  //create email and password controller for email and password form fields
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //generating unique key for form
  final _formkey = GlobalKey<FormState>();

  //create google signup button by using formelments class
  Container createGoogleSignupButton(BuildContext context, bool check) {
    return Formelements.createGoogleSignupOrLoginButton(context, check);
  }

  @override
  Widget build(BuildContext context) {
    //changing state on email and password field changes
    emailController.addListener(() {
      setState(() {});
    });
    passwordController.addListener(() {
      setState(() {});
    });

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

                    //create main heading text
                    Formelements.createCustomText(
                        "Create account", 45, Colors.white, false),
                    const Padding(padding: EdgeInsets.all(7)),

                    //create sub heading text
                    Formelements.createText(
                        "please enter your sign up details"),

                    const Padding(padding: EdgeInsets.all(20)),

                    //create email text field for user input
                    Formelements.createEmailfield(
                        emailController, passwordController),
                    const Padding(padding: EdgeInsets.only(bottom: 30)),

                    //create password text field for user input
                    Formelements.createPasswordfield(
                        emailController, passwordController, context),
                    const Padding(padding: EdgeInsets.all(20)),

                    //create main sign up button of the page
                    SizedBox(
                      height: 50,
                      width: 335,
                      child: TextButton(
                          //use previously build button style from form elements class
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
                    const Padding(padding: EdgeInsets.only(bottom: 15)),
                    Formelements.createCustomText(
                        "OR", 18, Colors.white, false),

                    //create google signup button
                    const Padding(padding: EdgeInsets.only(bottom: 15)),
                    createGoogleSignupButton(context, false),
                    const Padding(padding: EdgeInsets.only(bottom: 12)),

                    //create enling text and button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Formelements.createText("Already have an account?"),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: const ButtonStyle(
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
