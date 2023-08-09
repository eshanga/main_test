// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:telephony/telephony.dart';
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
  TextEditingController namedata = TextEditingController();
  TextEditingController spentdata = TextEditingController();

  var isdateValid = false;
  DateTime date = DateTime.parse('2002-01-11');
  DateTime datechecker = DateTime.parse('2002-01-11');

  Future _selectDate(BuildContext context) async {
    final ThemeData customTheme = ThemeData(
      primaryColor: Colors.grey[700],
      hintColor: const Color.fromRGBO(240, 185, 11, 1),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.white),
        bodyMedium: TextStyle(color: Colors.white),
        labelLarge: TextStyle(color: Colors.white),
      ),
      colorScheme: const ColorScheme.dark(primary: Color.fromRGBO(240, 185, 11, 1)),
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
    const snackBar = SnackBar(
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
          color: Color(0xFF000000),
        )),
    const Item(
        'Rent',
        Icon(
          CupertinoIcons.house,
          color: Color(0xFF000000),
        )),
    const Item(
        'Entertainment',
        Icon(
          Icons.movie_creation_outlined,
          color: Color(0xFF000000),
        )),
    const Item(
        'Taxes',
        Icon(
          CupertinoIcons.money_dollar_circle,
          color: Color(0xFF000000),
        )),
    const Item(
        'Vehicle',
        Icon(
          CupertinoIcons.car_detailed,
          color: Color(0xFF000000),
        )),
    const Item(
        'Stationary',
        Icon(
          CupertinoIcons.pencil_outline,
          color: Color(0xFF000000),
        )),
    const Item(
        'Meal',
        Icon(
          Icons.fastfood_outlined,
          color: Color(0xFF000000),
        )),
    const Item(
        'Other',
        Icon(
          Icons.fact_check_outlined,
          color: Color(0xFF000000),
        )),
  ];
  String values = 'Other';

  @override
  Widget build(BuildContext context) {
    final userKey = FirebaseAuth.instance.currentUser;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(30, 35, 41, 1),
      resizeToAvoidBottomInset: false,
      drawer: const AppDrawer(
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
                  const SizedBox(
                    height: 30,
                  ),
                  "New Transaction"
                      .text
                      .xl2
                      .fontFamily('Helvetica')
                      .color(const Color.fromRGBO(240, 185, 11, 1))
                      .make(),
                  const SizedBox(
                    height: 2,
                  ),
                  "Track Your Expenses!"
                      .text
                      .xl2
                      .fontFamily('Helvetica')
                      .color(const Color.fromRGBO(255, 255, 255, 1))
                      .make(),
                  const SizedBox(
                    height: 25,
                  ),
                  const Divider(
                    color: Colors.grey,
                    indent: 0,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Form(
                    key: formKey,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          const SizedBox(
                            height: 14.0,
                          ),

                          // Title TextField
                          TextFormField(
                            controller: namedata,
                            style: const TextStyle(
                              color: Color.fromRGBO(240, 185, 11, 1),
                            ),
                            decoration: const InputDecoration(
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

                          const SizedBox(
                            height: 30.0,
                          ),

                          TextFormField(
                            controller: spentdata,
                            style: const TextStyle(
                              color: Color.fromRGBO(240, 185, 11, 1),
                            ),
                            decoration: const InputDecoration(
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

                          const SizedBox(
                            height: 30.0,
                          ),

                          Container(
                            margin: const EdgeInsets.all(2),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(26),
                              border: Border.all(color: Colors.grey, width: 1),
                              color: const Color.fromRGBO(59, 61, 63, 1),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                iconSize: 25,
                                hint: const Text("Select a Category"),
                                isExpanded: true,
                                value: values,
                                items: users.map((Item user) {
                                  return DropdownMenuItem(
                                    value: user.name,
                                    child: Row(
                                      children: [
                                        user.icon,
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          user.name,
                                          style: const TextStyle(color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    values = value.toString();
                                  });
                                },
                              ),
                            ),
                          ),

                          const SizedBox(
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
                                        border: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(25.0)),
                                        ),
                                        labelText: getText(),
                                        hintText: 'Date of Transaction',
                                        hintStyle: const TextStyle(
                                            color: Color.fromRGBO(
                                                240, 185, 11, 1)),
                                        fillColor:
                                            const Color.fromRGBO(48, 52, 56, 1),
                                        filled: true,
                                        prefixIcon: const Icon(Icons.calendar_today),
                                        suffixIcon: const Icon(Icons.arrow_drop_down),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(
                            height: 40.0,
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 55.0,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  side: const BorderSide(
                                    width: 1,
                                    color: Colors.black26,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  textStyle: const TextStyle(
                                    fontSize: 21.0,
                                  ),
                                  backgroundColor:
                                      const Color.fromRGBO(240, 185, 11, 1)),
                              child: const Text(
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

                          const SizedBox(
                            height: 20.0,
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 55.0,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  side: const BorderSide(
                                    width: 1,
                                    color: Colors.black26,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  textStyle: const TextStyle(
                                    fontSize: 21.0,
                                  ),
                                  backgroundColor:
                                      const Color.fromRGBO(240, 185, 11, 1)),
                              child: const Text(
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
                                    startOfCurrentDate.add(const Duration(days: 1));
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
                                  if (((message.address == "PeoplesBank" &&
                                              (message.body!
                                                      .contains("Billpay") ||
                                                  message.body!.contains(
                                                      "debited by"))) ||
                                          (message.address == "COMBANK" &&
                                              (message.body!.contains(
                                                      "Purchase at") ||
                                                  message.body!.contains(
                                                      "Withdrawal at")))) &&
                                      message.date != null &&
                                      DateTime.fromMillisecondsSinceEpoch(
                                              message.date!)
                                          .isAfter(startOfCurrentDate) &&
                                      DateTime.fromMillisecondsSinceEpoch(
                                              message.date!)
                                          .isBefore(endOfCurrentDate)) {
                                    RegExp regExp = RegExp(r"(\d+\.\d+)");
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
                                    String merchantName =
                                        filteredMessages[i]['name'];
                                    int amountInt = int.parse(
                                        filteredMessages[i]['amount']
                                            .split('.')[0]);
                                    String category;

                                    if (merchantName.contains('Pizza Hut') ||
                                        merchantName.contains('Dominos') ||
                                        merchantName.contains("McDonald's") ||
                                        merchantName.contains('KFC')) {
                                      category = 'Meal';
                                    } else if (merchantName
                                            .contains('Mobitel') ||
                                        merchantName.contains('Dialog') ||
                                        merchantName.contains('Hutch') ||
                                        merchantName.contains('Airtel') ||
                                        merchantName.contains('Savoy') ||
                                        merchantName
                                            .contains('Scope Cinemas')) {
                                      category = 'Entertainment';
                                    } else {
                                      category = 'Other';
                                    }

                                    Map<String, dynamic> data = {
                                      "name": "Bank transactions",
                                      "spent": amountInt,
                                      "category": category,
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
                                          const Text('No matching messages found!'),
                                      content: const Text(
                                          'There are no bank transactions in your messages.'),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('OK'),
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
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
