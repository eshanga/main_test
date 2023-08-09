// TODO Implement this library.
import 'package:flutter/material.dart';

import '../app_drawer.dart';

<<<<<<< Updated upstream:lib/pages/screen2/screen2.dart
class Screen2 extends StatelessWidget {
=======
class LoanCalPage extends StatelessWidget {
  const LoanCalPage({super.key});

>>>>>>> Stashed changes:lib/pages/LoanCalculator/LoanCalculatorpage.dart
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(30, 35, 41, 1),
      appBar: AppBar(
        title: const Text('Screen 2'),
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
