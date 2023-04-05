import 'package:financia_mobile_app/pages/home_page.dart';
import 'package:financia_mobile_app/pages/main_home_page.dart';
import 'package:financia_mobile_app/services/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'forgot_password_page.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const LoginPage({Key? key, required this.showRegisterPage}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
//text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future signIn() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'auth/user-not-found') {
        wrongEmailMessage();
      } else if (e.code == 'auth/invalid-password') {
        wrongPasswordMessage();
      }
    }

    Navigator.pop(context);
  }

  //wrong emailmessage popup
  void wrongEmailMessage() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text('Incorrect Email. Please Enter your Email correctly!'),
          );
        });
  }

  void wrongPasswordMessage() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text('Invalid Credentials. Please Check your Password!'),
          );
        });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: Container(
          child: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //financia Mobile app

                    Container(
                      width: 200.0,
                      height: 200.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage('assets/1.png'),
                        ),
                      ),
                    ),
                    Text(
                      'FINANCIA',
                      style: GoogleFonts.openSans(
                        fontSize: 36,
                        letterSpacing: 4,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Financial Management Mobile app',
                      style: TextStyle(fontSize: 16),
                    ),

                    SizedBox(height: 50),
                    //email textfield
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          hintText: 'Enter your Email',
                          fillColor: Colors.purple[100],
                          filled: true,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    //password textfield
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: TextField(
                        obscureText: true,
                        controller: _passwordController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          hintText: 'Enter your Password',
                          fillColor: Colors.purple[100],
                          filled: true,
                        ),
                      ),
                    ),

                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return ForgotPasswordPage();
                                  },
                                ),
                              );
                            },
                            child: Text(
                              'Forgot Password? ',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    //sign in button
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: GestureDetector(
                        onTap: signIn,
                        child: Container(
                          padding: EdgeInsets.all(25),
                          decoration: BoxDecoration(
                              color: Colors.deepPurple,
                              borderRadius: BorderRadius.circular(12)),
                          child: Center(
                            child: Text(
                              'Sign In',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 0.5,
                              color: Colors.grey[400],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              'Or continue with',
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 0.5,
                              color: Colors.grey[400],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 50),

                    // google + apple sign in buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // google button
                        GestureDetector(
                          onTap: () => AuthService().signInWithGoogle(),
                          child: Container(
                            width: 75.0,
                            height: 75.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage('assets/google.png'),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(width: 25),

                        // apple button
                        Container(
                          width: 75.0,
                          height: 75.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage('assets/apple.png'),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 50),

                    // not a member? register now
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Not a member?',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: widget.showRegisterPage,
                          child: const Text(
                            'Register now',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Powered By,',
                      style: TextStyle(fontSize: 12),
                    ),

                    Container(
                      width: 100.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage('assets/company.png'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
