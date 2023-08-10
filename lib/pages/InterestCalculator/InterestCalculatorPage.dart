import 'package:flutter/material.dart';

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
      backgroundColor: Color.fromRGBO(30, 35, 41, 1),
      appBar: AppBar(
        title: Text('Interest Calculator'),
        backgroundColor: Color.fromRGBO(30, 35, 41, 1),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          color: Color.fromRGBO(30, 35, 41, 1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 300.0,
                height: 300.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.scaleDown,
                    image: AssetImage('assets/interest.png'),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              TextField(
                controller: principalController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Principal',
                  hintText: 'Enter Principal Amount',
                  labelStyle: TextStyle(color: Colors.white),
                  hintStyle: TextStyle(color: Colors.white),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: rateController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Rate of Interest',
                  hintText: 'Enter Rate of Interest',
                  labelStyle: TextStyle(color: Colors.white),
                  hintStyle: TextStyle(color: Colors.white),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: periodController,
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Period in Months',
                  hintText: 'Enter Period in Months',
                  labelStyle: TextStyle(color: Colors.white),
                  hintStyle: TextStyle(color: Colors.white),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                child: Text('Calculate Interest'),
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(240, 185, 11, 1),
                ),
                onPressed: calculateInterest,
              ),
              SizedBox(height: 16.0),
              Text(
                'Total Interest (before tax)',
                style: TextStyle(fontSize: 16.0, color: Colors.white),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: EdgeInsets.all(8.0),
                child: Text(
                  '$result',
                  style: TextStyle(fontSize: 24.0, color: Colors.white),
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Total Interest (after tax)',
                style: TextStyle(fontSize: 16.0, color: Colors.white),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: EdgeInsets.all(8.0),
                child: Text(
                  '$afterTaxResult',
                  style: TextStyle(fontSize: 24.0, color: Colors.white),
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Monthly Interest (after tax)',
                style: TextStyle(fontSize: 16.0, color: Colors.white),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: EdgeInsets.all(8.0),
                child: Text(
                  '$monthlyInterest',
                  style: TextStyle(fontSize: 24.0, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
