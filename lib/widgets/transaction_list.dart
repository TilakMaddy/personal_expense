import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransactions;

  TransactionList({required this.userTransactions});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      child: userTransactions.isEmpty
          ? Column(
              children: [
                Text(
                  "No transaction added yet !",
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(height: 20),
                Container(
                  height: 200,
                  child: Image.asset(
                    'assets/image/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemCount: userTransactions.length,
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: FittedBox(
                          child: Text('\$${userTransactions[index].amount}'),
                        ),
                      ),
                    ),
                    title: Text(
                      userTransactions[index].title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd()
                          .format(userTransactions[index].dateTime),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
