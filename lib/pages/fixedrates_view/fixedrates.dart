import 'package:financia_mobile_app/pages/fixedrates_view/webview.dart';
import 'package:flutter/material.dart';

import '../app_drawer.dart';

class Fixedrates extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(48, 52, 56, 1),
      appBar: AppBar(
        title: Text('Fixed Deposits Rates'),
        backgroundColor: Color.fromRGBO(240, 185, 11, 1),
      ),
      drawer: AppDrawer(
        email: '',
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: Text('Peoples bank'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WebView(
                          url: 'https://www.peoplesbank.lk/interest-rates/')),
                );
              },
            ),
            ElevatedButton(
              child: Text('Bank of Ceylon'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WebView(
                          url: 'https://boc.lk/index.php?route=rates/rates')),
                );
              },
            ),
            ElevatedButton(
              child: Text('Nationl Savings Bank'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WebView(
                          url:
                              'https://www.nsb.lk/rates-tarriffs/rupee-deposit-rates/')),
                );
              },
            ),
            Divider(),
            ElevatedButton(
              child: Text('Commercial Bank PLC'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WebView(
                          url:
                              'https://www.combank.lk/personal-banking/term-deposits/fixed-deposits')),
                );
              },
            ),
            ElevatedButton(
              child: Text('Seylan Bank PLC'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WebView(
                          url: 'https://www.seylan.lk/interest-rates#')),
                );
              },
            ),
            ElevatedButton(
              child: Text('Hatton National Bank'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WebView(
                          url:
                              'https://www.hnb.net/fixed-deposits-interest-rates')),
                );
              },
            ),
            ElevatedButton(
              child: Text('Sampath Bank PLC'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WebView(
                          url:
                              'https://www.sampath.lk/en/personal/term-deposit-accounts/fixed-deposits')),
                );
              },
            ),
            ElevatedButton(
              child: Text('Nationl Development Bank (NDB)'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WebView(
                          url:
                              'https://www.ndbbank.com/rates-and-tariffs?active=interest_rates_on_deposits')),
                );
              },
            ),
            ElevatedButton(
              child: Text('Nations Trust Bank '),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WebView(
                          url: 'https://www.nationstrust.com/deposit-rates')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
