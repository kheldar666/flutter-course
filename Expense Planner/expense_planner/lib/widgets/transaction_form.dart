import 'package:expense_planner/widgets/adaptive_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final Function(String, double, DateTime) callback;

  TransactionForm({
    Key? key,
    required this.callback,
  }) : super(key: key) {
    if (kDebugMode) {
      print('Constructor');
    }
  }

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();

  DateTime _txDate = DateTime.now();

  _TransactionFormState() {
    if (kDebugMode) {
      print('State Constructor');
    }
  }

  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      print('Init State');
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (kDebugMode) {
      print('Dispose State');
    }
  }

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
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
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
                  Expanded(
                    child: Text(_txDate == null
                        ? 'No Date Chosen!'
                        : 'Picked Date: ${DateFormat.yMMMd().format(_txDate ?? DateTime.now())}'),
                  ),
                  AdaptiveButton(
                      label: 'Choose Date', onPressed: _showDatePicker)
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
      ),
    );
  }
}
