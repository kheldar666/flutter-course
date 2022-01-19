import 'package:expense_planner/models/transaction.dart';
import 'package:expense_planner/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionChart extends StatelessWidget {
  const TransactionChart(this.recentTransactions, {Key? key}) : super(key: key);

  final List<Transaction> recentTransactions;

  double get maxSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      double amount = item['amount'] as double;
      return sum + amount;
    });
  }

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0;
      for (var transaction in recentTransactions) {
        if (transaction.date.day == weekDay.day &&
            transaction.date.month == weekDay.month &&
            transaction.date.year == weekDay.year) {
          totalSum += transaction.amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    }).reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      child: Card(
        elevation: 6,
        margin: const EdgeInsets.all(20),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ...groupedTransactionValues.map((data) {
                return Flexible(
                  fit: FlexFit.tight,
                  child: ChartBar(
                    label: data['day'] as String,
                    spendingAmount: data['amount'] as double,
                    spendingPctOfTotal: maxSpending > 0
                        ? (data['amount'] as double) / maxSpending
                        : 0,
                  ),
                );
              }).toList()
            ],
          ),
        ),
      ),
    );
  }
}
