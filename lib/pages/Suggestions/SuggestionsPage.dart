import 'package:financia_mobile_app/pages/Suggestions/CryptoSugges.dart';
import 'package:financia_mobile_app/pages/Suggestions/StockSugges.dart';
import 'package:flutter/material.dart';

class SuggestionsPage extends StatelessWidget {
  const SuggestionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(30, 35, 41, 1),
      appBar: AppBar(
        title: const Text(
          'Suggestions Page',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromRGBO(240, 185, 11, 1),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 400.0, // Adjust the size of the square box
              height: 400.0, // Adjust the size of the square box
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.scaleDown,
                  image: AssetImage('assets/Suggess.png'),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CrptoSugges()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(240, 185, 11, 1),
                minimumSize: const Size(380, 80),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      30), // Change this value to adjust the curve
                ),
              ),
              child: const Text('Crypto Suggestions'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const StockSugges()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(240, 185, 11, 1),
                minimumSize: const Size(380, 80),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      30), // Change this value to adjust the curve
                ),
              ),
              child: const Text('Stock Suggestions'),
            ),
          ],
        ),
      ),
    );
  }
}
