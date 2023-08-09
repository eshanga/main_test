import 'package:flutter/material.dart';

import '../app_drawer.dart';

<<<<<<< Updated upstream:lib/pages/screen5/screen5.dart
class Screen5 extends StatefulWidget {
=======
class InterestCalPage extends StatefulWidget {
  const InterestCalPage({super.key});

>>>>>>> Stashed changes:lib/pages/InterestCalculator/InterestCalculatorPage.dart
  @override
  _Screen5State createState() => _Screen5State();
}

class _Screen5State extends State<Screen5> {
  final principalController = TextEditingController();
  final rateController = TextEditingController();
  final periodController = TextEditingController();
  double result = 0.0;
  double afterTaxResult = 0.0;
  double monthlyInterest = 0.0;

  @override
  void dispose() {
    principalController.dispose();
    rateController.dispose();
    periodController.dispose();
    super.dispose();
  }

  void calculateInterest() {
    double principal = double.tryParse(principalController.text) ?? 0.0;
    double rate = double.tryParse(rateController.text) ?? 0.0;
    int period = int.tryParse(periodController.text) ?? 1;
    double time = period / 12;
    double interest = (principal * rate * time) / 100;
    double tax = interest * 0.05;
    setState(() {
      result = interest;
      afterTaxResult = interest - tax;
      monthlyInterest = afterTaxResult / period;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Screen 6'),
        backgroundColor: const Color.fromRGBO(240, 185, 11, 1),
      ),
      drawer: const AppDrawer(
        email: '',
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 200.0, // Adjust the size of the square box
              height: 200.0, // Adjust the size of the square box
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.scaleDown,
                  image: AssetImage('assets/interest.png'),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: principalController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Principal',
                hintText: 'Enter Principal Amount',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: rateController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Rate of Interest',
                hintText: 'Enter Rate of Interest',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: periodController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Period in Months',
                hintText: 'Enter Period in Months',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: calculateInterest,
              child: const Text('Calculate Interest'),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Total Interest (before tax) = $result',
              style: const TextStyle(fontSize: 24.0),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Total Interest (after tax) = $afterTaxResult',
              style: const TextStyle(fontSize: 24.0),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Monthly Interest (after tax) = $monthlyInterest',
              style: const TextStyle(fontSize: 24.0),
            ),
          ],
        ),
      ),
    );
  }
}
