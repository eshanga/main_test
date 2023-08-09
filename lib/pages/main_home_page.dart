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
<<<<<<< Updated upstream
import 'screen2/screen2.dart';
import 'screen3/screen3.dart';
import 'screen4/screen4.dart';
import 'screen5/screen5.dart';
import 'screen6/screen6.dart';
=======
import 'Suggestions/SuggestionsPage.dart';
import 'InterestCalculator/InterestCalculatorPage.dart';
>>>>>>> Stashed changes
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
      backgroundColor: const Color.fromRGBO(30, 35, 41, 1),
      appBar: AppBar(
        title: "Homescreen"
            .text
            .xl2
            .fontFamily('Helvetica')
            .color(const Color.fromARGB(255, 0, 0, 0))
            .make(),
        elevation: 0.0,
        backgroundColor: const Color.fromRGBO(240, 185, 11, 1),
        actions: [
          IconButton(
            icon: const Icon(
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
        iconTheme: const IconThemeData(color: Colors.black54),
      ),
      drawer: const AppDrawer(
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
                return const Center(
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
                      //Button for Fixed rate deposite
                      ElevatedButton(
                        //Connnect to screen 2
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Fixedrates()));
                        },

                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(80, 85, 88, 1),
                          minimumSize: const Size(110, 80),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                30), // Change this value to adjust the curve
                          ),
                        ),
                        //Defining the button content
                        child: const Column(
                          children: [
                            Text(
                              'Fixed Deposit',
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
                      ),

                      //Button for Stock market
                      ElevatedButton(
                          //Connect to screen 3
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const stockview()));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(80, 85, 88, 1),
                            minimumSize: const Size(110, 80),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  30), // Change this value to adjust the curve
                            ),
                          ),
                          //Defining th button context
                          child: const Text(
                            'Stocks Market',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color.fromRGBO(240, 185, 11, 1),
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          )),
                    ],
                  ),

                  //Keeping space
                  const SizedBox(height: 20),
                  //Move to the next row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //Button for crypto view
                      ElevatedButton(
                        //Connected to Screen 4
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const cryptoview()));
                        },

                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(80, 85, 88, 1),
                          minimumSize: const Size(110, 80),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                30), // Change this value to adjust the curve
                          ),
                        ),
                        //Defining the button context
                        child: const Text(
                          'Crypto Market',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color.fromRGBO(240, 185, 11, 1),
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),

                      //Defining the button for the Crypto view
                      ElevatedButton(
                        //Connnect to screen 2
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const CryptoDataPage()));
                        },

                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(80, 85, 88, 1),
                          minimumSize: const Size(200, 80),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                30), // Change this value to adjust the curve
                          ),
                        ),
                        //Defining the button
                        child: const Text(
                          'Crypto View',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color.fromRGBO(240, 185, 11, 1),
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
<<<<<<< Updated upstream
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => cryptoview()));
                        },

                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(80, 85, 88, 1),
                          minimumSize: Size(200, 80),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                30), // Change this value to adjust the curve
                          ),
                        ),
=======
>>>>>>> Stashed changes
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //Button for the stock view
                      ElevatedButton(
                          //Connect to screen 3
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const StockDataPage()));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(80, 85, 88, 1),
                            minimumSize: const Size(200, 80),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  30), // Change this value to adjust the curve
                            ),
                          ),
                          //Defining the button content
                          child: const Text(
                            'Stock view',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color.fromRGBO(240, 185, 11, 1),
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
<<<<<<< Updated upstream
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => stockview()));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(80, 85, 88, 1),
                            minimumSize: Size(200, 80),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  30), // Change this value to adjust the curve
                            ),
=======
>>>>>>> Stashed changes
                          )),

                      //Button for the Expense tracker
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomeExpense()));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(80, 85, 88, 1),
                          minimumSize: const Size(200, 80),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                30), // Change this value to adjust the curve
                          ),
                        ),
                        child: const SizedBox(
                          child: Text(
                            'Expense Tracker',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color.fromRGBO(240, 185, 11, 1),
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //Button for the suggestions
                      ElevatedButton(
                        //Connected to screen 5
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const SuggestionsPage()));
                        },

                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(80, 85, 88, 1),
                          minimumSize: const Size(200, 80),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                30), // Change this value to adjust the curve
                          ),
                        ),
                        //Connected to screen 5
                        child: const Text(
                          'Suggestions',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color.fromRGBO(240, 185, 11, 1),
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 20),

                      //Button for the interest calcultor
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
<<<<<<< Updated upstream
                                  builder: (context) => Screen5()));
=======
                                  builder: (context) =>
                                      const InterestCalPage()));
>>>>>>> Stashed changes
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(80, 85, 88, 1),
                          minimumSize: const Size(200, 80),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                30), // Change this value to adjust the curve
                          ),
                        ),
                        child: const Text(
                          'Interest Calculator',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color.fromRGBO(240, 185, 11, 1),
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //Button for the loan calculator
                      ElevatedButton(
                        onPressed: () {
                          /* Navigator.push(
                              context,
                              MaterialPageRoute(
<<<<<<< Updated upstream
                                  builder: (context) => Screen6()));
=======
                                  builder: (context) => Screen6()));*/
>>>>>>> Stashed changes
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(80, 85, 88, 1),
                          minimumSize: const Size(200, 80),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                30), // Change this value to adjust the curve
                          ),
                        ),
                        child: const Text(
                          'Loan Calculator',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color.fromRGBO(240, 185, 11, 1),
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 20),

                      //button for bill payment
                      ElevatedButton(
                        onPressed: () {
                          /* Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Screen6()));*/
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(80, 85, 88, 1),
                          minimumSize: const Size(200, 80),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                30), // Change this value to adjust the curve
                          ),
                        ),
                        child: const Text(
                          'Bill payments',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color.fromRGBO(240, 185, 11, 1),
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
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
