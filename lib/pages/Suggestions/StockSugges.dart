import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:html/parser.dart' as parser;
import 'package:cloud_firestore/cloud_firestore.dart';

class StockSugges extends StatefulWidget {
  const StockSugges({Key? key}) : super(key: key);

  @override
  _StockSuggesState createState() => _StockSuggesState();
}

class _StockSuggesState extends State<StockSugges> {
  String fetchedData = '';
  bool isLoading = false;
  bool isError = false;

  double rivnValue = 0.0;
  double tslaValue = 0.0;
  double aaplValue = 0.0;
  double amdValue = 0.0;
  double babaValue = 0.0;

  double rivnRealtimeValue = 0.0;
  double tslaRealtimeValue = 0.0;
  double aaplRealtimeValue = 0.0;
  double amdRealtimeValue = 0.0;
  double babaRealtimeValue = 0.0;

  @override
  void initState() {
    super.initState();
    //fetchData();
    fetchRealtimeData();
    fetchFirestoreData();
  }

  Future<void> fetchRealtimeData() async {
    try {
      final symbols = ['RIVN', 'TSLA', 'AAPL', 'AMD', 'BABA'];

      for (var symbol in symbols) {
        final response = await http.get(Uri.parse(
            'https://query1.finance.yahoo.com/v10/finance/quoteSummary/$symbol?modules=price'));

        if (response.statusCode == 200) {
          final jsonData = json.decode(response.body);

          final dynamic result = jsonData['quoteSummary']['result'];

          if (result != null && result.isNotEmpty) {
            final dynamic quote = result[0]['price'];

            switch (symbol) {
              case 'RIVN':
                rivnRealtimeValue = quote['regularMarketPrice']['raw'];
                break;
              case 'TSLA':
                tslaRealtimeValue = quote['regularMarketPrice']['raw'];
                break;
              case 'AAPL':
                aaplRealtimeValue = quote['regularMarketPrice']['raw'];
                break;
              case 'AMD':
                amdRealtimeValue = quote['regularMarketPrice']['raw'];
                break;
              case 'BABA':
                babaRealtimeValue = quote['regularMarketPrice']['raw'];
                break;
            }
          }
        }
      }

      setState(() {});
    } catch (e) {
      print('Error retrieving realtime data: $e');
    }
  }

  Future<void> fetchFirestoreData() async {
    try {
      final collection =
          FirebaseFirestore.instance.collection('predictionstock');
      final documents = await collection.get();

      for (var doc in documents.docs) {
        final name = doc.id;
        final data = doc.data();

        switch (name) {
          case 'RIVN':
            rivnValue = (data['prediction']?.toDouble() ?? 0.0);
            break;
          case 'TSLA':
            tslaValue = (data['prediction']?.toDouble() ?? 0.0);
            break;
          case 'AAPL':
            aaplValue = (data['prediction']?.toDouble() ?? 0.0);
            break;
          case 'AMD':
            amdValue = (data['prediction']?.toDouble() ?? 0.0);
            break;
          case 'BABA':
            babaValue = (data['prediction']?.toDouble() ?? 0.0);
            break;
        }
      }

      setState(() {});
    } catch (e) {
      print('Error retrieving Firestore data: $e');
    }
  }

  void parseFetchedData() {
    final values = fetchedData.split(',');

    if (values.length == 5) {
      rivnValue = double.tryParse(values[0].trim()) ?? 0.0;
      tslaValue = double.tryParse(values[1].trim()) ?? 0.0;
      aaplValue = double.tryParse(values[2].trim()) ?? 0.0;
      amdValue = double.tryParse(values[3].trim()) ?? 0.0;
      babaValue = double.tryParse(values[4].trim()) ?? 0.0;
    }
  }

  double calculatePercentageDifference(
      double obtainedValue, double realtimeValue) {
    if (realtimeValue != 0.0) {
      return ((obtainedValue - realtimeValue) / realtimeValue) * 100.0;
    } else {
      return double.infinity;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Stock Suggestions Page',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color.fromRGBO(240, 185, 11, 1),
      ),
      backgroundColor: Color.fromRGBO(30, 35, 41, 1),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : isError
                ? const Text(
                    'Error retrieving data',
                    style: TextStyle(color: Colors.white),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Data retrieved from server:',
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 10),
                      buildValueCard('RIVN', rivnRealtimeValue, rivnValue),
                      buildValueCard('TSLA', tslaRealtimeValue, tslaValue),
                      buildValueCard('AAPL', aaplRealtimeValue, aaplValue),
                      buildValueCard('AMD', amdRealtimeValue, amdValue),
                      buildValueCard('BABA', babaRealtimeValue, babaValue),
                      const SizedBox(height: 10),
                      buildRecommendedBuyCard(),
                    ],
                  ),
      ),
    );
  }

  Widget buildValueCard(
      String valueName, double realtimeValue, double obtainedValue) {
    final percentageDifference =
        calculatePercentageDifference(obtainedValue, realtimeValue)
            .toStringAsFixed(2);

    return Card(
      color: Color.fromRGBO(240, 185, 11, 1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            RichText(
              text: TextSpan(
                text: 'The real-time value of ',
                style: TextStyle(fontSize: 16, color: Colors.black),
                children: [
                  TextSpan(
                    text: valueName,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: ' is ',
                  ),
                  TextSpan(
                    text: realtimeValue.toString(),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                text: 'The predicted value after 10 days is ',
                style: TextStyle(fontSize: 16, color: Colors.black),
                children: [
                  TextSpan(
                    text: obtainedValue.toStringAsFixed(4),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                text: 'The changed percentage is ',
                style: TextStyle(fontSize: 16, color: Colors.black),
                children: [
                  TextSpan(
                    text: '$percentageDifference%',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRecommendedBuyCard() {
    String highestPercentageValue = '';
    double highestPercentage = 0.0;

    // Find the highest percentage value
    if (calculatePercentageDifference(rivnValue, rivnRealtimeValue) >
        highestPercentage) {
      highestPercentage =
          calculatePercentageDifference(rivnValue, rivnRealtimeValue);
      highestPercentageValue = 'RIVN';
    }
    if (calculatePercentageDifference(tslaValue, tslaRealtimeValue) >
        highestPercentage) {
      highestPercentage =
          calculatePercentageDifference(tslaValue, tslaRealtimeValue);
      highestPercentageValue = 'TSLA';
    }
    if (calculatePercentageDifference(aaplValue, aaplRealtimeValue) >
        highestPercentage) {
      highestPercentage =
          calculatePercentageDifference(aaplValue, aaplRealtimeValue);
      highestPercentageValue = 'AAPL';
    }
    if (calculatePercentageDifference(amdValue, amdRealtimeValue) >
        highestPercentage) {
      highestPercentage =
          calculatePercentageDifference(amdValue, amdRealtimeValue);
      highestPercentageValue = 'AMD';
    }
    if (calculatePercentageDifference(babaValue, babaRealtimeValue) >
        highestPercentage) {
      highestPercentage =
          calculatePercentageDifference(babaValue, babaRealtimeValue);
      highestPercentageValue = 'BABA';
    }

    return Card(
      color: Colors.green,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          'It is recommended to buy ${highestPercentageValue.toUpperCase()} with the received data.',
          style: TextStyle(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
