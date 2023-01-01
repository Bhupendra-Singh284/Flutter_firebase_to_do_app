import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_to_do_app/firebase_services/user_authentication.dart';

class SignupScreen extends StatefulWidget {
  final AuthenticateUsers authUser;
  const SignupScreen(this.authUser, {super.key});

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
    void pushHomePage() {
      widget.authUser.pushHomePage(context);
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
        backgroundColor: Colors.lightBlue,
        body: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _formkey,
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Create Account",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 45),
                    ),
                    const Padding(padding: EdgeInsets.all(10)),
                    const Text(
                      "please enter your sign up details.",
                      style: TextStyle(
                          color: Color.fromARGB(255, 240, 235, 235),
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                    const Padding(padding: EdgeInsets.all(20)),
                    TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "enter email";
                          }
                          if (EmailValidator.validate(value) == false) {
                            return "enter valid email";
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.done,
                        controller: emailController,
                        onChanged: (text) {},
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          labelText: "Email",
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "name@gmail.com",
                          prefixIcon: const Icon(Icons.email_rounded),
                          suffixIcon: emailController.text.isEmpty
                              ? const Text("")
                              : IconButton(
                                  color: Colors.blue,
                                  onPressed: () {
                                    emailController.clear();
                                  },
                                  icon: const Icon(Icons.clear)),
                        )),
                    const Padding(padding: EdgeInsets.only(bottom: 30)),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "enter password";
                        }
                        if (value.length < 8) {
                          return "password should be 8 characters long";
                        }

                        return null;
                      },
                      controller: passwordController,
                      obscureText: !isVisible,
                      maxLength: 8,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            )),
                        counterText: "",
                        filled: true,
                        fillColor: Colors.white,
                        suffixIcon: passwordController.text.isEmpty
                            ? Container(
                                width: 0,
                              )
                            : IconButton(
                                onPressed: () {
                                  isVisible = !isVisible;
                                  setState(() {});
                                },
                                icon: isVisible
                                    ? const Icon(Icons.visibility)
                                    : const Icon(Icons.visibility_off)),
                        prefixIcon: const Icon(Icons.key),
                        labelText: "Password",
                        hintText: "Enter password",
                      ),
                      onChanged: (text) {},
                    ),
                    const Padding(padding: EdgeInsets.all(20)),
                    SizedBox(
                      height: 50,
                      width: 335,
                      child: TextButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0))),
                              overlayColor: const MaterialStatePropertyAll(
                                  Color.fromARGB(255, 10, 49, 92)),
                              backgroundColor: const MaterialStatePropertyAll(
                                  Color.fromARGB(255, 17, 72, 116))),
                          onPressed: () async {
                            if (_formkey.currentState!.validate()) {
                              print("Valid form");
                              await widget.authUser.createUser(
                                  emailController.text.toString(),
                                  passwordController.text.toString());

                              if (widget.authUser.isUseravailable()) {
                                pushHomePage();
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
                        const Text(
                          textAlign: TextAlign.start,
                          "Already have an account?",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 230, 226, 226),
                              fontSize: 17),
                        ),
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
                            child: const Text(
                              textAlign: TextAlign.center,
                              ",Login",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ))
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
