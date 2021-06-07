import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './new_transaction.dart';
import './transactions_list.dart';
import '../models/transaction.dart';

class UserTransactions extends StatefulWidget {
  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  final List<Transaction> _userTransactions = [
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

  void _addTransaction(String txTitle, double txAmount) {
    final newTransaction = Transaction(
        title: txTitle,
        amount: txAmount,
        id: DateTime.now().toString(),
        date: DateTime.now());

    setState(() {
      _userTransactions.add(newTransaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        NewTransaction(_addTransaction),
        TransactionsList(_userTransactions),
      ],
    );
  }
}
