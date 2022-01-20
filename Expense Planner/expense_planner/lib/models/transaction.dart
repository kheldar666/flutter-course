import 'package:uuid/uuid.dart';

class Transaction {
  static const uuid = Uuid();
  final String id = uuid.v4().toString();
  final String title;
  final double amount;
  final DateTime date;

  Transaction({
    required this.title,
    required this.amount,
    required this.date,
  });

  static List<Transaction> sample() {
    return [
      Transaction(title: 'Tx 1', amount: 15, date: DateTime.now()),
      Transaction(
          title: 'Tx 2',
          amount: 20,
          date: DateTime.now().subtract(const Duration(days: 1))),
      Transaction(
          title: 'Tx 3',
          amount: 30,
          date: DateTime.now().subtract(const Duration(days: 2))),
      Transaction(
          title: 'Tx 4',
          amount: 45,
          date: DateTime.now().subtract(const Duration(days: 3))),
      Transaction(
          title: 'Tx 5',
          amount: 50,
          date: DateTime.now().subtract(const Duration(days: 5))),
      Transaction(
          title: 'Tx 6',
          amount: 15,
          date: DateTime.now().subtract(const Duration(days: 5))),
      Transaction(
          title: 'Tx 7',
          amount: 20,
          date: DateTime.now().subtract(const Duration(days: 6))),
      Transaction(
          title: 'Tx 8',
          amount: 35,
          date: DateTime.now().subtract(const Duration(days: 0))),
      Transaction(
          title: 'Tx 9',
          amount: 45,
          date: DateTime.now().subtract(const Duration(days: 1))),
    ];
  }
}
