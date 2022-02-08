import 'package:json_annotation/json_annotation.dart';
import '/providers/product.dart';
import 'package:uuid/uuid.dart';

part 'cart_item.g.dart';

@JsonSerializable(explicitToJson: true)
class CartItem {
  @JsonKey(ignore: true)
  late String _id;
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1}) {
    _id = const Uuid().v4().toString();
  }

  String get id => _id;

  factory CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);

  Map<String, dynamic> toJson() => _$CartItemToJson(this);
}
