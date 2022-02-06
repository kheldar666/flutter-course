// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderItemFromJson(Map<String, dynamic> json) => Order(
      amount: (json['amount'] as num).toDouble(),
      contents: (json['contents'] as List<dynamic>)
          .map((e) => CartItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    )..dateTime = DateTime.parse(json['dateTime'] as String);

Map<String, dynamic> _$OrderItemToJson(Order instance) => <String, dynamic>{
      'amount': instance.amount,
      'contents': instance.contents.map((e) => e.toJson()).toList(),
      'dateTime': instance.dateTime.toIso8601String(),
    };
