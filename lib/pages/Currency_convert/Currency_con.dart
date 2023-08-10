import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../app_drawer.dart';

class CurrencyConverter extends StatefulWidget {
  @override
  _CurrencyConverterState createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<CurrencyConverter> {
  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _toController = TextEditingController();

  double _result = 0.0;
  String _fromCurrency = 'USD';
  String _toCurrency = 'LKR';

  Future<Map<String, dynamic>> _getExchangeRate() async {
    String url = 'https://api.exchangerate-api.com/v4/latest/$_fromCurrency';

    Uri uri = Uri.parse(url);
    var response = await http.get(uri);
    return json.decode(response.body);
  }

  void _convertCurrency() async {
    double amount = double.parse(_fromController.text);
    Map<String, dynamic> data = await _getExchangeRate();
    double exchangeRate = data['rates'][_toCurrency];
    double result = amount * exchangeRate;
    setState(() {
      _result = result;
    });
    _toController.text = _result.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(30, 35, 41, 1),
      appBar: AppBar(
        title: Text('Currency Converter'),
        backgroundColor: Color.fromRGBO(30, 35, 41, 1),
      ),
      drawer: AppDrawer(
        email: '',
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 200.0,
                  height: 200.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.scaleDown,
                      image: AssetImage('assets/currency.png'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: _fromController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Amount',
                    hintText: 'Enter amount to convert',
                    labelStyle: TextStyle(color: Colors.white),
                    hintStyle: TextStyle(color: Colors.white70),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromRGBO(240, 185, 11, 1)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromRGBO(240, 185, 11, 1)),
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    DropdownButton<String>(
                      value: _fromCurrency,
                      onChanged: (String? newValue) {
                        setState(() {
                          _fromCurrency = newValue!;
                        });
                      },
                      items: <String>[
                        'USD',
                        'EUR',
                        'GBP',
                        'INR',
                        'JPY',
                        'CHF',
                        'CAD',
                        'AUD',
                        'LKR'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,
                              style: TextStyle(color: Colors.white)),
                        );
                      }).toList(),
                      dropdownColor: Color.fromRGBO(30, 35, 41, 1),
                    ),
                    Icon(Icons.arrow_forward,
                        color: Color.fromRGBO(240, 185, 11, 1)),
                    DropdownButton<String>(
                      value: _toCurrency,
                      onChanged: (String? newValue) {
                        setState(() {
                          _toCurrency = newValue!;
                        });
                      },
                      items: <String>[
                        'USD',
                        'EUR',
                        'GBP',
                        'INR',
                        'JPY',
                        'CHF',
                        'CAD',
                        'AUD',
                        'LKR'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,
                              style: TextStyle(color: Colors.white)),
                        );
                      }).toList(),
                      dropdownColor: Color.fromRGBO(30, 35, 41, 1),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                ElevatedButton(
                  onPressed: _convertCurrency,
                  child: Text('Convert'),
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(240, 185, 11, 1),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextField(
                  controller: _toController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Result',
                    hintText: 'Converted amount will appear here',
                    labelStyle: TextStyle(color: Colors.white),
                    hintStyle: TextStyle(color: Colors.white70),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromRGBO(240, 185, 11, 1)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromRGBO(240, 185, 11, 1)),
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
