import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:simple_loginpage/Login_page.dart';
import 'package:simple_loginpage/Splash_Screen.dart';
import 'package:simple_loginpage/User_UI.dart';
import 'package:simple_loginpage/firebase_options.dart';
import 'package:simple_loginpage/image_adding_FB.dart';
import 'package:simple_loginpage/register_Page.dart';

 Future main()async {
    WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
     home:SplashScreen() // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
