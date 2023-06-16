import 'package:financia_mobile_app/pages/fixedrates_view/webview.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import '../app_drawer.dart';

class Fixedrates extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(48, 52, 56, 1),
      appBar: AppBar(
        title: "Crypto Currency Market"
            .text
            .xl2
            .fontFamily('Helvetica')
            .color(Colors.black)
            .make(),
        backgroundColor: Color.fromRGBO(240, 185, 11, 1),
      ),
      drawer: AppDrawer(email: ''),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                width: 200.0, // Adjust the size of the square box
                height: 200.0, // Adjust the size of the square box
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.scaleDown,
                    image: AssetImage('assets/fixed.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(80, 85, 88, 1),
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: BorderSide(
                      color: Color.fromRGBO(240, 185, 11,
                          1), // Replace with your desired border color
                      width: 2.0, // Adjust the border width as needed
                    ),
                  ),
                ),
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
              SizedBox(height: 12.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(80, 85, 88, 1),
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: BorderSide(
                      color: Color.fromRGBO(240, 185, 11,
                          1), // Replace with your desired border color
                      width: 2.0, // Adjust the border width as needed
                    ),
                  ),
                ),
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
              SizedBox(height: 12.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(80, 85, 88, 1),
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: BorderSide(
                      color: Color.fromRGBO(240, 185, 11,
                          1), // Replace with your desired border color
                      width: 2.0, // Adjust the border width as needed
                    ),
                  ),
                ),
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
              SizedBox(height: 24.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(80, 85, 88, 1),
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: BorderSide(
                      color: Color.fromRGBO(240, 185, 11,
                          1), // Replace with your desired border color
                      width: 2.0, // Adjust the border width as needed
                    ),
                  ),
                ),
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
              SizedBox(height: 12.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(80, 85, 88, 1),
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: BorderSide(
                      color: Color.fromRGBO(240, 185, 11,
                          1), // Replace with your desired border color
                      width: 2.0, // Adjust the border width as needed
                    ),
                  ),
                ),
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
              SizedBox(height: 12.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(80, 85, 88, 1),
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: BorderSide(
                      color: Color.fromRGBO(240, 185, 11,
                          1), // Replace with your desired border color
                      width: 2.0, // Adjust the border width as needed
                    ),
                  ),
                ),
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
              SizedBox(height: 12.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(80, 85, 88, 1),
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: BorderSide(
                      color: Color.fromRGBO(240, 185, 11,
                          1), // Replace with your desired border color
                      width: 2.0, // Adjust the border width as needed
                    ),
                  ),
                ),
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
              SizedBox(height: 12.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(80, 85, 88, 1),
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: BorderSide(
                      color: Color.fromRGBO(240, 185, 11,
                          1), // Replace with your desired border color
                      width: 2.0, // Adjust the border width as needed
                    ),
                  ),
                ),
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
              SizedBox(height: 12.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(80, 85, 88, 1),
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: BorderSide(
                      color: Color.fromRGBO(240, 185, 11,
                          1), // Replace with your desired border color
                      width: 2.0, // Adjust the border width as needed
                    ),
                  ),
                ),
                child: Text('Nations Trust Bank'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WebView(
                        url: 'https://www.nationstrust.com/deposit-rates',
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
