import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_to_do_app/App_pages/Homepage.dart';
import 'package:flutter_to_do_app/reusable_widgets/password_visibility.dart';
import 'package:flutter_to_do_app/user_login_screens/loginScreen.dart';
import 'package:flutter_to_do_app/firebase_services/user_authentication.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

void main() async {
  //ensure all resources have been loaded
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  //remove the top bar in mobile
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  //keep splash screen active until the below resources is not fully loaded
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  //ensure firebase is been initialized
  await Firebase.initializeApp();

  //after loading of all the resources remove the splash screen
  FlutterNativeSplash.remove();

  //create multiproviders for state management and to access their functions througout the MyApp
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => AuthenticateUsers()),
    ChangeNotifierProvider(create: (context) => PasswordVisibility())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of our application. first widget to be built
  @override
  Widget build(BuildContext context) {
    //create a provider to access the current state of the user
    final authProvider = Provider.of<AuthenticateUsers>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //keep returning login screen until any user detected in the firebase
      home: authProvider.isUseravailable() ? Homepage() : const LoginScreen(),
    );
  }
}
