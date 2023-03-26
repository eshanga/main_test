// TODO Implement this library.
import 'package:flutter/material.dart';

import '../app_drawer.dart';

class Screen4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen 4'),
        backgroundColor: Colors.indigo,
      ),
      drawer: AppDrawer(
        email: '',
      ),
      body: Center(
        child: Text('This page will available soon!'),
      ),
    );
  }
}
