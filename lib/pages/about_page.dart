import 'package:flutter/material.dart';

import 'app_drawer.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(30, 35, 41, 1),
      appBar: AppBar(
        title: Text(
          'About',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color.fromRGBO(240, 185, 11, 1),
      ),
      drawer: AppDrawer(
        email: '',
      ),
      body: Column(
        children: [
          Center(
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/company.png',
                    width: 300,
                    height: 300,
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'INNOVIA Solutions',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color.fromRGBO(250, 211, 56, 1),
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'We are a company that does amazing things.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    ' A startup company is a team of 4 individuals with a passion for innovations and a drive to make a difference. We specialize in developing software solutions according to the request of the client. Our team member has a knowledge about different programming languages, frameworks and platforms. All of our team members are responsible to deliver a high quality, scalable and maintainable software that meets the unique needs of our clients. Our company has a project manager, 2 Frontend/backend developers and a UI/UX designer.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16.0),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Copyright © 2023 INNOVIA Solutions',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromRGBO(250, 211, 56, 1),
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
