import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'add.dart';
import 'dashboard.dart';
import 'stats.dart';
import 'payment.dart';
import 'profile.dart';
import 'add.dart';

class HomeExpense extends StatefulWidget {
  const HomeExpense({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeExpense> {
  int currentTab = 0;
  final List<Widget> screens = [
    Dashboard(),
    Stats(),
    Payment(
      title: 'payemnt',
    ),
    Profile(),
    Add(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = Dashboard();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          setState(
            () {
              currentScreen = Add();
              currentTab = -1;
            },
          );
        },
        backgroundColor: Color.fromRGBO(240, 185, 11, 1),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          color: Color.fromRGBO(30, 35, 41, 1),
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    // minWidth: 20,
                    onPressed: () {
                      setState(
                        () {
                          currentScreen = Dashboard();
                          currentTab = 0;
                        },
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          CupertinoIcons.bars,
                          color: currentTab == 0
                              ? Color.fromRGBO(240, 185, 11, 1)
                              : Colors.grey,
                        ),
                        Text(
                          'Home',
                          style: TextStyle(
                              fontFamily: 'Helvetica',
                              color: currentTab == 0
                                  ? Color.fromRGBO(240, 185, 11, 1)
                                  : Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 50,
                    onPressed: () {
                      setState(
                        () {
                          currentScreen = Stats();
                          currentTab = 1;
                        },
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          CupertinoIcons.chart_bar_square,
                          color: currentTab == 1
                              ? Color.fromRGBO(240, 185, 11, 1)
                              : Colors.grey,
                        ),
                        Text(
                          'Stats',
                          style: TextStyle(
                              fontFamily: 'Helvetica',
                              color: currentTab == 1
                                  ? Color.fromRGBO(240, 185, 11, 1)
                                  : Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 70,
                    onPressed: () {
                      setState(
                        () {
                          currentScreen = Payment(
                            title: 'payemnt',
                          );
                          currentTab = 2;
                        },
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          CupertinoIcons.creditcard,
                          color: currentTab == 2
                              ? Color.fromRGBO(240, 185, 11, 1)
                              : Colors.grey,
                        ),
                        Text(
                          'Payment',
                          style: TextStyle(
                              fontFamily: 'Helvetica',
                              color: currentTab == 2
                                  ? Color.fromRGBO(240, 185, 11, 1)
                                  : Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 70,
                    onPressed: () {
                      setState(
                        () {
                          currentScreen = Profile();
                          currentTab = 3;
                        },
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          CupertinoIcons.person,
                          color: currentTab == 3
                              ? Color.fromRGBO(240, 185, 11, 1)
                              : Colors.grey,
                        ),
                        Text(
                          'Profile',
                          style: TextStyle(
                              fontFamily: 'Helvetica',
                              color: currentTab == 3
                                  ? Color.fromRGBO(240, 185, 11, 1)
                                  : Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
