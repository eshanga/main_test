// TODO Implement this library.
import 'package:flutter/material.dart';

import '../app_drawer.dart';

class Screen5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen 5'),
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
