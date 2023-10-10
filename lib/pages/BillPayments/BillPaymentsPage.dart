import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class BillPaymentScreen extends StatefulWidget {
  @override
  _BillPaymentScreenState createState() => _BillPaymentScreenState();
}

class _BillPaymentScreenState extends State<BillPaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  final _dateController = TextEditingController();
  bool _isRecurring = false;
  final _currentUser = FirebaseAuth.instance.currentUser;

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bill Payments'),
        backgroundColor: Color.fromRGBO(240, 185, 11, 1),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('billPayments')
                  .where('userId', isEqualTo: _currentUser!.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var data = snapshot.data!.docs[index].data()
                        as Map<String, dynamic>;
                    return ListTile(
                      title: Text(
                        data['name']!,
                        style: TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        '\Rs. ${data['amount']}',
                        style: TextStyle(color: Colors.white),
                      ),
                      trailing: Text(
                        data['isRecurring'] ? 'Monthly' : 'One-time',
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        _nameController.text = data['name']!;
                        _amountController.text = data['amount']!.toString();
                        _dateController.text = data['date']!;
                        _isRecurring = data['isRecurring']!;
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: Color.fromRGBO(30, 35, 41, 1),
                              title: Text(
                                'Edit Bill Payment',
                                style: TextStyle(color: Colors.white),
                              ),
                              content: Form(
                                key: _formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextFormField(
                                      controller: _nameController,
                                      decoration: InputDecoration(
                                        labelText: 'Name',
                                        labelStyle:
                                            TextStyle(color: Colors.grey),
                                      ),
                                      style: TextStyle(color: Colors.white),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter a name';
                                        }
                                        return null;
                                      },
                                    ),
                                    TextFormField(
                                      controller: _amountController,
                                      decoration: InputDecoration(
                                        labelText: 'Average Amount',
                                        labelStyle:
                                            TextStyle(color: Colors.grey),
                                      ),
                                      style: TextStyle(color: Colors.white),
                                      keyboardType: TextInputType.number,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter an amount';
                                        }
                                        return null;
                                      },
                                    ),
                                    TextFormField(
                                      controller: _dateController,
                                      decoration: InputDecoration(
                                        labelText: 'Date to be paid',
                                        labelStyle:
                                            TextStyle(color: Colors.grey),
                                      ),
                                      style: TextStyle(color: Colors.white),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter a date';
                                        }
                                        return null;
                                      },
                                    ),
                                    CheckboxListTile(
                                      title: Text(
                                        'Monthly recurring payment',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      value: _isRecurring,
                                      onChanged: (value) {
                                        setState(() {
                                          _isRecurring = value!;
                                        });
                                      },
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                      activeColor:
                                          Color.fromRGBO(240, 185, 11, 1),
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Color.fromRGBO(
                                        240, 185, 11, 1), // Set button color
                                  ),
                                  child: Text('Cancel',
                                      style: TextStyle(
                                          color:
                                              Colors.white)), // Set font color
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Color.fromRGBO(
                                        240, 185, 11, 1), // Set button color
                                  ),
                                  child: Text('Save',
                                      style: TextStyle(
                                          color:
                                              Colors.white)), // Set font color
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      FirebaseFirestore.instance
                                          .collection('billPayments')
                                          .doc(snapshot.data!.docs[index].id)
                                          .update({
                                        'name': _nameController.text,
                                        'amount': double.parse(
                                            _amountController.text),
                                        'date': _dateController.text,
                                        'isRecurring': _isRecurring,
                                      });
                                      Navigator.of(context).pop();
                                    }
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                Color.fromRGBO(240, 185, 11, 1),
              ),
            ),
            child: Text(
              'Add New Bill Payment',
              style: TextStyle(color: Colors.black),
            ),
            onPressed: () {
              _nameController.clear();
              _amountController.clear();
              _dateController.clear();
              _isRecurring = false;
              showDialog(
                barrierColor: Colors.black.withOpacity(0.6),
                context: context,
                builder: (context) {
                  return Theme(
                    data: Theme.of(context).copyWith(
                      dialogBackgroundColor: Color.fromRGBO(30, 35, 41, 1),
                    ),
                    child: AlertDialog(
                      title: Text(
                        'Add New Bill Payment',
                        style: TextStyle(color: Colors.white),
                      ),
                      content: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              controller: _nameController,
                              decoration: InputDecoration(
                                labelText: 'Name',
                                labelStyle: TextStyle(color: Colors.grey),
                              ),
                              style: TextStyle(color: Colors.white),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a name';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: _amountController,
                              decoration: InputDecoration(
                                labelText: 'Average Amount',
                                labelStyle: TextStyle(color: Colors.grey),
                              ),
                              style: TextStyle(color: Colors.white),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter an amount';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: _dateController,
                              decoration: InputDecoration(
                                labelText: 'Date to be paid',
                                labelStyle: TextStyle(color: Colors.grey),
                              ),
                              style: TextStyle(color: Colors.white),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a date';
                                }
                                return null;
                              },
                            ),
                            CheckboxListTile(
                              title: Text(
                                'Monthly recurring payment',
                                style: TextStyle(color: Colors.white),
                              ),
                              value: _isRecurring,
                              onChanged: (value) {
                                setState(() {
                                  _isRecurring = value!;
                                });
                              },
                              controlAffinity: ListTileControlAffinity.leading,
                              activeColor: Color.fromRGBO(240, 185, 11, 1),
                            ),
                          ],
                        ),
                      ),
                      actions: [
                        ElevatedButton(
                          child: Text('Cancel'),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Color.fromRGBO(240, 185, 11, 1),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        ElevatedButton(
                          child: Text('Save'),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Color.fromRGBO(240, 185, 11, 1),
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              FirebaseFirestore.instance
                                  .collection('billPayments')
                                  .add({
                                'userId': _currentUser!.uid,
                                'name': _nameController.text,
                                'amount': double.parse(_amountController.text),
                                'date': _dateController.text,
                                'isRecurring': _isRecurring,
                              });
                              Navigator.of(context).pop();
                            }
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
          SizedBox(height: 30),
        ],
      ),
      backgroundColor: Color.fromRGBO(30, 35, 41, 1),
    );
  }
}
