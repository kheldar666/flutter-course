import 'package:expense_planner/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionCard extends StatelessWidget {
  final Transaction tx;
  final Function(String id) onDelete;
  const TransactionCard(this.tx, {required this.onDelete, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      elevation: 6,
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: FittedBox(child: Text('\$${tx.amount}')),
          ),
        ),
        title: Text(
          tx.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(DateFormat.yMMMd().format(tx.date)),
        trailing: MediaQuery.of(context).size.width > 360
            ? TextButton.icon(
                icon: const Icon(Icons.delete),
                label: const Text('Delete'),
                onPressed: () {
                  onDelete(tx.id);
                },
                style: TextButton.styleFrom(
                  primary: Theme.of(context).errorColor,
                ),
              )
            : IconButton(
                icon: const Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () {
                  onDelete(tx.id);
                },
              ),
      ),
    );
  }
}
