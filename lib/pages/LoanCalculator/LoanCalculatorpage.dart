import 'package:flutter/material.dart';
import 'dart:math';

class LoanCalPage extends StatefulWidget {
  @override
  _LoanCalPageState createState() => _LoanCalPageState();
}

class _LoanCalPageState extends State<LoanCalPage> {
  final loanAmountController = TextEditingController();
  final interestRateController = TextEditingController();
  final loanTermController = TextEditingController();
  double monthlyPayment = 0.0;

  @override
  void dispose() {
    loanAmountController.dispose();
    interestRateController.dispose();
    loanTermController.dispose();
    super.dispose();
  }

  void calculateMonthlyPayment() {
    double loanAmount = double.tryParse(loanAmountController.text) ?? 0.0;
    double interestRate = double.tryParse(interestRateController.text) ?? 0.0;
    int loanTerm = int.tryParse(loanTermController.text) ?? 1;

    double monthlyInterestRate = interestRate / 12 / 100;
    int totalMonths = loanTerm * 12;

    if (monthlyInterestRate > 0) {
      double monthlyPayment = (loanAmount * monthlyInterestRate) /
          (1 - pow(1 + monthlyInterestRate, -totalMonths));
      setState(() {
        this.monthlyPayment = monthlyPayment;
      });
    } else {
      setState(() {
        this.monthlyPayment = loanAmount / totalMonths;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(30, 35, 41, 1),
      appBar: AppBar(
        title: Text('Loan Calculator'),
        backgroundColor: Color.fromRGBO(240, 185, 11, 1),
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
              SizedBox(height: 16.0),
              TextField(
                controller: loanAmountController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Loan Amount',
                  hintText: 'Enter Loan Amount',
                  labelStyle: TextStyle(color: Colors.white),
                  hintStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: interestRateController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Interest Rate (%)',
                  hintText: 'Enter Interest Rate',
                  labelStyle: TextStyle(color: Colors.white),
                  hintStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: loanTermController,
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Loan Term (Years)',
                  hintText: 'Enter Loan Term',
                  labelStyle: TextStyle(color: Colors.white),
                  hintStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                child: Text('Calculate Monthly Payment'),
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(240, 185, 11, 1),
                ),
                onPressed: calculateMonthlyPayment,
              ),
              SizedBox(height: 16.0),
              Text(
                'Monthly Payment',
                style: TextStyle(fontSize: 16.0, color: Colors.white),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: EdgeInsets.all(8.0),
                child: Text(
                  '\ ${monthlyPayment.toStringAsFixed(2)}',
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
