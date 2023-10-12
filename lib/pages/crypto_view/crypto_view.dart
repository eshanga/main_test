import 'package:financia_mobile_app/pages/crypto_view/topgainercrypto.dart';
import 'package:financia_mobile_app/pages/crypto_view/toplosercrypto.dart';
import 'package:financia_mobile_app/pages/crypto_view/toptransactioncrypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../app_drawer.dart';

class cryptoview extends StatefulWidget {
  const cryptoview({Key? key}) : super(key: key);

  @override
  _cryptoviewState createState() => _cryptoviewState();
}

class _cryptoviewState extends State<cryptoview> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          backgroundColor: Color.fromRGBO(48, 52, 56, 1),
          appBar: AppBar(
            title: "Crypto Currency Market"
                .text
                .xl2
                .fontFamily('Helvetica')
                .color(Colors.black)
                .make(),
            backgroundColor: Color.fromRGBO(240, 185, 11, 1),
            bottom: TabBar(
              labelColor: Colors.black, // Change the selected tab's text color
              unselectedLabelColor:
                  Colors.white, // Change the unselected tabs' text color
              tabs: [
                Tab(
                  text: 'Top Gainers',
                  icon: Icon(CupertinoIcons.sort_up, color: Colors.black),
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
              topgainercrypto(),
              toplosercrypto(),
              toptransactioncrypto(),
            ],
          )),
    );
  }
}
