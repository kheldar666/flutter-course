import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final Function(String, double, DateTime) callback;

  const TransactionForm({
    Key? key,
    required this.callback,
  }) : super(key: key);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();

  DateTime? _txDate;

  void _showDatePicker() {
    var _today = DateTime.now();
    showDatePicker(
      context: context,
      initialDate: _today,
      firstDate: DateTime(_today.year),
      lastDate: _today,
    ).then((pickedDate) {
      if (pickedDate != null) {
        setState(() {
          _txDate = pickedDate;
        });
      }
    });
  }

  void _submitNewTx() {
    final enteredTitle = _titleController.text;
    final enteredAmount = _amountController.text;

    //Basic validation
    if (enteredTitle.isEmpty || enteredAmount.isEmpty || _txDate == null) {
      return;
    }

    try {
      widget.callback(enteredTitle, double.parse(enteredAmount), _txDate!);
      Navigator.of(context).pop();
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
              controller: _titleController,
              onSubmitted: (_) => //Use '_' to say we don't use the argument
                  _submitNewTx(), // must call the real function, not the pointer
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Amount'),
              controller: _amountController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => //Use '_' to say we don't use the argument
                  _submitNewTx(), // must call the real function, not the pointer
            ),
            SizedBox(
              height: 70,
              child: Row(children: [
                Text(_txDate == null
                    ? 'No Date Chosen!'
                    : DateFormat.yMMMd().format(_txDate ?? DateTime.now())),
                TextButton(
                  onPressed: _showDatePicker,
                  child: const Text('Choose Date'),
                  style: TextButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                    textStyle: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              ]),
            ),
            ElevatedButton(
              child: const Text('Add Transaction'),
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).primaryColor,
              ),
              onPressed: _submitNewTx,
            )
          ],
        ),
      ),
    );
  }
}
