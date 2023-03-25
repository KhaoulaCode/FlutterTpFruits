import 'package:flutter/material.dart';

class QuantityBadge extends StatelessWidget {
  const QuantityBadge({required this.qty});
  final int qty;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(100.0)),
          color: Colors.red),
      padding: const EdgeInsets.only(left: 6, right: 6, top: 1, bottom: 1),
      child: Text((qty ?? 0).toString(),
          style: const TextStyle(color: Colors.white)),
    );
  }
}