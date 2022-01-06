import 'package:flutter/material.dart';

class TransactionForm extends StatelessWidget {
  final Function(String, String) callback;

  TransactionForm({
    Key? key,
    required this.callback,
  }) : super(key: key);

  final titleController = TextEditingController();
  final amountController = TextEditingController();

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
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Amount'),
              controller: amountController,
            ),
            TextButton(
              child: const Text('Add Transaction'),
              style: TextButton.styleFrom(primary: Colors.purple),
              onPressed: () {
                callback(titleController.text, amountController.text);
                titleController.clear();
                amountController.clear();
              },
            )
          ],
        ),
      ),
    );
  }
}
