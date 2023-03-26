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
          appBar: AppBar(
            title: "Stats"
                .text
                .xl2
                .fontFamily('Helvetica')
                .color(Colors.white)
                .make(),
            backgroundColor: Colors.indigo,
            bottom: TabBar(
              tabs: [
                Tab(
                  text: 'Weekly',
                  icon: Icon(CupertinoIcons.chart_bar),
                ),
                Tab(
                  text: 'Monthly',
                  icon: Icon(CupertinoIcons.graph_square),
                ),
                Tab(
                  text: 'Categorywise',
                  icon: Icon(CupertinoIcons.chart_pie),
                ),
              ],
            ),
          ),
          drawer: AppDrawer(
            email: '',
          ),
          body: TabBarView(
            children: [
              Weekly(),
              Monthly(),
              Categorywise(),
            ],
          )),
    );
  }
}