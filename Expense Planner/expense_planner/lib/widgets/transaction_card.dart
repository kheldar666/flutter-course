import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:expense_planner/models/transaction.dart';

class TransactionCard extends StatefulWidget {
  final Transaction tx;
  final Function(String id) onDelete;
  const TransactionCard(this.tx, {required this.onDelete, Key? key})
      : super(key: key);

  @override
  State<TransactionCard> createState() => _TransactionCardState();
}

class _TransactionCardState extends State<TransactionCard> {
  late Color _bgColor;
  @override
  void initState() {
    super.initState();
    const _availableColors = [
      Colors.purple,
      Colors.black,
      Colors.red,
      Colors.blue
    ];
    _bgColor = _availableColors[Random().nextInt(_availableColors.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      elevation: 6,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _bgColor,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: FittedBox(child: Text('\$${widget.tx.amount}')),
          ),
        ),
        title: Text(
          widget.tx.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(DateFormat.yMMMd().format(widget.tx.date)),
        trailing: MediaQuery.of(context).size.width > 360
            ? TextButton.icon(
                icon: const Icon(Icons.delete),
                label: const Text('Delete'),
                onPressed: () {
                  widget.onDelete(widget.tx.id);
                },
                style: TextButton.styleFrom(
                  primary: Theme.of(context).errorColor,
                ),
              )
            : IconButton(
                icon: const Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () {
                  widget.onDelete(widget.tx.id);
                },
              ),
      ),
    );
  }
}
