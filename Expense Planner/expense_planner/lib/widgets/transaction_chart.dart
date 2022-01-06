import 'package:flutter/material.dart';

class TransactionChart extends StatelessWidget {
  const TransactionChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: double.infinity,
      child: Card(
        child: Text('Chart!'),
        elevation: 5,
        color: Colors.blue,
      ),
    );
  }
}
