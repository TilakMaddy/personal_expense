import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final titleController = TextEditingController(text: "");
  final amountController = TextEditingController(text: "");
  final Function tx;

  NewTransaction(this.tx);

  void submitData() {
    try {
      double.parse(amountController.text);
    } catch (e) {
      return;
    }
    if (titleController.text.isEmpty ||
        double.parse(amountController.text) <= 0) {
      return;
    }
    tx(
      titleController.text,
      double.parse(amountController.text),
    );
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
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
              onSubmitted: (_) => submitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => submitData(),
            ),
            TextButton(
              style: TextButton.styleFrom(primary: Colors.purple),
              onPressed: submitData,
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
