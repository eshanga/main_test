import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'add.dart';
import 'dashboard.dart';
import 'stats.dart';
import 'payment.dart';
import 'profile.dart';

class HomeExpense extends StatefulWidget {
  const HomeExpense({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeExpense> {
  int currentTab = 0;
  final List<Widget> screens = [
    const Dashboard(),
    const Stats(),
    const Payment(),
    const Profile(),
    const Add(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const Dashboard();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(
            () {
              currentScreen = const Add();
              currentTab = -1;
            },
          );
        },
        backgroundColor: const Color.fromRGBO(240, 185, 11, 1),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          color: const Color.fromRGBO(30, 35, 41, 1),
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
                          currentScreen = const Dashboard();
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
                              ? const Color.fromRGBO(240, 185, 11, 1)
                              : Colors.grey,
                        ),
                        Text(
                          'Home',
                          style: TextStyle(
                              fontFamily: 'Helvetica',
                              color: currentTab == 0
                                  ? const Color.fromRGBO(240, 185, 11, 1)
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
                          currentScreen = const Stats();
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
                              ? const Color.fromRGBO(240, 185, 11, 1)
                              : Colors.grey,
                        ),
                        Text(
                          'Stats',
                          style: TextStyle(
                              fontFamily: 'Helvetica',
                              color: currentTab == 1
                                  ? const Color.fromRGBO(240, 185, 11, 1)
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
                          currentScreen = const Payment();
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
                              ? const Color.fromRGBO(240, 185, 11, 1)
                              : Colors.grey,
                        ),
                        Text(
                          'Payment',
                          style: TextStyle(
                              fontFamily: 'Helvetica',
                              color: currentTab == 2
                                  ? const Color.fromRGBO(240, 185, 11, 1)
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
                          currentScreen = const Profile();
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
                              ? const Color.fromRGBO(240, 185, 11, 1)
                              : Colors.grey,
                        ),
                        Text(
                          'Profile',
                          style: TextStyle(
                              fontFamily: 'Helvetica',
                              color: currentTab == 3
                                  ? const Color.fromRGBO(240, 185, 11, 1)
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
