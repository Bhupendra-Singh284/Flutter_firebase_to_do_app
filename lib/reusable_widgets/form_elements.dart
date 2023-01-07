import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_to_do_app/firebase_services/user_authentication.dart';
import 'package:flutter_to_do_app/reusable_widgets/password_visibility.dart';
import 'package:provider/provider.dart';
import 'package:flutter_to_do_app/custom_colors.dart';

class Formelements {
  static ButtonStyle userLoginorSignupbuttonStyle() {
    return ButtonStyle(
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))),
        overlayColor: const MaterialStatePropertyAll(
            CustomColors.mainButtonsOverlaycolor),
        backgroundColor:
            const MaterialStatePropertyAll(CustomColors.signupOrLogincolor));
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
            return "Enter email";
          }
          if (EmailValidator.validate(value) == false) {
            return "Enter valid email";
          }

          return null;
        },
        textInputAction: TextInputAction.done,
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          errorStyle:
              const TextStyle(fontSize: 15, color: CustomColors.errorTextcolor),
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
          return "Enter password";
        }
        if (value.length < 8) {
          return "Password should be 8 characters long";
        }

        return null;
      },
      controller: passwordController,
      obscureText: !passwordVisibility.isVisible,
      maxLength: 8,
      decoration: InputDecoration(
        errorStyle:
            const TextStyle(fontSize: 15, color: CustomColors.errorTextcolor),
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
                    ? const Icon(Icons.visibility)
                    : const Icon(Icons.visibility_off)),
        prefixIcon: const Icon(Icons.key),
        labelText: "Passsword",
        hintText: "Enter password",
      ),
    );
  }

  //create google sign in or log in
  static Container createGoogleSigninOrLoginButton(
      BuildContext context, bool check) {
    final authProvider = Provider.of<AuthenticateUsers>(context, listen: false);
    return Container(
        padding: const EdgeInsets.all(2),
        height: 50,
        width: 335,
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.all(Radius.circular(22))),
        child: TextButton(
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Image(image: AssetImage("assets/images/google_logo.png")),
            Formelements.createCustomText(
                check ? " Sign in with google" : "Sign up with google",
                18,
                Colors.black,
                false)
          ]),
          onPressed: () async {
            await authProvider.signInWithGoogle(check, context);
          },
        ));
  }
}
