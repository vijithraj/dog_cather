import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_loginpage/User_UI.dart';
import 'package:simple_loginpage/register_Page.dart';

class Login_page extends StatefulWidget {
  const Login_page({Key? key}) : super(key: key);

  @override
  State<Login_page> createState() => _Login_pageState();
}

class _Login_pageState extends State<Login_page> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passeordcontroller = TextEditingController();
  bool showpassword = false;

  Future<void> save() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailcontroller.text, password: passeordcontroller.text);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("error${e}")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 70,),
            Card(
              color: Colors.white70,
              semanticContainer: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 5,
              margin: EdgeInsets.all(10),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Text("Login",style: TextStyle(fontSize: 35,fontWeight:FontWeight.bold),),
                    SizedBox(height: 27,),
                    TextFormField(
                      controller: emailcontroller,
                      style: MyFonts.roboto(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      decoration: const InputDecoration(
                        hintText: "Enter your email",
                        labelText: "email",
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a valid email address.';
                        }
                        if (!RegExp(
                                r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                            .hasMatch(value)) {
                          return 'Please enter a valid email address.';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        controller: passeordcontroller,
                        obscureText: showpassword,
                        onTap: () {
                          setState(() {
                            showpassword = !showpassword;
                          });
                        },
                        decoration: InputDecoration(
                            labelText: "Password",
                            suffixIcon: Icon(showpassword
                                ? Icons.visibility
                                : Icons.visibility_off),
                            labelStyle: TextStyle(color: Colors.black),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.all(Radius.zero),
                            )),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          if (value.length < 8 ||
                              !RegExp(r'^[0-9]+$').hasMatch(value) ||
                              !RegExp(r'^[%^*$#]').hasMatch(value)) {
                            return 'Please enter minimum 8 characters with one number and one symbol';
                          }
                          return null;
                        }),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account ?",
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Register_page()));
                            },
                            child: const Text(
                              "Sign up",
                              style: TextStyle(
                                  fontSize: 20, color: Colors.blueAccent),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                        height: 30,
                        width: 180,
                        child: ElevatedButton(
                            onPressed: () {
                              save();
                            },
                            child: Text("Login"))),
                    SizedBox(
                      height: 50,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(radius: 15,
                  backgroundImage: AssetImage(
                    "images/google.png",
                  ),
                  backgroundColor: Colors.white,
                ),
                SizedBox(
                  width: 20,
                ),
                CircleAvatar(radius: 15,
                  backgroundImage: AssetImage("images/android.png"),
                  backgroundColor: Colors.white,
                ),
                SizedBox(
                  width: 20,
                ),
                CircleAvatar(radius: 15,
                  backgroundImage: AssetImage("images/google-play.png"),
                  backgroundColor: Colors.white,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class MyFonts {
  static roboto(
      {required int fontSize,
      required FontWeight fontWeight,
      required Color color}) {}
}
