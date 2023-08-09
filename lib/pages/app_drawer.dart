import 'package:financia_mobile_app/pages/about_page.dart';
import 'package:financia_mobile_app/pages/expense_tracker/home_expense.dart';
import 'package:financia_mobile_app/pages/main_home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login_page.dart';
import 'screen2/screen2.dart';
import 'screen3/screen3.dart';
import 'screen4/screen4.dart';
import 'screen5/screen5.dart';
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
      backgroundColor: const Color.fromRGBO(30, 35, 41, 1),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              color: Color.fromRGBO(250, 211, 56, 1),
            ),
            accountName: const Text(
              "User Email",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            accountEmail: Text(
              user?.email ?? '',
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            currentAccountPicture: Center(
              child: Container(
                decoration: const BoxDecoration(
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
            leading: const Icon(
              Icons.home,
              color: Colors.white,
            ),
            title: const Text(
              'Home',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.monetization_on, color: Colors.white),
            title: const Text(
              'Expense Tracker',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomeExpense()));
            },
          ),
          ListTile(
<<<<<<< Updated upstream
            leading: Icon(Icons.screen_share, color: Colors.white),
            title: Text(
              'Available soon...',
=======
            leading: const Icon(Icons.settings_suggest, color: Colors.white),
            title: const Text(
              'Suggestions',
>>>>>>> Stashed changes
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onTap: () {
<<<<<<< Updated upstream
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Screen2()));
            },
          ),
          ListTile(
            leading: Icon(Icons.screen_share, color: Colors.white),
            title: Text(
              'Available soon...',
=======
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SuggestionsPage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.calculate, color: Colors.white),
            title: const Text(
              'Interest Calculator',
>>>>>>> Stashed changes
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onTap: () {
<<<<<<< Updated upstream
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Screen3()));
            },
          ),
          ListTile(
            leading: Icon(Icons.screen_share, color: Colors.white),
            title: Text(
              'Available soon...',
=======
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const InterestCalPage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.calculate, color: Colors.white),
            title: const Text(
              'Loan Calculator',
>>>>>>> Stashed changes
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onTap: () {
<<<<<<< Updated upstream
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Screen4()));
            },
          ),
          ListTile(
            leading: Icon(Icons.screen_share, color: Colors.white),
            title: Text(
              'Available soon...',
=======
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoanCalPage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.payment, color: Colors.white),
            title: const Text(
              'Bill Payments',
>>>>>>> Stashed changes
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onTap: () {
<<<<<<< Updated upstream
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Screen5()));
=======
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const BillPayPage()));
>>>>>>> Stashed changes
            },
          ),
          ListTile(
            leading: const Icon(Icons.screen_share, color: Colors.white),
            title: const Text(
              'Available soon...',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => const Screen6()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.white),
            title: const Text(
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
          const Divider(
            color: Colors.white70,
          ),
          Expanded(
            child: ListTile(
              leading: const Icon(Icons.touch_app, color: Colors.white),
              title: const Text(
                'About us',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AboutPage()));
              },
            ),
          )
        ],
      ),
    );
  }
}
