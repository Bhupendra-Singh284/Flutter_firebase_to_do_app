import 'package:flutter/material.dart';
import 'package:flutter_to_do_app/firebase_services/user_authentication.dart';
import 'package:flutter_to_do_app/reusable_widgets/form_elements.dart';
import 'package:flutter_to_do_app/user_login_screens/signup_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_to_do_app/custom_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //create email and password controllers for the email and password field in the form
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //create a form key for unique identification of the form
  final _formkey = GlobalKey<FormState>();

  //method to create google login button via form elements reusable widgets
  Container createGoogleLoginButton(BuildContext context, bool check) {
    return Formelements.createGoogleSignupOrLoginButton(context, check);
  }

  @override
  Widget build(BuildContext context) {
    //create a provider to call authentication funtions
    final authProvider = Provider.of<AuthenticateUsers>(context, listen: false);

    //on listening to changes allow email and password controller to change state
    emailController.addListener(() {
      setState(() {});
    });
    passwordController.addListener(() {
      setState(() {});
    });

    return Scaffold(
        appBar: AppBar(
          elevation: 1.6,
          centerTitle: true,
          title: const Text("To Do App", style: TextStyle(fontSize: 30)),
        ),
        backgroundColor: CustomColors.signInScreensBackgroundColor,
        body: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(padding: EdgeInsets.only(top: 30)),

                  //create welcome text
                  Formelements.createCustomText(
                      "Welcome back", 50, Colors.white, false),
                  const Padding(padding: EdgeInsets.all(7)),

                  //create sub headig
                  Formelements.createText(
                      "welcome back! , please enter your login details."),
                  const Padding(padding: EdgeInsets.all(20)),

                  //create email field for user input
                  Formelements.createEmailfield(
                      emailController, passwordController),
                  const Padding(padding: EdgeInsets.only(bottom: 30)),

                  //create password field for user input
                  Formelements.createPasswordfield(
                      emailController, passwordController, context),

                  const Padding(padding: EdgeInsets.only(bottom: 30)),
                  SizedBox(
                    height: 50,
                    width: 335,
                    child: TextButton(
                        //use the custom style from from frorm elements class
                        style: Formelements.userLoginorSignupbuttonStyle(),
                        onPressed: () async {
                          if (_formkey.currentState!.validate()) {
                            await authProvider.signInUser(
                                emailController.text.toString(),
                                passwordController.text.toString(),
                                context);
                          }
                        },
                        child: Formelements.createCustomText(
                            "Login", 24, Colors.white, false)),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 15)),
                  Formelements.createCustomText("OR", 18, Colors.white, false),

                  //create google login button
                  const Padding(padding: EdgeInsets.only(bottom: 15)),
                  createGoogleLoginButton(context, true),

                  const Padding(padding: EdgeInsets.only(bottom: 110)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Formelements.createText("Don't have an account?"),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const SignupScreen()));
                          },
                          style: const ButtonStyle(
                            overlayColor: MaterialStatePropertyAll(
                                Color.fromARGB(255, 21, 109, 181)),
                            foregroundColor: MaterialStatePropertyAll(
                                Color.fromARGB(255, 255, 255, 255)),
                          ),
                          child: Formelements.createCustomText(
                              ",Sign up", 24, Colors.white, true))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
