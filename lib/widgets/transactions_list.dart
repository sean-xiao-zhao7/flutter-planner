import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:planner/models/transaction.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> userTransactions;
  final Function deleteTransaction;

  TransactionsList(this.userTransactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: userTransactions.isEmpty
            ? Column(
                children: <Widget>[
                  Text('No transactions.',
                      style: Theme.of(context).textTheme.title),
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                    height: 362,
                    child: Image.asset(
                      'assets/images/1.jpg',
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              )
            : ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: FittedBox(
                            child: Text(
                              '\$ ${userTransactions[index].amount.toString()}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        userTransactions[index].title,
                        style: Theme.of(context).textTheme.title,
                      ),
                      subtitle: Text(
                        DateFormat.yMMMd().format(userTransactions[index].date),
                        style: Theme.of(context).textTheme.title,
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        color: Theme.of(context).errorColor,
                        onPressed: () =>
                            deleteTransaction(userTransactions[index].id),
                      ),
                    ),
                  );
                },
                itemCount: userTransactions.length,
                // children: userTransactions.map((transaction) {
                //   return null;
                // }).toList(),
              ));
  }
}
