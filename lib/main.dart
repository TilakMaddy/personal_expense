import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import './widgets/chart.dart';
import './widgets/new_transaction.dart';
import './models/transaction.dart';
import 'widgets/transaction_list.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //   [
  //     DeviceOrientation.portraitDown,
  //     DeviceOrientation.portraitUp,
  //   ],
  // );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
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
      id: 't1fgdg',
      title: 'New Shoes',
      amount: 69.99,
      dateTime: DateTime.now(),
    ),
    Transaction(
      id: 'tetgeth2',
      title: 'Weekly Groceries',
      amount: 16.53,
      dateTime: DateTime.now(),
    ),
    Transaction(
      id: 't4te4y61',
      title: 'New Shoyyyes',
      amount: 69.99,
      dateTime: DateTime.now(),
    ),
    Transaction(
      id: 'tteyrey1',
      title: 'New Shoes',
      amount: 69.99,
      dateTime: DateTime.now(),
    ),
  ];
  bool _showChart = false;
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

  void _addNewTransaction(String title, double amount, DateTime chosenDate) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      dateTime: chosenDate,
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _deleteTx(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
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
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final chartFactor = isLandscape ? 0.7 : 0.3;
    final txListFactor = isLandscape ? 0.7 : (1 - 0.3);

    final appBar = AppBar(
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
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Show Chart'),
                  Switch(
                    value: _showChart,
                    onChanged: (val) {
                      setState(() {
                        _showChart = val;
                      });
                    },
                  ),
                ],
              ),
            if (!isLandscape || _showChart)
              Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    chartFactor,
                child: Chart(_recentTx),
              ),
            if (!isLandscape || !_showChart)
              Container(
                height: ( // device height
                        MediaQuery.of(context).size.height -

                            // app bar height
                            appBar.preferredSize.height -

                            // status bar height
                            MediaQuery.of(context).padding.top) *
                    txListFactor,
                child: TransactionList(
                  userTransactions: _userTransactions,
                  deleteTx: _deleteTx,
                ),
              ),
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
