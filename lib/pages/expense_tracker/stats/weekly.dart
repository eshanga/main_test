import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:telephony/telephony.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart';

class Weekly extends StatefulWidget {
  const Weekly({Key? key}) : super(key: key);

  @override
  _WeeklyState createState() => _WeeklyState();
}

class _WeeklyState extends State<Weekly> {
  static var d = DateTime.now();
  static var weekDay = d.weekday;
  var firstDayOfWeek = d.subtract(Duration(days: weekDay));

  List<double> weeklyData = [0, 0, 0, 0, 0, 0, 0];
  var weekspent = [0, 0, 0, 0, 0, 0, 0];
  int touchedIndex = 0;

  Future<List> getWeeklyData(snapshot) async {
    for (int i = 0; i < 7; i++) {
      weeklyData[i] = 0;
    }
    snapshot.data!.docs.forEach((user) {
      int i = 0;
      if (DateFormat("dd-MM-yyyy").format(user['date'].toDate()) ==
          DateFormat("dd-MM-yyyy")
              .format(d.subtract(Duration(days: weekDay - 1)))) {
        i = user['spent'];
        weekspent[0] = weekspent[0] + i;
      } else if (DateFormat("dd-MM-yyyy").format(user['date'].toDate()) ==
          DateFormat("dd-MM-yyyy")
              .format(d.subtract(Duration(days: weekDay - 2)))) {
        i = user['spent'];
        weekspent[1] = weekspent[1] + i;
      } else if (DateFormat("dd-MM-yyyy").format(user['date'].toDate()) ==
          DateFormat("dd-MM-yyyy")
              .format(d.subtract(Duration(days: weekDay - 3)))) {
        i = user['spent'];
        weekspent[2] = weekspent[2] + i;
      } else if (DateFormat("dd-MM-yyyy").format(user['date'].toDate()) ==
          DateFormat("dd-MM-yyyy")
              .format(d.subtract(Duration(days: weekDay - 4)))) {
        i = user['spent'];
        weekspent[3] = weekspent[3] + i;
      } else if (DateFormat("dd-MM-yyyy").format(user['date'].toDate()) ==
          DateFormat("dd-MM-yyyy")
              .format(d.subtract(Duration(days: weekDay - 5)))) {
        i = user['spent'];
        weekspent[4] = weekspent[4] + i;
      } else if (DateFormat("dd-MM-yyyy").format(user['date'].toDate()) ==
          DateFormat("dd-MM-yyyy")
              .format(d.subtract(Duration(days: weekDay - 6)))) {
        i = user['spent'];
        weekspent[5] = weekspent[5] + i;
      } else if (DateFormat("dd-MM-yyyy").format(user['date'].toDate()) ==
          DateFormat("dd-MM-yyyy")
              .format(d.subtract(Duration(days: weekDay - 7)))) {
        i = user['spent'];
        weekspent[6] = weekspent[6] + i;
      }
    });
    for (int i = 0; i < 7; i++) {
      weeklyData[i] = weekspent[i].toDouble();
    }
    weekspent = [0, 0, 0, 0, 0, 0, 0, 0];
    return weekspent;
  }

  @override
  Widget build(BuildContext context) {
    final userKey = FirebaseAuth.instance.currentUser;
    return SingleChildScrollView(
      child: Container(
        height: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Color.fromRGBO(240, 185, 11, 1),
        ),
        margin: EdgeInsets.all(10.0),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              'Weekly Analytics',
              style: TextStyle(
                fontFamily: 'Helvetica',
                color: Color.fromRGBO(0, 0, 0, 1),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            const SizedBox(
              height: 25,
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection(userKey!.email!)
                        .where("date", isGreaterThan: firstDayOfWeek)
                        .snapshots(),
                    builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                            child: CircularProgressIndicator()
                                .centered()
                                .expand());
                      }
                      getWeeklyData(snapshot).then((weekspent) {
                        setState(() {});
                      });
                      return BarChart(
                        mainBarData(),
                      );
                    }),
              ),
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }

  BarChartGroupData _buildBar(
    int x,
    double y, {
    bool isTouched = false,
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: y,
          colors: [
            Color.fromRGBO(103, 105, 106, 1),
            Color.fromRGBO(0, 0, 0, 1)
          ],
          width: 22,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            y: 20,
          ),
        ),
      ],
    );
  }

  List<BarChartGroupData> _buildAllBars() {
    return List.generate(
      weeklyData.length,
      (index) =>
          _buildBar(index, weeklyData[index], isTouched: index == touchedIndex),
    );
  }

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: _buildBarTouchData(),
      titlesData: _buildAxes(),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: _buildAllBars(),
    );
  }

  FlTitlesData _buildAxes() {
    return FlTitlesData(
      // Build X axis.
      bottomTitles: SideTitles(
        showTitles: true,
        margin: 22,
        getTitles: (double value) {
          switch (value.toInt()) {
            case 0:
              return 'Mon';
            case 1:
              return 'Tue';
            case 2:
              return 'Wed';
            case 3:
              return 'Thu';
            case 4:
              return 'Fri';
            case 5:
              return 'Sat';
            case 6:
              return 'Sun';
            default:
              return '';
          }
        },
      ),
      // Build Y axis.
      leftTitles: SideTitles(
        showTitles: false,
        getTitles: (double value) {
          return value.toString();
        },
      ),
    );
  }

  BarTouchData _buildBarTouchData() {
    return BarTouchData(
      touchTooltipData: BarTouchTooltipData(
        tooltipBgColor: Color.fromRGBO(88, 88, 88, 1),
        getTooltipItem: (group, groupIndex, rod, rodIndex) {
          String weekDay = "";
          switch (group.x.toInt()) {
            case 0:
              weekDay = 'Monday';
              break;
            case 1:
              weekDay = 'Tuesday';
              break;
            case 2:
              weekDay = 'Wednesday';
              break;
            case 3:
              weekDay = 'Thursday';
              break;
            case 4:
              weekDay = 'Friday';
              break;
            case 5:
              weekDay = 'Saturday';
              break;
            case 6:
              weekDay = 'Sunday';
              break;
          }
          return BarTooltipItem(
            weekDay + '\n' + "Rs. " + (rod.y).toString(),
            TextStyle(color: Colors.white),
          );
        },
      ),
    );
  }
}
