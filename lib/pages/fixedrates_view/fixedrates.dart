import 'package:financia_mobile_app/pages/fixedrates_view/webview.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import '../app_drawer.dart';

class Fixedrates extends StatelessWidget {
  const Fixedrates({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(48, 52, 56, 1),
      appBar: AppBar(
        title: "Crypto Currency Market"
            .text
            .xl2
            .fontFamily('Helvetica')
            .color(Colors.black)
            .make(),
        backgroundColor: const Color.fromRGBO(240, 185, 11, 1),
      ),
      drawer: const AppDrawer(email: ''),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                width: 200.0, // Adjust the size of the square box
                height: 200.0, // Adjust the size of the square box
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.scaleDown,
                    image: AssetImage('assets/fixed.png'),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: const Color.fromRGBO(80, 85, 88, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: const BorderSide(
                      color: Color.fromRGBO(240, 185, 11,
                          1), // Replace with your desired border color
                      width: 2.0, // Adjust the border width as needed
                    ),
                  ),
                ),
                child: const Text('Peoples bank'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WebView(
                            url: 'https://www.peoplesbank.lk/interest-rates/')),
                  );
                },
              ),
              const SizedBox(height: 12.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: const Color.fromRGBO(80, 85, 88, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: const BorderSide(
                      color: Color.fromRGBO(240, 185, 11,
                          1), // Replace with your desired border color
                      width: 2.0, // Adjust the border width as needed
                    ),
                  ),
                ),
                child: const Text('Bank of Ceylon'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WebView(
                            url: 'https://boc.lk/index.php?route=rates/rates')),
                  );
                },
              ),
              const SizedBox(height: 12.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: const Color.fromRGBO(80, 85, 88, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: const BorderSide(
                      color: Color.fromRGBO(240, 185, 11,
                          1), // Replace with your desired border color
                      width: 2.0, // Adjust the border width as needed
                    ),
                  ),
                ),
                child: const Text('Nationl Savings Bank'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WebView(
                            url:
                                'https://www.nsb.lk/rates-tarriffs/rupee-deposit-rates/')),
                  );
                },
              ),
              const SizedBox(height: 24.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: const Color.fromRGBO(80, 85, 88, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: const BorderSide(
                      color: Color.fromRGBO(240, 185, 11,
                          1), // Replace with your desired border color
                      width: 2.0, // Adjust the border width as needed
                    ),
                  ),
                ),
                child: const Text('Commercial Bank PLC'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WebView(
                            url:
                                'https://www.combank.lk/personal-banking/term-deposits/fixed-deposits')),
                  );
                },
              ),
              const SizedBox(height: 12.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: const Color.fromRGBO(80, 85, 88, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: const BorderSide(
                      color: Color.fromRGBO(240, 185, 11,
                          1), // Replace with your desired border color
                      width: 2.0, // Adjust the border width as needed
                    ),
                  ),
                ),
                child: const Text('Seylan Bank PLC'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WebView(
                            url: 'https://www.seylan.lk/interest-rates#')),
                  );
                },
              ),
              const SizedBox(height: 12.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: const Color.fromRGBO(80, 85, 88, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: const BorderSide(
                      color: Color.fromRGBO(240, 185, 11,
                          1), // Replace with your desired border color
                      width: 2.0, // Adjust the border width as needed
                    ),
                  ),
                ),
                child: const Text('Hatton National Bank'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WebView(
                            url:
                                'https://www.hnb.net/fixed-deposits-interest-rates')),
                  );
                },
              ),
              const SizedBox(height: 12.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: const Color.fromRGBO(80, 85, 88, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: const BorderSide(
                      color: Color.fromRGBO(240, 185, 11,
                          1), // Replace with your desired border color
                      width: 2.0, // Adjust the border width as needed
                    ),
                  ),
                ),
                child: const Text('Sampath Bank PLC'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WebView(
                            url:
                                'https://www.sampath.lk/en/personal/term-deposit-accounts/fixed-deposits')),
                  );
                },
              ),
              const SizedBox(height: 12.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: const Color.fromRGBO(80, 85, 88, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: const BorderSide(
                      color: Color.fromRGBO(240, 185, 11,
                          1), // Replace with your desired border color
                      width: 2.0, // Adjust the border width as needed
                    ),
                  ),
                ),
                child: const Text('Nationl Development Bank (NDB)'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WebView(
                            url:
                                'https://www.ndbbank.com/rates-and-tariffs?active=interest_rates_on_deposits')),
                  );
                },
              ),
              const SizedBox(height: 12.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: const Color.fromRGBO(80, 85, 88, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: const BorderSide(
                      color: Color.fromRGBO(240, 185, 11,
                          1), // Replace with your desired border color
                      width: 2.0, // Adjust the border width as needed
                    ),
                  ),
                ),
                child: const Text('Nations Trust Bank'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WebView(
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
