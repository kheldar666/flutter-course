import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

import '/models/cart_item.dart';

part 'order.g.dart';

@JsonSerializable(explicitToJson: true)
class Order {
  @JsonKey(ignore: true)
  late String id;
  final double amount;
  final List<CartItem> contents;
  late DateTime dateTime;
  Order({this.id = '', required this.amount, required this.contents}) {
    if (id.isEmpty) {
      id = const Uuid().v4().toString();
    }
    dateTime = DateTime.now();
  }

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);

  Future<http.Response> save(Uri ordersUrl) async {
    return await http.post(ordersUrl, body: json.encode(toJson()));
  }
}
