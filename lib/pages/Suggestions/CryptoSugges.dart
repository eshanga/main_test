import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:html/parser.dart' as parser;

class CrptoSugges extends StatefulWidget {
  const CrptoSugges({Key? key}) : super(key: key);

  @override
  _CrptoSuggesState createState() => _CrptoSuggesState();
}

class _CrptoSuggesState extends State<CrptoSugges> {
  String fetchedData = '';
  bool isLoading = false;
  bool isError = false;

  double btcValue = 0.0;
  double rthValue = 0.0;
  double usdtValue = 0.0;
  double bnbValue = 0.0;
  double usdcValue = 0.0;

  double btcRealtimeValue = 0.0;
  double ethRealtimeValue = 0.0;
  double usdtRealtimeValue = 0.0;
  double bnbRealtimeValue = 0.0;
  double usdcRealtimeValue = 0.0;

  @override
  void initState() {
    super.initState();
    fetchData();
    fetchRealtimeData();
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
      isError = false;
    });

    try {
      final response =
          await http.get(Uri.parse('http://emmahash.pythonanywhere.com/'));
      if (response.statusCode == 200) {
        final document = parser.parse(response.body);
        final element = document.querySelector('body');
        if (element != null) {
          setState(() {
            fetchedData = element.text;
            parseFetchedData();
          });
        }
      } else {
        setState(() {
          isError = true;
        });
      }
    } catch (e) {
      setState(() {
        isError = true;
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> fetchRealtimeData() async {
    try {
      final symbols = ['BTCUSDT', 'ETHUSDT', 'USDTUSDC', 'BNBUSDT', 'USDCUSDT'];

      for (var symbol in symbols) {
        final response = await http.get(Uri.parse(
            'https://api.binance.com/api/v3/ticker/price?symbol=$symbol'));

        if (response.statusCode == 200) {
          final jsonData = json.decode(response.body);

          switch (symbol) {
            case 'BTCUSDT':
              btcRealtimeValue = double.parse(jsonData['price']);
              break;
            case 'ETHUSDT':
              ethRealtimeValue = double.parse(jsonData['price']);
              break;
            case 'USDTUSDC':
              usdtRealtimeValue = double.parse(jsonData['price']);
              break;
            case 'BNBUSDT':
              bnbRealtimeValue = double.parse(jsonData['price']);
              break;
            case 'USDCUSDT':
              usdcRealtimeValue = double.parse(jsonData['price']);
              break;
          }
        }
      }

      setState(() {});
    } catch (e) {
      print('Error retrieving realtime data: $e');
    }
  }

  void parseFetchedData() {
    final values = fetchedData.split(',');

    if (values.length == 5) {
      btcValue = double.tryParse(values[0].trim()) ?? 0.0;
      rthValue = double.tryParse(values[1].trim()) ?? 0.0;
      usdtValue = double.tryParse(values[2].trim()) ?? 0.0;
      bnbValue = double.tryParse(values[3].trim()) ?? 0.0;
      usdcValue = double.tryParse(values[4].trim()) ?? 0.0;
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
        title: const Text('Other Page'),
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
                      buildValueCard('BTC1', btcRealtimeValue, btcValue),
                      buildValueCard('RTH1', ethRealtimeValue, rthValue),
                      buildValueCard('USDT1', usdtRealtimeValue, usdtValue),
                      buildValueCard('BNB1', bnbRealtimeValue, bnbValue),
                      buildValueCard('USDC1', usdcRealtimeValue, usdcValue),
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
                    text: obtainedValue.toString(),
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
    if (calculatePercentageDifference(btcValue, btcRealtimeValue) >
        highestPercentage) {
      highestPercentage =
          calculatePercentageDifference(btcValue, btcRealtimeValue);
      highestPercentageValue = 'BTC1';
    }
    if (calculatePercentageDifference(rthValue, ethRealtimeValue) >
        highestPercentage) {
      highestPercentage =
          calculatePercentageDifference(rthValue, ethRealtimeValue);
      highestPercentageValue = 'RTH1';
    }
    if (calculatePercentageDifference(usdtValue, usdtRealtimeValue) >
        highestPercentage) {
      highestPercentage =
          calculatePercentageDifference(usdtValue, usdtRealtimeValue);
      highestPercentageValue = 'USDT1';
    }
    if (calculatePercentageDifference(bnbValue, bnbRealtimeValue) >
        highestPercentage) {
      highestPercentage =
          calculatePercentageDifference(bnbValue, bnbRealtimeValue);
      highestPercentageValue = 'BNB1';
    }
    if (calculatePercentageDifference(usdcValue, usdcRealtimeValue) >
        highestPercentage) {
      highestPercentage =
          calculatePercentageDifference(usdcValue, usdcRealtimeValue);
      highestPercentageValue = 'USDC1';
    }

    return Card(
      color: Color.fromRGBO(240, 185, 11, 1),
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
