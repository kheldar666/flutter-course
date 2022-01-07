import 'package:flutter/material.dart';

class TransactionForm extends StatelessWidget {
  final Function(String, double) callback;

  TransactionForm({
    Key? key,
    required this.callback,
  }) : super(key: key);

  final titleController = TextEditingController();
  final amountController = TextEditingController();

  void _submitNewTx() {
    final enteredTitle = titleController.text;
    final enteredAmount = amountController.text;

    //Basic validation
    if (enteredTitle.isEmpty || enteredAmount.isEmpty) return;

    try {
      callback(enteredTitle, double.parse(enteredAmount));
      titleController.clear();
      amountController.clear();
    } on Exception catch (_) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              controller: titleController,
              onSubmitted: (_) =>
                  _submitNewTx, //Use '_' to say we don't use the argument
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) =>
                  _submitNewTx, //Use '_' to say we don't use the argument
            ),
            TextButton(
              child: const Text('Add Transaction'),
              style: TextButton.styleFrom(primary: Colors.purple),
              onPressed: _submitNewTx,
            )
          ],
        ),
      ),
    );
  }
}
