import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:velocity_x/velocity_x.dart';
import '../components/customListTile.dart';
import '../model/article_model.dart';
import '../services/api_service.dart';
import 'app_drawer.dart';
import 'expense_tracker/home_expense.dart';
import 'screen2/screen2.dart';
import 'screen3/screen3.dart';
import 'screen4/screen4.dart';
import 'screen5/screen5.dart';
import 'screen6/screen6.dart';

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
            .color(Colors.white)
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
                  ElevatedButton(
                    child: Text('Expense Tracker'),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeExpense()));
                    },
                  ),
                  ElevatedButton(
                    child: Text('Screen 2'),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Screen2()));
                    },
                  ),
                  ElevatedButton(
                    child: Text('Screen 3'),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Screen3()));
                    },
                  ),
                  ElevatedButton(
                    child: Text('Screen 4'),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Screen4()));
                    },
                  ),
                  ElevatedButton(
                    child: Text('Screen 5'),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Screen5()));
                    },
                  ),
                  ElevatedButton(
                    child: Text('Screen 6'),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Screen6()));
                    },
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
