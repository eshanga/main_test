// TODO Implement this library.
import 'package:flutter/material.dart';

import '../app_drawer.dart';

class Screen5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(30, 35, 41, 1),
      appBar: AppBar(
        title: Text('Screen 5'),
        backgroundColor: Color.fromRGBO(240, 185, 11, 1),
      ),
      drawer: AppDrawer(
        email: '',
      ),
      body: Center(
        child: Text(
          'This page will available soon!',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
