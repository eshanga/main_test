import 'package:financia_mobile_app/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../widgets/button_widget.dart';
import '../app_drawer.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final limitFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    TextEditingController limitdata = new TextEditingController();

    return Scaffold(
      backgroundColor: Color.fromRGBO(30, 35, 41, 1),
      appBar: AppBar(
        title: Text(
          "User Profile",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0.0,
        backgroundColor: Color.fromRGBO(240, 185, 11, 1),
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => LoginPage(
                          showRegisterPage: () {},
                        )),
              );
              FirebaseAuth.instance.signOut();
            },
          )
        ],
        iconTheme: IconThemeData(color: Colors.black54),
      ),
      drawer: AppDrawer(
        email: '',
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          SizedBox(
            height: 25,
          ),
          // ProfileWidget(
          // imagePath: user!.photoURL!,
          // onClicked: () async {},
          //),
          const SizedBox(
            height: 24,
          ),
          buildName(),
          const SizedBox(
            height: 30,
          ),
          Center(child: buildLogout()),
          SizedBox(
            height: 40,
          ),
          Divider(
            color: Colors.grey,
            indent: 0,
          ),
          const SizedBox(
            height: 40,
          ),
          Form(
            key: limitFormKey,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  TextFormField(
                    controller: limitdata,
                    decoration: InputDecoration(
                      labelText: 'Monthly Limit',
                      labelStyle: TextStyle(color: Colors.grey[700]),
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromRGBO(240, 185, 11, 1)),
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      ),
                      prefixIcon: Icon(Icons.query_stats),
                      hintText: "Enter Monthly Limit",
                      hintStyle: TextStyle(color: Colors.grey[700]),
                      fillColor: Color.fromRGBO(48, 52, 56, 1),
                      filled: true,
                    ),
                    validator: (value) {
                      if (value == null) {
                        return "Please fill this field";
                      } else if (int.parse(value) <= 0 ||
                          int.parse(value) > 1000000) {
                        return "Enter Valid Amount";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 55.0,
                    child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              width: 1,
                              color: Colors.black26,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            textStyle: TextStyle(
                              fontSize: 21.0,
                            ),
                            backgroundColor: Color.fromRGBO(240, 185, 11, 1)),
                        child: Text(
                          'Set Monthly Limit',
                          style: TextStyle(
                            fontFamily: 'Helvetica',
                            color: Colors.black,
                          ),
                        ),
                        onPressed: () {
                          final isLimitValid =
                              limitFormKey.currentState!.validate();
                          if (isLimitValid) {
                            FirebaseFirestore.instance
                                .collection(user!.email!)
                                .doc('limit') // <-- Document ID
                                .set({
                              'limit': int.parse(limitdata.text)
                            }); // <-- Your data
                            limitdata.clear();
                          }
                        }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildName() {
    final user = FirebaseAuth.instance.currentUser;
    return Column(
      children: [
        Text(
          user?.displayName ?? '',
          style: TextStyle(
            // fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          user?.email ?? '',
          style: TextStyle(
            fontSize: 17,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget buildLogout() => ButtonWidget(
        text: 'Logout',
        onClicked: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => LoginPage(
                      showRegisterPage: () {},
                    )),
          );
          FirebaseAuth.instance.signOut();
          // In the logout function, navigate to the login screen
        },
      );
}
