import 'package:expense_planner/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  final Function(String id2Delete) deleteCallback;

  const TransactionList(this.transactions, this.deleteCallback, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: ListView.builder(
        itemBuilder: (ctx, index) {
          var tx = transactions[index];
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
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () {
                  deleteCallback(tx.id);
                },
              ),
            ),
          );
        },
        itemCount: transactions.length,
      ),
    );
  }
}
