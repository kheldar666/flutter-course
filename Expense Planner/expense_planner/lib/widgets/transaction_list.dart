import 'package:expense_planner/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  const TransactionList(this.transactions, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
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
              trailing: null,
            ),
          );
        },
        itemCount: transactions.length,
      ),
    );
  }
}
