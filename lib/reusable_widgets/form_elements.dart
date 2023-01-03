import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_to_do_app/reusable_widgets/password_visibility.dart';
import 'package:provider/provider.dart';

class Formelements {
  static ButtonStyle userLoginorSignupbuttonStyle() {
    return ButtonStyle(
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))),
        overlayColor:
            const MaterialStatePropertyAll(Color.fromARGB(255, 10, 49, 92)),
        backgroundColor:
            const MaterialStatePropertyAll(Color.fromARGB(255, 17, 72, 116)));
  }

  static Text createCustomText(
      String text, double size, Color color, bool underline) {
    return Text(text,
        style: TextStyle(
            fontSize: size,
            color: color,
            fontWeight: FontWeight.bold,
            decoration:
                underline ? TextDecoration.underline : TextDecoration.none));
  }

  static Text createText(String text) {
    return Text(
      text,
      style: const TextStyle(
          color: Color.fromARGB(255, 239, 233, 233),
          fontSize: 18,
          fontWeight: FontWeight.bold),
    );
  }

  static TextFormField createEmailfield(TextEditingController emailController,
      TextEditingController passwordController) {
    return TextFormField(
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
        ));
  }

  static TextFormField createPasswordfield(
      TextEditingController emailController,
      TextEditingController passwordController,
      BuildContext context) {
    final passwordVisibility = Provider.of<PasswordVisibility>(context);
    return TextFormField(
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
      obscureText: passwordVisibility.isVisible,
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
                  print("Tapped");
                  passwordVisibility.toggleVisibility();
                },
                icon: passwordVisibility.isVisible
                    ? const Icon(Icons.visibility_off)
                    : const Icon(Icons.visibility)),
        prefixIcon: const Icon(Icons.key),
        labelText: "Passsword",
        hintText: "Enter password",
      ),
    );
  }
}
