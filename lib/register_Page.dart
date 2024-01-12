import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:simple_loginpage/Login_page.dart';

class Register_page extends StatefulWidget {
  const Register_page({Key? key}) : super(key: key);

  @override
  State<Register_page> createState() => _Register_pageState();
}

class _Register_pageState extends State<Register_page> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final formkey = GlobalKey<FormState>();
  bool showpassword = false;

  Future<void> register() async {
    if (formkey.currentState!.validate()) {
      try {
        final existinguser = await FirebaseFirestore.instance
            .collection('registers')
            .where('email', isEqualTo: _emailController.text)
            .get();
        if (existinguser.docs.isNotEmpty) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Email id already exists")));
        }
        final existingusername = await FirebaseFirestore.instance
            .collection('registers')
            .where('uname', isEqualTo: _usernameController.text)
            .get();
        if (existingusername.docs.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("user name already exists")));
        }

        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: _emailController.text,
                password: _passwordController.text);

        await FirebaseFirestore.instance
            .collection('registers')
            .doc(userCredential.user!.uid)
            .set({
          'uname': _usernameController.text,
          'password': _passwordController.text,
          'email': _emailController.text,
        });

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Register succsfully")));
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Login_page()));
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("error${e}")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Register Page",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        backgroundColor: Colors.cyan,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(14),
        child: Form(
          key: formkey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 100,
                ),
                TextFormField(
                  controller:
                      _usernameController, // A controller to control the text field's content.
                  decoration: const InputDecoration(
                    labelText:
                        "User name", // The label text for the text field.
                    prefixIcon: Icon(
                        Icons.person), // An icon displayed before the input.
                    labelStyle: TextStyle(
                        color: Colors.black), // Style for the label text.
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors
                            .black, // Border color when the text field is enabled.
                        width: 1, // Border width.
                      ),
                      borderRadius:
                          BorderRadius.all(Radius.zero), // Border radius.
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a value'; // Validation message for empty input.
                    }
                    if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                      return "Please enter a valid username"; // Validation message for non-alphabetic characters.
                    }
                    return null; // Return null if the input is valid.
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _emailController,
                  style: MyFonts.roboto(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  decoration: const InputDecoration(
                      hintText: "Enter your email",
                      labelText: "email",
                      prefixIcon: Icon(Icons.email_outlined),
                      labelStyle: TextStyle(color: Colors.black),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.all(Radius.zero),
                      )),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a valid email address.';
                    }
                    if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
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
                  controller: _passwordController,
                  obscureText: showpassword,
                  onTap: () {
                    setState(() {
                      showpassword = !showpassword;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: "Password",
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: Icon(
                        showpassword ? Icons.visibility : Icons.visibility_off),
                    labelStyle: TextStyle(color: Colors.black),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.all(Radius.zero),
                    ),
                  ),
                  validator: (value) {
                    RegExp regex = RegExp(
                        r'^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#\$&*~]).{8,}$');
                    if (value!.isEmpty) {
                      return 'Please enter password';
                    } else {
                      if (!regex.hasMatch(value)) {
                        return 'Enter valid password';
                      } else {
                        return null;
                      }
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 200,
                  height: 40,
                  child: ElevatedButton(
                      onPressed: () {
                        register();
                      },
                      child: Text("Register")),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
