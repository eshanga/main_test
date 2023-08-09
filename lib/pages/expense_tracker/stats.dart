import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../app_drawer.dart';
import 'stats/categorywise.dart';
import 'stats/monthly.dart';
import 'stats/weekly.dart';

class Stats extends StatefulWidget {
  const Stats({Key? key}) : super(key: key);

  @override
  _StatsState createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          backgroundColor: const Color.fromRGBO(48, 52, 56, 1),
          appBar: AppBar(
            title: "Stats"
                .text
                .xl2
                .fontFamily('Helvetica')
                .color(Colors.black)
                .make(),
            backgroundColor: const Color.fromRGBO(240, 185, 11, 1),
            bottom: const TabBar(
              tabs: [
                Tab(
                  text: 'Weekly',
                  icon: Icon(
                    CupertinoIcons.chart_bar,
                    color: Vx.black,
                  ),
                ),
                Tab(
                  text: 'Monthly',
                  icon: Icon(
                    CupertinoIcons.graph_square,
                    color: Vx.black,
                  ),
                ),
                Tab(
                  text: 'Categorywise',
                  icon: Icon(
                    CupertinoIcons.chart_pie,
                    color: Vx.black,
                  ),
                ),
              ],
            ),
          ),
          drawer: const AppDrawer(
            email: '',
          ),
          body: const TabBarView(
            children: [
              Weekly(),
              Monthly(),
              Categorywise(),
            ],
          )),
    );
  }
}
