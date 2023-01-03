import 'package:flutter/material.dart';
import 'package:flutter_to_do_app/firebase_services/user_authentication.dart';
import 'package:flutter_to_do_app/reusable_widgets/form_elements.dart';
import 'package:flutter_to_do_app/user_login_screens/signup_screen.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    //return homepage in a scaffold widget

    emailController.addListener(() {
      setState(() {});
    });
    passwordController.addListener(() {
      setState(() {});
    });

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("To Do App", style: TextStyle(fontSize: 30)),
        ),
        backgroundColor: Colors.lightBlue,
        body: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(padding: EdgeInsets.only(top: 30)),
                  Formelements.createCustomText(
                      "Welcome back", 50, Colors.white, false),
                  const Padding(padding: EdgeInsets.all(7)),
                  Formelements.createText(
                      "welcome back! , please enter your login details."),
                  const Padding(padding: EdgeInsets.all(20)),
                  Formelements.createEmailfield(
                      emailController, passwordController),
                  const Padding(padding: EdgeInsets.only(bottom: 30)),
                  Formelements.createPasswordfield(
                      emailController, passwordController, context),
                  Container(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {},
                          style: const ButtonStyle(
                            overlayColor: MaterialStatePropertyAll(
                                Color.fromARGB(255, 21, 109, 181)),
                          ),
                          child: Formelements.createCustomText(
                              "Forgot password?", 16, Colors.white, true))),
                  const Padding(padding: EdgeInsets.only(bottom: 12)),
                  SizedBox(
                    height: 50,
                    width: 335,
                    child: TextButton(
                        style: Formelements.userLoginorSignupbuttonStyle(),
                        onPressed: () async {
                          if (_formkey.currentState!.validate()) {
                            final authProvider = Provider.of<AuthenticateUsers>(
                                context,
                                listen: false);
                            await authProvider.signInUser(
                                emailController.text.toString(),
                                passwordController.text.toString(),
                                context);
                          }
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        )),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 15)),
                  Formelements.createCustomText("OR", 18, Colors.white, false),
                  const Padding(padding: EdgeInsets.only(bottom: 15)),
                  SizedBox(
                    height: 50,
                    width: 335,
                    child: TextButton.icon(
                      icon: const FaIcon(
                        FontAwesomeIcons.google,
                      ),
                      onPressed: () {},
                      style: Formelements.userLoginorSignupbuttonStyle(),
                      label: const Text(
                        "Sign in with google",
                        style: TextStyle(color: Colors.white, fontSize: 19),
                      ),
                    ),
                  ),
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
                            // Defer to the widget's default.
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
