import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:planner/widgets/chart.dart';
import 'package:planner/widgets/transactions_list.dart';
import './widgets/new_transaction.dart';
import '../models/transaction.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitDown,
  //   DeviceOrientation.portraitUp,
  // ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Planner',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          fontFamily: 'FiraSans',
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'FiraSans',
                  fontSize: 18,
                ),
                button: TextStyle(color: Colors.white),
              ),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                    fontFamily: 'FiraSans', fontSize: 22, color: Colors.white)),
          )),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // This widget is the root of your application.

  final List<Transaction> _userTransactions = [
    Transaction(
      id: '1209kmaosdf',
      title: "Test",
      amount: 123,
      date: DateTime.now().subtract(Duration(days: 1)),
    ),
    Transaction(
      id: '19ujafdas',
      title: "Test2",
      amount: 123,
      date: DateTime.now().subtract(Duration(days: 2)),
    ),
    Transaction(
      id: '09as9djsaio',
      title: "Test3",
      amount: 123,
      date: DateTime.now(),
    ),
    Transaction(
      id: '09as9djsaio',
      title: "Test3",
      amount: 123,
      date: DateTime.now().subtract(Duration(days: 1)),
    ),
    Transaction(
      id: '09as9djsaio',
      title: "Test3",
      amount: 123,
      date: DateTime.now().subtract(Duration(days: 2)),
    ),
    Transaction(
      id: '09as9djsaio',
      title: "Test3",
      amount: 123,
      date: DateTime.now().subtract(Duration(days: 3)),
    ),
    Transaction(
      id: '09as9djsaio',
      title: "Test3",
      amount: 123,
      date: DateTime.now().subtract(Duration(days: 1)),
    ),
  ];
  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((transaction) {
      return transaction.date
          .isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addTransaction(String txTitle, double txAmount, DateTime pickedDate) {
    final newTransaction = Transaction(
        title: txTitle,
        amount: txAmount,
        id: DateTime.now().toString(),
        date: pickedDate);

    setState(() {
      _userTransactions.add(newTransaction);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
    });
  }

  void _startNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final appBar = AppBar(
      title: Text('Planner'),
      actions: <Widget>[
        IconButton(
            onPressed: () {
              _startNewTransaction(context);
            },
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ))
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: SafeArea(
          child: SingleChildScrollView(
              child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // if (isLandscape)
          if (isLandscape)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Show chart', style: Theme.of(context).textTheme.title),
                Switch(
                  value: _showChart,
                  onChanged: (value) {
                    setState(() {
                      _showChart = value;
                    });
                  },
                ),
              ],
            ),
          _showChart
              ? Container(
                  height: (MediaQuery.of(context).size.height -
                          appBar.preferredSize.height -
                          MediaQuery.of(context).padding.top) *
                      0.7,
                  child: Chart(_recentTransactions))
              : Container(
                  height: (MediaQuery.of(context).size.height -
                          appBar.preferredSize.height -
                          MediaQuery.of(context).padding.top) *
                      0.7,
                  child:
                      TransactionsList(_userTransactions, _deleteTransaction)),
        ],
      ))),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            _startNewTransaction(context);
          }),
    );
  }
}
