import 'package:expense_planner/models/transaction.dart';
import 'package:expense_planner/widgets/transaction_card.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  final Function(String id2Delete) deleteCallback;

  final double height;

  const TransactionList(this.transactions, this.deleteCallback,
      {required this.height, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: transactions.isNotEmpty
          ?
          // There is a bug in ListView.builder making the Key ineffective
          // ListView.builder(
          //     itemBuilder: (context, index) {
          //       var tx = transactions[index];
          //       return TransactionCard(
          //         tx,
          //         onDelete: deleteCallback,
          //         key: ValueKey(tx.id.toString()),
          //       );
          //     },
          //     itemCount: transactions.length,
          //   )
          ListView(
              children: [
                ...transactions.map((tx) {
                  return TransactionCard(
                    tx,
                    onDelete: deleteCallback,
                    key: ValueKey(tx.id.toString()),
                  );
                }).toList()
              ],
            )
          : LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  children: [
                    Text(
                      'No transaction added yet !',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: constraints.maxHeight * 0.6,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                );
              },
            ),
    );
  }
}
