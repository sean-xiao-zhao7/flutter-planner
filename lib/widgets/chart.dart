import 'package:flutter/material.dart';
import 'package:planner/models/transaction.dart';
import 'package:intl/intl.dart';
import 'package:planner/widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionsValues {
    return List.generate(7, (index) {
      var weekday = DateTime.now().subtract(
        Duration(days: index),
      );
      double totalAmount = 0;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekday.day &&
            recentTransactions[i].date.month == weekday.month &&
            recentTransactions[i].date.year == weekday.year) {
          totalAmount += recentTransactions[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekday),
        'amount': totalAmount,
      };
    }).reversed.toList();
  }

  double get getPercentAmount {
    return groupedTransactionsValues.fold(0.0, (sum, element) {
      return sum + element['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionsValues.map((data) {
            return Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: ChartBar(
                data['day'],
                data['amount'],
                getPercentAmount == 0.0
                    ? 0.0
                    : (data['amount'] as double) / getPercentAmount,
              ),
            );
          }).toList(),
        ),
      ),
    ));
  }
}
