// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'util/my_button.dart';
import 'util/my_card.dart';
import 'util/my_list-tile.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'util/my_card.dart';

class WalletHomePage extends StatefulWidget {
  const WalletHomePage({Key? key, required int appBarHeightSize})
      : super(key: key);

  @override
  State<WalletHomePage> createState() => _WalletHomePageState();
}

class _WalletHomePageState extends State<WalletHomePage> {
  final _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(48, 52, 56, 1),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Color.fromRGBO(240, 185, 11, 1),
        child: Icon(Icons.home),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.settings, color: Color.fromRGBO(240, 185, 11, 1)),
          ),
          IconButton(
              onPressed: () {},
              icon: Icon(Icons.monetization_on,
                  color: Color.fromRGBO(240, 185, 11, 1)))
        ]),
      ),
      body: SafeArea(
        child: Column(children: [
          // app bar
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Digital Wallet',
                  style: TextStyle(
                    fontSize: 26,
                    color: Color.fromRGBO(240, 185, 11, 1),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(top: 4.0),
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(240, 185, 11, 1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.add,
                      color: Color.fromRGBO(48, 52, 56, 1),
                    )),
              ],
            ),
          ),
          SizedBox(height: 10),

          Container(
            height: 198,
            child: PageView(
              scrollDirection: Axis.horizontal,
              controller: _controller,
              children: [
                MyCard(
                  balance: 8950.20,
                  cardNumber: 123456789,
                  expiryMonth: 10,
                  expiryYear: 24,
                  color: Colors.blue,
                ),
                MyCard(
                  balance: 5340.20,
                  cardNumber: 123456789,
                  expiryMonth: 12,
                  expiryYear: 23,
                  color: Colors.red,
                ),
                MyCard(
                  balance: 3330.20,
                  cardNumber: 123456789,
                  expiryMonth: 12,
                  expiryYear: 25,
                  color: Colors.green[400],
                ),
              ],
            ),
          ),
          SizedBox(height: 24),

          SmoothPageIndicator(
            controller: _controller,
            count: 3,
            effect: ExpandingDotsEffect(
              activeDotColor: Colors.grey.shade600,
            ),
          ),

          SizedBox(height: 24),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MyButton(
                  iconImagePath: 'assets/icons/credit-card.png',
                  buttonText: 'Pay',
                  buttonTextColor: Color.fromRGBO(240, 185, 11, 1),
                ),
                MyButton(
                  iconImagePath: 'assets/icons/save-money.png',
                  buttonText: 'Send',
                  buttonTextColor: Color.fromRGBO(240, 185, 11, 1),
                ),
                MyButton(
                  iconImagePath: 'assets/icons/bill.png',
                  buttonText: 'Bills',
                  buttonTextColor: Color.fromRGBO(240, 185, 11, 1),
                ),
              ],
            ),
          ),
          SizedBox(height: 0),

          Padding(
            padding: const EdgeInsets.all(35.0),
            child: Column(children: [
              MyListTile(
                iconImagePath: 'assets/icons/transactions.png',
                tileTitle: 'History',
                tileSubtitle: 'Transactions Made',
                titleTextColor: Color.fromRGBO(240, 185, 11, 1),
              ),
              MyListTile(
                iconImagePath: 'assets/icons/graph-file.png',
                tileTitle: 'Payments',
                tileSubtitle: 'Statistics on Payment',
                titleTextColor: Color.fromRGBO(240, 185, 11, 1),
              ),
            ]),
          )
        ]),
      ),
    );
  }
}
