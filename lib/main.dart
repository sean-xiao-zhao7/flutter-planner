import 'package:flutter/material.dart';
import 'package:planner/transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  // This widget is the root of your application.
  final List<Transaction> transactions = [
    Transaction(
      id: '1209kmaosdf',
      title: "Test",
      amount: 123,
      date: DateTime.now(),
    ),
    Transaction(
      id: '19ujafdas',
      title: "Test2",
      amount: 123,
      date: DateTime.now(),
    ),
    Transaction(
      id: '09as9djsaio',
      title: "Test3",
      amount: 123,
      date: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Planner'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Card(
                color: Colors.blue,
                child: Container(
                  width: double.infinity,
                  child: Text('Chart'),
                ),
                elevation: 5,
              ),
            ),
            Column(
              children: transactions.map((transaction) {
                return Card(
                    child: Row(children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2)),
                    padding: EdgeInsets.all(10),
                    child: Text(
                      transaction.amount.toString(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Text(transaction.title),
                      Text(transaction.date.toIso8601String()),
                    ],
                  ),
                ]));
              }).toList(),
            )
          ],
        ));
  }
}
