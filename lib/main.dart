import 'package:flutter/material.dart';
import './widgets/chart.dart';
import './widgets/new_transaction.dart';
import './models/transaction.dart';
import 'widgets/transaction_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amberAccent,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                // fontFamily: 'Quicksand',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 69.99,
      dateTime: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Weekly Groceries',
      amount: 16.53,
      dateTime: DateTime.now(),
    ),
    Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 69.99,
      dateTime: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Weekly Groceries',
      amount: 16.53,
      dateTime: DateTime.now(),
    ),
    Transaction(
      id: 't1',
      title: 'New Shoyyyes',
      amount: 69.99,
      dateTime: DateTime.now(),
    ),
    Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 69.99,
      dateTime: DateTime.now(),
    ),
  ];

  List<Transaction> get _recentTx {
    return _userTransactions
        .where(
          (tx) => DateTime.now()
              .subtract(
                Duration(days: 7),
              )
              .isBefore(tx.dateTime),
        )
        .toList();
  }

  void _addNewTransaction(String title, double amount) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      dateTime: DateTime.now(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void startAddNewTx() {
    print(_recentTx);
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return NewTransaction(_addNewTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Personal Expenses',
          style: AppBarTheme.of(context).textTheme!.headline6,
        ),
        actions: [
          IconButton(
            onPressed: () => startAddNewTx(),
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Chart(_recentTx),
            TransactionList(userTransactions: _userTransactions),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => startAddNewTx(),
        child: Icon(Icons.add),
        foregroundColor: Theme.of(context).primaryColorDark,
      ),
    );
  }
}
