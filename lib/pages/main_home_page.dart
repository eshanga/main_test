import 'package:financia_mobile_app/pages/crypto_view/CryptoDataPage.dart';
import 'package:financia_mobile_app/pages/stock_view/StockDataPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:velocity_x/velocity_x.dart';
import '../components/customListTile.dart';
import '../model/article_model.dart';
import '../services/api_service.dart';
import 'app_drawer.dart';
import 'crypto_view/crypto_view.dart';
import 'expense_tracker/home_expense.dart';
import 'fixedrates_view/fixedrates.dart';
import 'login_page.dart';
import 'LoanCalculator/LoanCalculatorpage.dart';
import 'BillPayments/BillPaymentsPage.dart';
import 'Suggestions/SuggestionsPage.dart';
import 'InterestCalculator/InterestCalculatorPage.dart';
import 'screen6/screen6.dart';
import 'stock_view/stock_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ApiService client = ApiService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(30, 35, 41, 1),
      appBar: AppBar(
        title: "Homescreen"
            .text
            .xl2
            .fontFamily('Helvetica')
            .color(Color.fromARGB(255, 0, 0, 0))
            .make(),
        elevation: 0.0,
        backgroundColor: Color.fromRGBO(240, 185, 11, 1),
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
            ),
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => LoginPage(
                          showRegisterPage: () {},
                        )),
              );
            },
          )
        ],
        iconTheme: IconThemeData(color: Colors.black54),
      ),
      drawer: AppDrawer(
        email: '',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
              future: client.getArticle(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Article>> snapshot) {
                //let's check if we got a response or not
                if (snapshot.hasData) {
                  //Now let's make a list of articles
                  List<Article>? articles = snapshot.data;
                  return SizedBox(
                    height: 350.0,
                    child: ListView.builder(
                      shrinkWrap: true,
                      //Now let's create our custom List tile
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) =>
                          customListTile(articles![index], context),
                    ),
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        //Connnect to screen 2
                        child: Column(
                          children: [
                            Text(
                              'Fixed Deposits',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color.fromRGBO(240, 185, 11, 1),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Rates',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color.fromRGBO(240, 185, 11, 1),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Fixedrates()));
                        },

                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(80, 85, 88, 1),
                          minimumSize: Size(110, 80),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                30), // Change this value to adjust the curve
                          ),
                        ),
                      ),
                      ElevatedButton(
                          //Connect to screen 3
                          child: Text(
                            'Stocks Market',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color.fromRGBO(240, 185, 11, 1),
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => stockview()));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(80, 85, 88, 1),
                            minimumSize: Size(110, 80),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  30), // Change this value to adjust the curve
                            ),
                          )),
                      ElevatedButton(
                        //Connected to Screen 4
                        child: Text(
                          'Crypto Market',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color.fromRGBO(240, 185, 11, 1),
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => cryptoview()));
                        },

                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(80, 85, 88, 1),
                          minimumSize: Size(110, 80),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                30), // Change this value to adjust the curve
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        //Connnect to screen 2
                        child: Text(
                          'Crypto View',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color.fromRGBO(240, 185, 11, 1),
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CryptoDataPage()));
                        },

                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(80, 85, 88, 1),
                          minimumSize: Size(200, 80),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                30), // Change this value to adjust the curve
                          ),
                        ),
                      ),
                      ElevatedButton(
                          //Connect to screen 3
                          child: Text(
                            'Stock view',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color.fromRGBO(240, 185, 11, 1),
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => StockDataPage()));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(80, 85, 88, 1),
                            minimumSize: Size(200, 80),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  30), // Change this value to adjust the curve
                            ),
                          )),
                    ],
                  ),
                  SizedBox(height: 20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        child: SizedBox(
                          child: Text(
                            'Expense Tracker',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color.fromRGBO(240, 185, 11, 1),
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeExpense()));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(80, 85, 88, 1),
                          minimumSize: Size(380, 80),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                30), // Change this value to adjust the curve
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        //Connected to screen 5
                        child: Text(
                          'Suggestions',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color.fromRGBO(240, 185, 11, 1),
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => InterestCalPage()));
                        },

                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(80, 85, 88, 1),
                          minimumSize: Size(380, 80),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                30), // Change this value to adjust the curve
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        child: Text(
                          'Interest Calculator',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color.fromRGBO(240, 185, 11, 1),
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Screen6()));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(80, 85, 88, 1),
                          minimumSize: Size(380, 80),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                30), // Change this value to adjust the curve
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        child: Text(
                          'Loan Calculator',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color.fromRGBO(240, 185, 11, 1),
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          /* Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Screen6()));*/
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(80, 85, 88, 1),
                          minimumSize: Size(380, 80),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                30), // Change this value to adjust the curve
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        child: Text(
                          'Bill payments',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color.fromRGBO(240, 185, 11, 1),
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          /* Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Screen6()));*/
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(80, 85, 88, 1),
                          minimumSize: Size(380, 80),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                30), // Change this value to adjust the curve
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
