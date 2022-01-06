import 'package:expense_planner/widgets/transaction_chart.dart';
import 'package:expense_planner/widgets/user_transactions.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Planner'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            TransactionChart(),
            UserTransactions(),
          ],
        ),
      ),
    );
  }
}
