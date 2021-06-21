import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function tx;

  NewTransaction(this.tx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  void submitData() {
    if (amountController.text.isEmpty) {
      return;
    }

    String titleText = titleController.text;
    double amount = double.parse(amountController.text);

    if (amount > 0 && titleText.isNotEmpty) {
      widget.tx(
        titleController.text,
        double.parse(amountController.text),
      );
      Navigator.of(context).pop();
    } else {
      print("Incorrect details entered!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              style: Theme.of(context).textTheme.headline6,
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
              onSubmitted: (_) => submitData(),
            ),
            TextField(
              style: Theme.of(context).textTheme.headline6,
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData(),
            ),
            TextButton(
              style: TextButton.styleFrom(
                primary: Theme.of(context).primaryColor,
              ),
              onPressed: () => submitData(),
              child: Text(
                'Add Transaction',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
