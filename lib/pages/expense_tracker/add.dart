// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
//import 'package:telephony/telephony.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../app_drawer.dart';

class Item {
  const Item(this.name, this.icon);
  final String name;
  final Icon icon;
}

class Add extends StatefulWidget {
  const Add({Key? key}) : super(key: key);

  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  final formKey = GlobalKey<FormState>();
  TextEditingController namedata = new TextEditingController();
  TextEditingController spentdata = new TextEditingController();

  var isdateValid = false;
  DateTime date = DateTime.parse('2002-01-11');
  DateTime datechecker = DateTime.parse('2002-01-11');

  Future _selectDate(BuildContext context) async {
    final ThemeData customTheme = ThemeData(
      primaryColor: Colors.grey[700],
      accentColor: Color.fromRGBO(240, 185, 11, 1),
      textTheme: TextTheme(
        bodyText1: TextStyle(color: Colors.white),
        bodyText2: TextStyle(color: Colors.white),
        button: TextStyle(color: Colors.white),
      ),
      colorScheme: ColorScheme.dark(primary: Color.fromRGBO(240, 185, 11, 1)),
    );
    final today = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: date == datechecker ? today : date,
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: today,
    );
    if (pickedDate == null) {
      return;
    }
    setState(() {
      date = pickedDate;
    });
  }

  String getText() {
    if (date == datechecker) {
      isdateValid = false;
      return 'Date';
    } else {
      isdateValid = true;
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  void showSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text(
        'Transaction Added',
        style: TextStyle(fontSize: 14, color: Colors.white),
        textAlign: TextAlign.center,
      ),
      backgroundColor: Colors.grey,
      duration: Duration(seconds: 1),
      shape: StadiumBorder(),
      behavior: SnackBarBehavior.floating,
      elevation: 0.0,
      width: 200,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  final users = [
    const Item(
        'Education',
        Icon(
          Icons.book_outlined,
          color: const Color(0xFF000000),
        )),
    const Item(
        'Rent',
        Icon(
          CupertinoIcons.house,
          color: const Color(0xFF000000),
        )),
    const Item(
        'Entertainment',
        Icon(
          Icons.movie_creation_outlined,
          color: const Color(0xFF000000),
        )),
    const Item(
        'Taxes',
        Icon(
          CupertinoIcons.money_dollar_circle,
          color: const Color(0xFF000000),
        )),
    const Item(
        'Vehicle',
        Icon(
          CupertinoIcons.car_detailed,
          color: const Color(0xFF000000),
        )),
    const Item(
        'Stationary',
        Icon(
          CupertinoIcons.pencil_outline,
          color: const Color(0xFF000000),
        )),
    const Item(
        'Meal',
        Icon(
          Icons.fastfood_outlined,
          color: const Color(0xFF000000),
        )),
    const Item(
        'Other',
        Icon(
          Icons.fact_check_outlined,
          color: const Color(0xFF000000),
        )),
  ];
  String values = 'Other';

  @override
  Widget build(BuildContext context) {
    final userKey = FirebaseAuth.instance.currentUser;
    return Scaffold(
      backgroundColor: Color.fromRGBO(30, 35, 41, 1),
      resizeToAvoidBottomInset: false,
      drawer: AppDrawer(
        email: '',
      ),
      body: Builder(
        builder: (context) => SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: Vx.m12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  "New Transaction"
                      .text
                      .xl2
                      .fontFamily('Helvetica')
                      .color(Color.fromRGBO(240, 185, 11, 1))
                      .make(),
                  SizedBox(
                    height: 2,
                  ),
                  "Track Your Expenses!"
                      .text
                      .xl2
                      .fontFamily('Helvetica')
                      .color(Color.fromRGBO(255, 255, 255, 1))
                      .make(),
                  SizedBox(
                    height: 25,
                  ),
                  Divider(
                    color: Colors.grey,
                    indent: 0,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Form(
                    key: formKey,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          SizedBox(
                            height: 14.0,
                          ),

                          // Title TextField
                          TextFormField(
                            controller: namedata,
                            style: const TextStyle(
                              color: Color.fromRGBO(240, 185, 11, 1),
                            ),
                            decoration: InputDecoration(
                              labelText: 'Title',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(240, 185, 11, 1)),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25.0)),
                              ),
                              prefixIcon: Icon(Icons.title),
                              hintText: "Enter a title",
                              hintStyle: TextStyle(
                                  color: Color.fromRGBO(240, 185, 11, 1)),
                              fillColor: Color.fromRGBO(59, 61, 63, 1),
                              filled: true,
                            ),
                            validator: (value) {
                              if (value == null) {
                                return "Please fill this field";
                              } else if (value.length < 2) {
                                return "Please enter valid title";
                              } else {
                                return null;
                              }
                            },
                          ),

                          SizedBox(
                            height: 30.0,
                          ),

                          TextFormField(
                            controller: spentdata,
                            style: const TextStyle(
                              color: Color.fromRGBO(240, 185, 11, 1),
                            ),
                            decoration: InputDecoration(
                              labelText: 'Amount',
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25.0)),
                              ),
                              prefixIcon: Icon(Icons.local_atm),
                              hintText: "Enter the amount",
                              hintStyle: TextStyle(
                                  color: Color.fromRGBO(240, 185, 11, 1)),
                              fillColor: Color.fromRGBO(59, 61, 63, 1),
                              filled: true,
                            ),
                            validator: (value) {
                              if (value == null) {
                                return "Please fill this field";
                              } else if (int.parse(value) <= 0) {
                                return "Enter Valid Amount";
                              }
                              return null;
                            },
                          ),

                          SizedBox(
                            height: 30.0,
                          ),

                          Container(
                            margin: EdgeInsets.all(2),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(26),
                              border: Border.all(color: Colors.grey, width: 1),
                              color: Color.fromRGBO(59, 61, 63, 1),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                iconSize: 25,
                                hint: Text("Select a Category"),
                                isExpanded: true,
                                value: values,
                                items: users.map((Item user) {
                                  return DropdownMenuItem(
                                    value: user.name,
                                    child: Row(
                                      children: [
                                        user.icon,
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          user.name,
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    this.values = value.toString();
                                  });
                                },
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 30.0,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              // Date TextField
                              Flexible(
                                fit: FlexFit.loose,
                                child: GestureDetector(
                                  onTap: () => _selectDate(context),
                                  child: AbsorbPointer(
                                    child: TextFormField(
                                      keyboardType: TextInputType.datetime,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(25.0)),
                                        ),
                                        labelText: getText(),
                                        hintText: 'Date of Transaction',
                                        hintStyle: TextStyle(
                                            color: Color.fromRGBO(
                                                240, 185, 11, 1)),
                                        fillColor:
                                            Color.fromRGBO(48, 52, 56, 1),
                                        filled: true,
                                        prefixIcon: Icon(Icons.calendar_today),
                                        suffixIcon: Icon(Icons.arrow_drop_down),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(
                            height: 40.0,
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 55.0,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                    width: 1,
                                    color: Colors.black26,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  textStyle: TextStyle(
                                    fontSize: 21.0,
                                  ),
                                  backgroundColor:
                                      Color.fromRGBO(240, 185, 11, 1)),
                              child: Text(
                                'Add Transaction',
                                style: TextStyle(
                                  fontFamily: 'Helvetica',
                                  color: Colors.black,
                                ),
                              ),
                              onPressed: () {
                                final isValid =
                                    formKey.currentState!.validate();

                                if (isValid && isdateValid) {
                                  Map<String, dynamic> data = {
                                    "name": namedata.text,
                                    "spent": int.parse(spentdata.text),
                                    "category": values,
                                    "date": date
                                  };
                                  FirebaseFirestore.instance
                                      .collection(userKey!.email!)
                                      .add(data);
                                  showSnackBar(context);
                                  namedata.clear();
                                  spentdata.clear();
                                  values = "Select a Category";
                                  date = DateTime.parse('2002-01-11');
                                  // Navigator.pushNamed(
                                  //     context, MyRoutes.homeRoute);
                                }
                              },
                            ),
                          ),

                          /*               SizedBox(
                            height: 20.0,
                          ),
                          SizedBox(
                          width: double.infinity,
                        height: 55.0,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                    width: 1,
                                    color: Colors.black26,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  textStyle: TextStyle(
                                    fontSize: 21.0,
                                  ),
                                  backgroundColor:
                                      Color.fromRGBO(240, 185, 11, 1)),
                              child: Text(
                                'Add your bank Transactions',
                                style: TextStyle(
                                  fontFamily: 'Helvetica',
                                  color: Colors.black,
                                ),
                              ),
                              onPressed: () async {
                                final telephony = Telephony.instance;
                               DateTime currentDate = DateTime.now();
                               DateTime startOfCurrentDate = DateTime(
                                    currentDate.year,
                                    currentDate.month,
                                    currentDate.day);
                                DateTime endOfCurrentDate =
                                    startOfCurrentDate.add(Duration(days: 1));
                               List<SmsMessage> allMessages =
                                    await telephony.getInboxSms(
                                  columns: [
                                    SmsColumn.ADDRESS,
                                    SmsColumn.BODY,
                                    SmsColumn.DATE
                                 ],
                                );
                                List<Map<String, dynamic>> filteredMessages =
                                    [];
                                for (SmsMessage message in allMessages) {
                                  if (message.address == "PeoplesBank" &&
                                      (message.body!.contains("Billpay") ||
                                          message.body!
                                              .contains("debited by")) &&
                                      message.date != null &&
                                      DateTime.fromMillisecondsSinceEpoch(
                                              message.date!)
                                          .isAfter(startOfCurrentDate) &&
                                      DateTime.fromMillisecondsSinceEpoch(
                                              message.date!)
                                    .isBefore(endOfCurrentDate)) {
                                    RegExp regExp = new RegExp(r"(\d+\.\d+)");
                                    Match? match =
                                        regExp.firstMatch(message.body!);
                                    if (match != null) {
                                      String amount = match.group(0)!;
                                      filteredMessages.add({
                                        'message': message.body!,
                                        'amount': amount,
                                        'date': message.date
                                      });
                                    }
                                  }
                                }

                                if (filteredMessages.isNotEmpty) {
                                  for (var i = 0;
                                      i < filteredMessages.length;
                                      i++) {
                                    int amountInt = int.parse(
                                        filteredMessages[i]['amount']
                                            .split('.')[0]);
                                    Map<String, dynamic> data = {
                                      "name": "Bank transactions",
                                      "spent": amountInt,
                                      "category": "other",
                                      "date": DateTime.now(),
                                    };
                                    FirebaseFirestore.instance
                                        .collection(userKey!.email!)
                                        .add(data);
                                  }
                                  filteredMessages.removeRange(
                                      0, filteredMessages.length);
                                  showSnackBar(context);
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title:
                                          Text('No matching messages found!'),
                                      content: Text(
                                          'There are no bank transactions in your messages.'),
                                      actions: <Widget>[
                                        TextButton(
                                          child: Text('OK'),
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              },
                            ),
                          ),*/
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
