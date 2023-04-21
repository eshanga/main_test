// TODO Implement this library.
import 'package:flutter/material.dart';

import '../app_drawer.dart';

class Screen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(30, 35, 41, 1),
      appBar: AppBar(
        title: Text('Screen 2'),
        backgroundColor: Color.fromARGB(255, 193, 175, 14),
      ),
      drawer: AppDrawer(
        email: '',
      ),
      body: Center(
        child: Text('This page will available soon!',
            selectionColor: Colors.white),
      ),
    );
  }
}
