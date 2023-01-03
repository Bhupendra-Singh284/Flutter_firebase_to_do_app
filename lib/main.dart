import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_to_do_app/App_pages/Homepage.dart';
import 'package:flutter_to_do_app/reusable_widgets/password_visibility.dart';
import 'package:flutter_to_do_app/user_login_screens/loginScreen.dart';
import 'package:flutter_to_do_app/firebase_services/user_authentication.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => AuthenticateUsers()),
    ChangeNotifierProvider(create: (context) => PasswordVisibility())
  ], child: const MyApp()));

  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthenticateUsers>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: authProvider.isUseravailable()
          ? const Homepage()
          : const LoginScreen(),
    );
  }
}
