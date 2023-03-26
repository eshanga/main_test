import 'package:flutter/material.dart';

import 'app_drawer.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
        backgroundColor: Colors.indigo,
      ),
      drawer: AppDrawer(
        email: '',
      ),
      body: Column(
        children: [
          Center(
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/company.png',
                    width: 400,
                    height: 400,
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'INNOVIA Solutions',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'We are a company that does amazing things.',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16.0),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Copyright © 2023 INNOVIA Solutions',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
