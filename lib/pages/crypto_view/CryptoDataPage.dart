import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_charts/charts.dart';

class CryptoDataPage extends StatefulWidget {
  @override
  _CryptoDataPageState createState() => _CryptoDataPageState();
}

class _CryptoDataPageState extends State<CryptoDataPage> {
  final TextEditingController _cryptoSymbolController = TextEditingController();
  List<dynamic> cryptoData = [];
  double currentPrice = 0;
  double highPrice = 0;
  double lowPrice = 0;
  double volume = 0;
  List<dynamic> trades = [];
  bool dataFound = true;

  @override
  void dispose() {
    _cryptoSymbolController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(30, 35, 41, 1),
      appBar: AppBar(
        title: Text(
          'Crypto Wise Data',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color.fromRGBO(240, 185, 11, 1),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          // Wrap the Column with SingleChildScrollView
          child: Column(
            children: [
              TextFormField(
                controller: _cryptoSymbolController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Enter Crypto Symbol (e.g., BTC)',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  String cryptoSymbol =
                      _cryptoSymbolController.text.toUpperCase();
                  if (!cryptoSymbol.endsWith('USDT')) {
                    cryptoSymbol += 'USDT';
                  }
                  fetchCryptoData(cryptoSymbol);
                },
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(240, 185, 11, 1),
                  onPrimary: Colors.white,
                ),
                child: Text('Fetch Data'),
              ),
              SizedBox(height: 16.0),
              if (!dataFound)
                Text(
                  'Data not found for the entered symbol.',
                  style: TextStyle(color: Colors.red),
                ),
              if (cryptoData.isNotEmpty)
                Container(
                  height: 300, // Fixed height for the chart container
                  child: _buildChart(),
                ),
              SizedBox(height: 50.0),
              Text(
                'Today\'s Price: ${currentPrice.toStringAsFixed(2)}',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'High Price: ${highPrice.toStringAsFixed(2)}',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Low Price: ${lowPrice.toStringAsFixed(2)}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Volume: ${volume.toStringAsFixed(2)}',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Trades: ${trades.length}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> fetchCryptoData(String cryptoSymbol) async {
    var klinesUrl = Uri.parse(
        'https://api.binance.com/api/v3/klines?symbol=${cryptoSymbol.toUpperCase()}&interval=1d');

    var tradesUrl = Uri.parse(
        'https://api.binance.com/api/v3/trades?symbol=${cryptoSymbol.toUpperCase()}&limit=10000');

    var klinesResponse = await http.get(klinesUrl);
    var tradesResponse = await http.get(tradesUrl);

    if (klinesResponse.statusCode == 200 && tradesResponse.statusCode == 200) {
      var klinesData = jsonDecode(klinesResponse.body);
      var tradesData = jsonDecode(tradesResponse.body);

      setState(() {
        cryptoData = klinesData;
        currentPrice = double.parse(klinesData.last[4]);
        highPrice = double.parse(klinesData.last[2]);
        lowPrice = double.parse(klinesData.last[3]);
        volume = double.parse(klinesData.last[5]);
        trades = tradesData;
        dataFound = true;
      });
    } else {
      print('Request failed with status: ${klinesResponse.statusCode}');
      setState(() {
        dataFound = false;
      });
    }
  }

  SfCartesianChart _buildChart() {
    return SfCartesianChart(
      plotAreaBackgroundColor: Color.fromRGBO(30, 35, 41, 1),
      primaryXAxis: DateTimeAxis(
        labelStyle: TextStyle(color: Colors.white),
      ),
      primaryYAxis: NumericAxis(
        labelStyle: TextStyle(color: Colors.white),
      ),
      series: <ChartSeries>[
        LineSeries<dynamic, DateTime>(
          dataSource: cryptoData.map((data) {
            return {
              'time': DateTime.fromMillisecondsSinceEpoch(data[0]),
              'price': double.parse(data[4]),
            };
          }).toList(),
          xValueMapper: (dynamic data, _) => data['time'],
          yValueMapper: (dynamic data, _) => data['price'],
          color: Color.fromRGBO(240, 185, 11, 1),
        ),
      ],
    );
  }
}
