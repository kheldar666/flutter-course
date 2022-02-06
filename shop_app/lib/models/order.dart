import 'package:json_annotation/json_annotation.dart';
import 'package:shop_app/models/cart_item.dart';
import 'package:uuid/uuid.dart';

part 'order.g.dart';

@JsonSerializable(explicitToJson: true)
class Order {
  @JsonKey(ignore: true)
  late String id;
  final double amount;
  final List<CartItem> contents;
  late final DateTime dateTime;
  Order({
    this.id = '',
    required this.amount,
    required this.contents,
  }) {
    if (id.isEmpty) {
      id = const Uuid().v4().toString();
    }
    dateTime = DateTime.now();
  }

  factory Order.fromJson(Map<String, dynamic> json) =>
      _$OrderItemFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemToJson(this);
}
