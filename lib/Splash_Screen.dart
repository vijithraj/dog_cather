import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_loginpage/Login_page.dart';
import 'package:simple_loginpage/User_UI.dart';
import 'package:simple_loginpage/User_profile.dart';
import 'package:simple_loginpage/register_Page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    Timer(Duration(seconds: 15),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>


              Login_page() )
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              height: 200,
              width: 200,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      image: AssetImage("images/stray.png")
                  )
              ),
            ),
          ),
          SizedBox(height: 8,),
          Text("Dog cather",style: TextStyle(fontSize: 25,
              color: CupertinoColors.systemIndigo),)


        ],
      ),

    );
  }
}
