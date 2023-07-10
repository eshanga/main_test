import 'package:financia_mobile_app/pages/Suggestions/CryptoSugges.dart';
import 'package:financia_mobile_app/pages/Suggestions/StockSugges.dart';
import 'package:flutter/material.dart';

class SuggestionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(30, 35, 41, 1),
      appBar: AppBar(
        title: Text(
          'Suggestions Page',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color.fromRGBO(240, 185, 11, 1),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 400.0, // Adjust the size of the square box
              height: 400.0, // Adjust the size of the square box
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/Suggess.png'),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CrptoSugges()),
                );
              },
              child: Text('Crypto Suggestions'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(240, 185, 11, 1),
                minimumSize: Size(380, 80),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      30), // Change this value to adjust the curve
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StockSugges()),
                );
              },
              child: Text('Stock Suggestions'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(240, 185, 11, 1),
                minimumSize: Size(380, 80),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      30), // Change this value to adjust the curve
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
