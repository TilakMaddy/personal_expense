import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './chart_bar.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTxVals {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      var totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; ++i) {
        var txd = recentTransactions[i].dateTime;

        if (txd.day == weekDay.day &&
            txd.month == weekDay.month &&
            txd.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }

      var item = {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };

      return item;
    }).reversed.toList();
  }

  double get maxspending {
    double max = 0;
    groupedTxVals.forEach((e) {
      if (e['amount'] as double > max) {
        max = e['amount'] as double;
      }
    });
    return max;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 6,
        margin: EdgeInsets.all(20),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTxVals.map((tx) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                    label: tx['day'] as String,
                    spendPercent: maxspending == 0.0
                        ? 0.0
                        : (tx['amount'] as double) / maxspending,
                    spendingAmt: (tx['amount'] as double)),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
