import 'package:financia_mobile_app/pages/stock_view/topgainerstock.dart';
import 'package:financia_mobile_app/pages/stock_view/toploserstock.dart';
import 'package:financia_mobile_app/pages/stock_view/toptransactionstock.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../app_drawer.dart';

class stockview extends StatefulWidget {
  const stockview({Key? key}) : super(key: key);

  @override
  _stockviewState createState() => _stockviewState();
}

class _stockviewState extends State<stockview> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          backgroundColor: Color.fromRGBO(48, 52, 56, 1),
          appBar: AppBar(
            title: "Stock Market"
                .text
                .xl2
                .fontFamily('Helvetica')
                .color(Colors.black)
                .make(),
            backgroundColor: Color.fromRGBO(240, 185, 11, 1),
            bottom: TabBar(
              labelColor: Colors.black, // Change the selected tab's text color
              unselectedLabelColor: Colors.white,
              tabs: [
                Tab(
                  text: 'Top Gainers',
                  icon: Icon(
                    CupertinoIcons.sort_up,
                    color: Colors.black,
                  ),
                ),
                Tab(
                  text: 'Top Losers',
                  icon: Icon(CupertinoIcons.sort_down, color: Colors.black),
                ),
                Tab(
                  text: 'Top Transactions',
                  icon:
                      Icon(CupertinoIcons.rectangle_stack, color: Colors.black),
                ),
              ],
            ),
          ),
          drawer: AppDrawer(
            email: '',
          ),
          body: TabBarView(
            children: [
              topgainerstock(),
              toploserstock(),
              toptransactionstock(),
            ],
          )),
    );
  }
}
