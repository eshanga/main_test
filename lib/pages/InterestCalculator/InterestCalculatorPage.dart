import 'package:flutter/material.dart';

import '../app_drawer.dart';

class InterestCalPage extends StatefulWidget {
  @override
  _InterestCalPageState createState() => _InterestCalPageState();
}

class _InterestCalPageState extends State<InterestCalPage> {
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
        title: Text('Screen 6'),
        backgroundColor: Color.fromRGBO(240, 185, 11, 1),
      ),
      drawer: AppDrawer(
        email: '',
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 200.0, // Adjust the size of the square box
              height: 200.0, // Adjust the size of the square box
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.scaleDown,
                  image: AssetImage('assets/interest.png'),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: principalController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Principal',
                hintText: 'Enter Principal Amount',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: rateController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Rate of Interest',
                hintText: 'Enter Rate of Interest',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: periodController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Period in Months',
                hintText: 'Enter Period in Months',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              child: Text('Calculate Interest'),
              onPressed: calculateInterest,
            ),
            SizedBox(height: 16.0),
            Text(
              'Total Interest (before tax) = $result',
              style: TextStyle(fontSize: 24.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Total Interest (after tax) = $afterTaxResult',
              style: TextStyle(fontSize: 24.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Monthly Interest (after tax) = $monthlyInterest',
              style: TextStyle(fontSize: 24.0),
            ),
          ],
        ),
      ),
    );
  }
}
