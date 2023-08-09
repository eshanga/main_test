import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/gestures.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:velocity_x/velocity_x.dart';
import 'indicator.dart';
import 'dart:async';

class Categorywise extends StatefulWidget {
  const Categorywise({super.key});

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State {
  var _spent = [0, 0, 0, 0, 0, 0, 0, 0];
  final _spenttext = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0];
  var _total;
  var ringdate = DateTime.now();

  Future<List> getData(snapshot) async {
    _spent = [0, 0, 0, 0, 0, 0, 0, 0];
    _total = 0;
    snapshot.data!.docs.forEach((user) {
      int i0 = 0;
      if (user['category'] == 'Education') {
        i0 = user['spent'];
        _spent[0] = _spent[0] + i0;
        _total = _total + i0;
      } else if (user['category'] == 'Rent') {
        i0 = user['spent'];
        _spent[1] = _spent[1] + i0;
        _total = _total + i0;
      } else if (user['category'] == 'Entertainment') {
        i0 = user['spent'];
        _spent[2] = _spent[2] + i0;
        _total = _total + i0;
      } else if (user['category'] == 'Taxes') {
        i0 = user['spent'];
        _spent[3] = _spent[3] + i0;
        _total = _total + i0;
      } else if (user['category'] == 'Vehicle') {
        i0 = user['spent'];
        _spent[4] = _spent[4] + i0;
        _total = _total + i0;
      } else if (user['category'] == 'Stationary') {
        i0 = user['spent'];
        _spent[5] = _spent[5] + i0;
        _total = _total + i0;
      } else if (user['category'] == 'Meal') {
        i0 = user['spent'];
        _spent[6] = _spent[6] + i0;
        _total = _total + i0;
      } else if (user['category'] == 'Other') {
        i0 = user['spent'];
        _spent[7] = _spent[7] + i0;
        _total = _total + i0;
      }
    });
    for (int i = 0; i < _spent.length; i++) {
      var temp = _spent[i] / _total;
      _spenttext[i] = temp * 100;
    }
    return _spent;
  }

  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final userKey = FirebaseAuth.instance.currentUser;
    ringdate = DateTime(ringdate.year, ringdate.month);
    return SingleChildScrollView(
      child: Container(
          child: Column(
        children: <Widget>[
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(top: 25, left: 25),
              child: Text(
                'Categorywise Analytics',
                style: TextStyle(
                  fontFamily: 'Helvetica',
                  color: Color.fromRGBO(240, 185, 11, 1),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          AspectRatio(
            aspectRatio: 1.1,
            child: Container(
              color: const Color.fromRGBO(48, 52, 56, 1),
              child: Row(
                children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  Flexible(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection(userKey!.email!)
                              .where("date", isGreaterThanOrEqualTo: ringdate)
                              .snapshots(),
                          builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData) {
                              return Center(
                                  child: const CircularProgressIndicator()
                                      .centered()
                                      .expand());
                            }
                            getData(snapshot).then((spent) {
                              setState(() {});
                            });
                            return PieChart(
                              PieChartData(
                                  pieTouchData: PieTouchData(
                                      touchCallback: (pieTouchResponse) {
                                    setState(() {
                                      final desiredTouch =
                                          pieTouchResponse.touchInput
                                                  is! PointerExitEvent &&
                                              pieTouchResponse.touchInput
                                                  is! PointerUpEvent;
                                      if (desiredTouch &&
                                          pieTouchResponse.touchedSection !=
                                              null) {
                                        touchedIndex = pieTouchResponse
                                            .touchedSection!
                                            .touchedSectionIndex;
                                      } else {
                                        touchedIndex = -1;
                                      }
                                    });
                                  }),
                                  borderData: FlBorderData(
                                    show: false,
                                  ),
                                  sectionsSpace: 2,
                                  centerSpaceRadius: 50,
                                  sections: showingSections()),
                            );
                          }),
                    ),
                  ),
                  const Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Indicator(
                        color: Color(0xff0293ee),
                        text: 'Education',
                        textColor: Colors.white,
                        isSquare: true,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Indicator(
                        color: Color(0xfff8b250),
                        text: 'Rent',
                        textColor: Colors.white,
                        isSquare: true,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Indicator(
                        color: Color(0xff845bef),
                        text: 'Entertainment',
                        textColor: Colors.white,
                        isSquare: true,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Indicator(
                        color: Color(0xff13d38e),
                        text: 'Taxes',
                        textColor: Colors.white,
                        isSquare: true,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Indicator(
                        color: Color(0xffec407a),
                        text: 'Vehicle',
                        textColor: Colors.white,
                        isSquare: true,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Indicator(
                        color: Color(0xffd500f9),
                        text: 'Stationary',
                        textColor: Colors.white,
                        isSquare: true,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Indicator(
                        color: Color(0xff00695c),
                        text: 'Meal',
                        textColor: Colors.white,
                        isSquare: true,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Indicator(
                        color: Color.fromARGB(255, 171, 182, 187),
                        text: 'Other',
                        textColor: Colors.white,
                        isSquare: true,
                      ),
                      SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(8, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 20.0 : 16.0;
      final radius = isTouched ? 55.0 : 48.0;

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xff0293ee),
            value: _spent[0].toDouble(),
            title: _spenttext[0].toStringAsFixed(2),
            radius: radius,
            titleStyle:
                TextStyle(fontSize: fontSize, color: const Color(0xffffffff)),
          );

        case 1:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: _spent[1].toDouble(),
            title: _spenttext[1].toStringAsFixed(2),
            radius: radius,
            titleStyle:
                TextStyle(fontSize: fontSize, color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xff845bef),
            value: _spent[2].toDouble(),
            title: _spenttext[2].toStringAsFixed(2),
            radius: radius,
            titleStyle:
                TextStyle(fontSize: fontSize, color: const Color(0xffffffff)),
          );
        case 3:
          return PieChartSectionData(
            color: const Color(0xff13d38e),
            value: _spent[3].toDouble(),
            title: _spenttext[3].toStringAsFixed(2),
            radius: radius,
            titleStyle:
                TextStyle(fontSize: fontSize, color: const Color(0xffffffff)),
          );
        case 4:
          return PieChartSectionData(
            color: const Color(0xffec407a),
            value: _spent[4].toDouble(),
            title: _spenttext[4].toStringAsFixed(2),
            radius: radius,
            titleStyle:
                TextStyle(fontSize: fontSize, color: const Color(0xffffffff)),
          );
        case 5:
          return PieChartSectionData(
            color: const Color(0xffd500f9),
            value: _spent[5].toDouble(),
            title: _spenttext[5].toStringAsFixed(2),
            radius: radius,
            titleStyle:
                TextStyle(fontSize: fontSize, color: const Color(0xffffffff)),
          );
        case 6:
          return PieChartSectionData(
            color: const Color(0xff00695c),
            value: _spent[6].toDouble(),
            title: _spenttext[6].toStringAsFixed(2),
            radius: radius,
            titleStyle:
                TextStyle(fontSize: fontSize, color: const Color(0xffffffff)),
          );
        case 7:
          return PieChartSectionData(
            color: const Color.fromARGB(255, 171, 182, 187),
            value: _spent[7].toDouble(),
            title: _spenttext[7].toStringAsFixed(2),
            radius: radius,
            titleStyle:
                TextStyle(fontSize: fontSize, color: const Color(0xffffffff)),
          );
        default:
          throw Error();
      }
    });
  }
}
