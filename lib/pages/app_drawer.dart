import 'package:financia_mobile_app/pages/about_page.dart';
import 'package:financia_mobile_app/pages/expense_tracker/home_expense.dart';
import 'package:financia_mobile_app/pages/main_home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login_page.dart';
import 'LoanCalculator/LoanCalculatorpage.dart';
import 'BillPayments/BillPaymentsPage.dart';
import 'Suggestions/SuggestionsPage.dart';
import 'InterestCalculator/InterestCalculatorPage.dart';
import 'screen6/screen6.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    Key? key,
    required this.email,
  }) : super(key: key);

  final String email;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Drawer(
      backgroundColor: Color.fromRGBO(30, 35, 41, 1),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromRGBO(250, 211, 56, 1),
            ),
            accountName: Text(
              "User Email",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            accountEmail: Text(
              user?.email ?? '',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            currentAccountPicture: Center(
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/1.1.png'),
                  ),
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.home,
              color: Colors.white,
            ),
            title: Text(
              'Home',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            },
          ),
          ListTile(
            leading: Icon(Icons.monetization_on, color: Colors.white),
            title: Text(
              'Expense Tracker',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeExpense()));
            },
          ),
          ListTile(
            leading: Icon(Icons.settings_suggest, color: Colors.white),
            title: Text(
              'Suggestions',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SuggestionsPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.calculate, color: Colors.white),
            title: Text(
              'Interest Calculator',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => InterestCalPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.calculate, color: Colors.white),
            title: Text(
              'Loan Calculator',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoanCalPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.payment, color: Colors.white),
            title: Text(
              'Bill Payments',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BillPaymentScreen()));
            },
          ),
          ListTile(
            leading: Icon(Icons.screen_share, color: Colors.white),
            title: Text(
              'Available soon...',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Screen6()));
            },
          ),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.white),
            title: Text(
              'Log out',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => LoginPage(
                          showRegisterPage: () {},
                        )),
              );
              FirebaseAuth.instance.signOut();

              // Add logout functionality here
            },
          ),
          Divider(
            color: Colors.white70,
          ),
          Expanded(
            child: ListTile(
              leading: Icon(Icons.touch_app, color: Colors.white),
              title: Text(
                'About us',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AboutPage()));
              },
            ),
          )
        ],
      ),
    );
  }
}
