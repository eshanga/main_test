// TODO Implement this library.
import 'package:flutter/material.dart';

import '../app_drawer.dart';

<<<<<<< Updated upstream:lib/pages/screen3/screen3.dart
class Screen3 extends StatelessWidget {
=======
class BillPayPage extends StatelessWidget {
  const BillPayPage({super.key});

>>>>>>> Stashed changes:lib/pages/BillPayments/BillPaymentsPage.dart
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(30, 35, 41, 1),
      appBar: AppBar(
        title: const Text('Screen 3'),
        backgroundColor: const Color.fromRGBO(240, 185, 11, 1),
      ),
      drawer: const AppDrawer(
        email: '',
      ),
      body: const Center(
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
