// TODO Implement this library.
import 'package:flutter/material.dart';

import '../app_drawer.dart';

class Screen3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen 3'),
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
