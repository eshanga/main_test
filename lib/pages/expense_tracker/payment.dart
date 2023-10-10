import 'package:financia_mobile_app/pages/expense_tracker/payment/app_theme.dart';
import 'package:financia_mobile_app/pages/expense_tracker/payment/custom_widgets.dart';
import 'package:financia_mobile_app/pages/expense_tracker/payment/one_time_payment_page.dart';
import 'package:flutter/material.dart';

import '../scan_page.dart';
import 'payment/preapproval_payment_page.dart';
import 'payment/recurring_payment_page.dart';

class Payment extends StatefulWidget {
  const Payment({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(48, 52, 56, 1),
      appBar: AppBar(
        title: Text('Payment'),
        backgroundColor: Color.fromRGBO(240, 185, 11, 1),
      ),
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width * 0.28,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(80.0),
                bottomRight: Radius.circular(80.0),
              ),
              color: Color.fromRGBO(30, 35, 41, 1), // Background color
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/images/logo_rounded.png',
                  height: 100.0,
                  width: 100.0,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          CustomWidgets().paymentInstruction(),
          const SizedBox(
            height: 20.0,
          ),
          CustomWidgets().paymentOptionButton(
            context,
            const OneTimePaymentPage(),
            "One Time Payment",
            Color.fromRGBO(240, 185, 11, 1), // Accent color
            Colors.black, // Text color
          ),
          const SizedBox(
            height: 20.0,
          ),
          CustomWidgets().paymentOptionButton(
            context,
            const RecurringPaymentPage(),
            "Recurring Payment",
            Color.fromRGBO(240, 185, 11, 1), // Accent color
            Colors.black, // Text color
          ),
          const SizedBox(
            height: 20.0,
          ),
          CustomWidgets().paymentOptionButton(
            context,
            const PreapprovalPaymentPage(),
            "Preapproval Payment",
            Color.fromRGBO(240, 185, 11, 1), // Accent color
            Colors.black, // Text color
          ),
          const SizedBox(
            height: 20.0,
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  Color.fromRGBO(240, 185, 11, 1)),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
              fixedSize: MaterialStateProperty.all<Size>(
                  Size(200, 50)), // Adjust width and height as needed
            ),
            child: Text('Pay through QR'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ScanScreen(
                    appBarHeightSize: 12,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
