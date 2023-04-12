import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services/auth_services.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({
    Key? key,
    required this.showLoginPage,
  }) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpasswordcontroller = TextEditingController();
  double _ratingValue = 0.0;
  final List<Color> _colors = [
    Colors.green,
    Colors.lightGreen,
    Colors.yellow,
    Colors.orangeAccent,
    Colors.redAccent,
  ];

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  Future signUp() async {
    if (passwordConfirmed()) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    }
  }

  bool passwordConfirmed() {
    if (_passwordController.text.trim() ==
        _confirmpasswordcontroller.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(30, 35, 41, 1),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //financia Mobile app

                  Container(
                    width: 150.0,
                    height: 150.0,
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
                      color: Color.fromRGBO(240, 185, 11, 1),
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 4,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Register with your details! ',
                    style: TextStyle(
                        color: Color.fromRGBO(234, 236, 239, 1), fontSize: 16),
                  ),

                  SizedBox(height: 50),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextField(
                      controller: _nameController,
                      style: const TextStyle(
                        color: Color.fromRGBO(240, 185, 11, 1),
                      ),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color.fromRGBO(48, 52, 56, 1)),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(240, 185, 11, 1)),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: 'Enter your Name',
                        hintStyle: TextStyle(color: Colors.grey[700]),
                        fillColor: Color.fromRGBO(48, 52, 56, 1),
                        filled: true,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  //email textfield
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextField(
                      controller: _emailController,
                      style: const TextStyle(
                        color: Color.fromRGBO(240, 185, 11, 1),
                      ),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color.fromRGBO(48, 52, 56, 1)),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(240, 185, 11, 1)),
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
                  //password textfield
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextField(
                      obscureText: true,
                      controller: _passwordController,
                      style: const TextStyle(
                        color: Color.fromRGBO(240, 185, 11, 1),
                      ),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color.fromRGBO(48, 52, 56, 1)),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(240, 185, 11, 1)),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: 'Enter your Password',
                        hintStyle: TextStyle(color: Colors.grey[700]),
                        fillColor: Color.fromRGBO(48, 52, 56, 1),
                        filled: true,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),

                  //confirm password textfield
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextField(
                      obscureText: true,
                      style: const TextStyle(
                        color: Color.fromRGBO(240, 185, 11, 1),
                      ),
                      controller: _confirmpasswordcontroller,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color.fromRGBO(48, 52, 56, 1)),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(240, 185, 11, 1)),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: 'Confirm your Password',
                        hintStyle: TextStyle(color: Colors.grey[700]),
                        fillColor: Color.fromRGBO(48, 52, 56, 1),
                        filled: true,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Text(
                      'Please rate your risk rate that you are wiiling to take while using this App.',
                      style: TextStyle(
                          fontSize: 14.0,
                          color: Color.fromRGBO(240, 185, 11, 1)),
                    ),
                  ),

                  RatingBar.builder(
                    initialRating: _ratingValue,
                    minRating: 0,
                    maxRating: 10,
                    itemSize: 50.0,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    unratedColor: Colors.grey[300],
                    itemBuilder: (context, index) {
                      return Icon(
                        Icons.circle,
                        color: _getColor(index),
                      );
                    },
                    onRatingUpdate: (rating) {
                      setState(() {
                        _ratingValue = rating;
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  //sign in button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: GestureDetector(
                      onTap: signUp,
                      child: Container(
                        padding: EdgeInsets.all(25),
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(240, 185, 11, 1),
                            borderRadius: BorderRadius.circular(12)),
                        child: Center(
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),

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
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
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

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // google button
                      GestureDetector(
                        onTap: () => AuthService().signInWithGoogle(),
                        child: Container(
                          width: 90.0,
                          height: 90.0,
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
                  // not a member? register now
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already Signed In?',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: widget.showLoginPage,
                        child: const Text(
                          'LogIn',
                          style: TextStyle(
                            color: Color.fromRGBO(240, 185, 11, 1),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Color? _getColor(int index) {
    if (index < 1.0) {
      return _colors[0];
    } else if ((index) < 2) {
      return _colors[1];
    } else if (index < 3) {
      return _colors[2];
    } else if (index < 4) {
      return _colors[3];
    } else if (index < 5) {
      return _colors[4];
    }
    return Colors.grey[300];
  }
}
