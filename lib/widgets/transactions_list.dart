import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:planner/models/transaction.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> userTransactions;

  TransactionsList(this.userTransactions);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 400,
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Card(
                child: Row(children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).primaryColor, width: 2)),
                padding: EdgeInsets.all(10),
                child: Text(
                  '\$ ${userTransactions[index].amount.toString()}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.purple),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    userTransactions[index].title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black87),
                  ),
                  Text(
                    DateFormat('yyyy-mm-dd')
                        .format(userTransactions[index].date),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black45),
                  ),
                ],
              ),
            ]));
          },
          itemCount: userTransactions.length,
          // children: userTransactions.map((transaction) {
          //   return null;
          // }).toList(),
        ));
  }
}
