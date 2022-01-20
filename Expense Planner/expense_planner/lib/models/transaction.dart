import 'package:uuid/uuid.dart';

class Transaction {
  static const uuid = Uuid();
  late final String id;
  final String title;
  final double amount;
  final DateTime date;

  Transaction({
    required this.title,
    required this.amount,
    required this.date,
  }) {
    id = uuid.v4().toString();
  }
}
