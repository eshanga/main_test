import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_charts/charts.dart';

class StockDataPage extends StatefulWidget {
  @override
  _StockDataPageState createState() => _StockDataPageState();
}

class _StockDataPageState extends State<StockDataPage> {
  final TextEditingController _stockSymbolController = TextEditingController();
  List<dynamic> stockData = [];
  double currentPrice = 0;
  double highPrice = 0;
  double lowPrice = 0;
  double volume = 0;
  List<dynamic> trades = [];
  bool dataFound = true;

  @override
  void dispose() {
    _stockSymbolController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(30, 35, 41, 1),
      appBar: AppBar(
        title: Text(
          'Stock Wise Data',
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
          child: Column(
            children: [
              TextFormField(
                controller: _stockSymbolController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Enter Stock Symbol (e.g., AAPL)',
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
                  String stockSymbol =
                      _stockSymbolController.text.toUpperCase();
                  fetchStockData(stockSymbol);
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
              if (stockData.isNotEmpty)
                Container(
                  height: 300,
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

  Future<void> fetchStockData(String stockSymbol) async {
    var apiKey = '10b48b466ea94b08a2c316bb127a1c75';
    var apiUrl =
        'https://api.twelvedata.com/time_series?symbol=$stockSymbol&interval=1day&apikey=$apiKey';

    var response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);

      var timeSeries = jsonData['values'];

      if (timeSeries != null) {
        setState(() {
          stockData = timeSeries;
          currentPrice = double.parse(timeSeries.last['close']);
          highPrice = double.parse(timeSeries.last['high']);
          lowPrice = double.parse(timeSeries.last['low']);
          volume = double.parse(timeSeries.last['volume']);
          trades = timeSeries;
          dataFound = true;
        });
      } else {
        setState(() {
          dataFound = false;
        });
      }
    } else {
      print('Request failed with status: ${response.statusCode}');
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
          dataSource: stockData.map((data) {
            return {
              'time': DateTime.parse(data['datetime']),
              'price': double.parse(data['close']),
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
