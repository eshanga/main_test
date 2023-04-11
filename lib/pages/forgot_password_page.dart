// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:financia_mobile_app/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    super.dispose();
  }

  Future<void> passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text("Succes!",
                  style: TextStyle(color: Color.fromRGBO(1, 134, 12, 1))),
              content: Text('Password Reset link sent. Check your email!'),
              actions: [
                TextButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginPage(
                                  showRegisterPage: () {},
                                )));
                  },
                )
              ]);
        },
      );
    } on FirebaseAuthException catch (e) {
      //print(e);
      if (e.code == 'invalid-email') {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
                title: Text("Error!",
                    style: TextStyle(color: Color.fromARGB(255, 134, 13, 4))),
                content: Text('Provided Email is Incorrect! Please try again'),
                actions: [
                  TextButton(
                    child: Text("OK"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ]);
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
                title: Text("Error!",
                    style: TextStyle(color: Color.fromARGB(255, 134, 13, 4))),
                content:
                    Text('Provided Email does not have a user! Please Singup'),
                actions: [
                  TextButton(
                    child: Text("OK"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ]);
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(30, 35, 41, 1),
        appBar: AppBar(
          title: Text('Forgotten password',
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 15,
                fontWeight: FontWeight.bold,
              )),
          backgroundColor: Color.fromRGBO(250, 211, 56, 1),
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black, // set the arrow color to black
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.asset(
                'assets/lock.png',
                height: 150,
                width: 150,
              ),
            ),
            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                'Forgot Password ?  ',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Color.fromRGBO(240, 185, 11, 1), fontSize: 35),
              ),
            ),
            const SizedBox(height: 25),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                'Enter Your Email address, we will send you a password reset link',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color.fromRGBO(250, 250, 250, 1), fontSize: 15),
              ),
            ),

            SizedBox(height: 10),

            //email textfield
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: TextField(
                controller: _emailController,
                style: TextStyle(color: Color.fromRGBO(240, 185, 11, 1)),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromRGBO(48, 52, 56, 1)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromRGBO(240, 185, 11, 1)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: 'Enter your Email',
                  hintStyle: TextStyle(color: Colors.grey[700]),
                  fillColor: Color.fromRGBO(48, 52, 56, 1),
                  filled: true,
                ),
              ),
            ),
            SizedBox(height: 10),

            SizedBox(
              height: 50,
              width: 200,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: MaterialButton(
                  onPressed: () {
                    passwordReset();
                  },
                  child: Text(
                    'Reset Password',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  color: Color.fromRGBO(240, 185, 11, 1),
                ),
              ),
            )
          ],
        ));
  }
}
