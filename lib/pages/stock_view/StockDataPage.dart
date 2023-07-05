import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_charts/charts.dart';

class StockDataPage extends StatefulWidget {
  @override
  _StockDataPageState createState() => _StockDataPageState();
}

class _StockDataPageState extends State<StockDataPage> {
  final TextEditingController _symbolController = TextEditingController();
  List<dynamic> stockData = [];
  double currentStockPrice = 0;
  double highPrice = 0;
  double lowPrice = 0;
  double volume = 0;
  bool dataFound = true;

  @override
  void dispose() {
    _symbolController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(30, 35, 41, 1),
      appBar: AppBar(
        title: Text('Stock Data'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: _symbolController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Enter Stock Symbol',
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
                  String symbol = _symbolController.text.toUpperCase();
                  fetchStockData(symbol);
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
              SizedBox(height: 16.0),
              Container(
                height: 300,
                child: stockData.isNotEmpty ? _buildChart() : Container(),
              ),
              SizedBox(height: 16.0),
              Text(
                'Today\'s Stock Price: ${currentStockPrice.toStringAsFixed(2)}',
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

  Future<void> fetchStockData(String symbol) async {
    var stockUrl =
        Uri.parse('https://query1.finance.yahoo.com/v8/finance/chart/$symbol');

    var stockResponse = await http.get(stockUrl);

    if (stockResponse.statusCode == 200) {
      var stockDataJson = jsonDecode(stockResponse.body);
      var resultData = stockDataJson['chart']['result'];
      if (resultData != null && resultData.isNotEmpty) {
        var seriesData = resultData[0]['indicators']['quote'][0];
        if (seriesData != null && seriesData.isNotEmpty) {
          setState(() {
            stockData = seriesData['close'];
            currentStockPrice = stockData.last;
            highPrice =
                seriesData['high'].reduce((a, b) => a > b ? a : b).toDouble();
            lowPrice =
                seriesData['low'].reduce((a, b) => a < b ? a : b).toDouble();
            volume = seriesData['volume'].reduce((a, b) => a + b).toDouble();
            dataFound = true;
          });
          return;
        }
      }
    }

    print('Stock data not available for the given symbol.');
    setState(() {
      stockData = [];
      currentStockPrice = 0;
      highPrice = 0;
      lowPrice = 0;
      volume = 0;
      dataFound = false;
    });
  }

  SfCartesianChart _buildChart() {
    return SfCartesianChart(
      backgroundColor: Color.fromRGBO(30, 35, 41, 1),
      primaryXAxis: CategoryAxis(
        labelStyle: TextStyle(color: Colors.white),
      ),
      primaryYAxis: NumericAxis(
        labelStyle: TextStyle(color: Colors.white),
      ),
      series: <ChartSeries>[
        LineSeries<dynamic, String>(
          dataSource: stockData.asMap().entries.map((data) {
            return {
              'index': data.key.toString(),
              'stockPrice': data.value.toDouble(),
            };
          }).toList(),
          xValueMapper: (dynamic data, _) => data['index'],
          yValueMapper: (dynamic data, _) => data['stockPrice'],
          color: Color.fromRGBO(240, 185, 11, 1),
        ),
      ],
    );
  }
}
