import 'package:financia_mobile_app/pages/about_page.dart';
import 'package:financia_mobile_app/pages/expense_tracker/home_expense.dart';
import 'package:financia_mobile_app/pages/main_home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
      backgroundColor: Color.fromRGBO(30, 35, 41, 1),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 172, 156, 12),
            ),
            accountName: Text("User Email"),
            accountEmail: Text(
              user?.email ?? '',
              style: TextStyle(
                fontSize: 17,
                color: Colors.grey,
              ),
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
            leading: Icon(Icons.home),
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
            leading: Icon(Icons.screen_share),
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
            leading: Icon(Icons.screen_share),
            title: Text(
              'Screen 2',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Screen2()));
            },
          ),
          ListTile(
            leading: Icon(Icons.screen_share),
            title: Text(
              'Screen 3',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Screen3()));
            },
          ),
          ListTile(
            leading: Icon(Icons.screen_share),
            title: Text(
              'Screen 4',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Screen4()));
            },
          ),
          ListTile(
            leading: Icon(Icons.screen_share),
            title: Text(
              'Screen 5',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Screen5()));
            },
          ),
          ListTile(
            leading: Icon(Icons.screen_share),
            title: Text(
              'Screen 6',
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
            leading: Icon(Icons.logout),
            title: Text(
              'Logout',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onTap: () {
              FirebaseAuth.instance.signOut();

              // Add logout functionality here
            },
          ),
          Divider(),
          Expanded(
            child: ListTile(
              leading: Icon(Icons.screen_share),
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
