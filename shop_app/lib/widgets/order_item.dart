import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/models/order.dart';

class OrderItem extends StatefulWidget {
  final Order order;
  const OrderItem(this.order, {Key? key}) : super(key: key);

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _showDetails = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('\$${widget.order.amount}'),
            subtitle: Text(
              DateFormat('dd/MM/yyyy hh:mm').format(widget.order.dateTime),
            ),
            trailing: IconButton(
              icon: Icon(_showDetails ? Icons.expand_less : Icons.expand_more),
              onPressed: _toggleDetails,
            ),
          ),
          if (_showDetails)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              height: min(widget.order.contents.length * 20.0 + 50, 180),
              child: Scrollbar(
                child: ListView(
                  children: [
                    ...widget.order.contents
                        .map(
                          (content) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Row(
                              children: [
                                Text(
                                  content.product.title,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                    '${content.quantity}x \$${content.product.price}',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.grey,
                                    ))
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            ),
                          ),
                        )
                        .toList()
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }

  void _toggleDetails() {
    setState(() {
      _showDetails = !_showDetails;
    });
  }
}
