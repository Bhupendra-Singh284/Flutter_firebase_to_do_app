import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_to_do_app/reusable_widgets/password_visibility.dart';
import 'package:flutter_to_do_app/user_login_screens/loginScreen.dart';
import 'package:flutter_to_do_app/firebase_services/user_authentication.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp();

  runApp(MyApp());
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final AuthenticateUsers authUsers = AuthenticateUsers();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthenticateUsers()),
        ChangeNotifierProvider(create: (context) => PasswordVisibility())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const LoginScreen(),
      ),
    );
  }
}
