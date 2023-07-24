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
  bool isLoading = true;
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

  String highestPercentageValue = '';
  double highestPercentage = 0.0;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final symbols = ['RIVN', 'TSLA', 'AAPL', 'AMD', 'BABA'];
      final apiKey = '10b48b466ea94b08a2c316bb127a1c75';

      for (var symbol in symbols) {
        final apiUrl =
            'https://api.twelvedata.com/time_series?symbol=$symbol&interval=1day&apikey=$apiKey';

        final response = await http.get(Uri.parse(apiUrl));

        if (response.statusCode == 200) {
          final jsonData = json.decode(response.body);

          if (jsonData.containsKey('values')) {
            final List<dynamic> values = jsonData['values'];

            if (values.isNotEmpty) {
              final dynamic lastData = values.last;

              switch (symbol) {
                case 'RIVN':
                  rivnRealtimeValue = double.parse(lastData['close']);
                  break;
                case 'TSLA':
                  tslaRealtimeValue = double.parse(lastData['close']);
                  break;
                case 'AAPL':
                  aaplRealtimeValue = double.parse(lastData['close']);
                  break;
                case 'AMD':
                  amdRealtimeValue = double.parse(lastData['close']);
                  break;
                case 'BABA':
                  babaRealtimeValue = double.parse(lastData['close']);
                  break;
              }
            }
          }
        }
      }

      fetchFirestoreData();
    } catch (e) {
      print('Error retrieving data: $e');
      setState(() {
        isLoading = false;
        isError = true;
      });
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

      findHighestPercentage();
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print('Error retrieving Firestore data: $e');
      setState(() {
        isLoading = false;
        isError = true;
      });
    }
  }

  void findHighestPercentage() {
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
            ? CircularProgressIndicator()
            : isError
                ? Text(
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
      color: highestPercentageValue == valueName
          ? Colors.green
          : Color.fromRGBO(240, 185, 11, 1),
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
    return Card(
      color: highestPercentageValue.isNotEmpty ? Colors.green : Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          highestPercentageValue.isNotEmpty
              ? 'It is recommended to buy ${highestPercentageValue.toUpperCase()} with the received data.'
              : 'No recommended buy at the moment.',
          style: TextStyle(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
