import 'dart:convert';
import 'dart:math';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import './fruit_details.dart';
import 'fruit.dart';
import 'fruit_preview.dart';
import 'cartModel.dart';
import 'cart_screen.dart';

class FruitsMaster extends StatefulWidget {
  @override
  _FruitsMasterState createState() => _FruitsMasterState();
}

class _FruitsMasterState extends State<FruitsMaster> {
  late String currentFilter = 'Tous';

  @override
  Widget build(BuildContext context) {
    final List<String> filters = [
      'Tous',
      'Printemps',
      'Eté',
      'Automne',
      'Hiver'
    ];

    return Consumer<CartModel>(
      builder: (context, cart, child) {
        return Scaffold(
            appBar: AppBar(
              title:
                  Text('Total panier: ${cart.getPrice().toStringAsFixed(2)} €'),
              centerTitle: true,
              actions: [
                DropdownButton<String>(
                  value: currentFilter,
                  icon: const Icon(Icons.menu),
                  elevation: 16,
                  style: const TextStyle(color: Color.fromARGB(255, 89, 89, 89)),
                  underline: Container(
                    height: 2,
                    color: Color.fromARGB(255, 89, 89, 89),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      currentFilter = value!;
                    });
                  },
                  items: filters.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                IconButton(
                  icon: const Icon(Icons.shopping_cart),
                  tooltip: 'Panier',
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (contex) => const CartScreen(),
                        )
                    );
                  },
                ),
              ],
            ),
            body: ListView.builder(
              itemCount: cart.getFruitsBySeason(currentFilter).length,
              itemBuilder: (context, index) {
                return FruitPreview(
                  fruit: cart.getFruitsBySeason(currentFilter)[index],
                );
              },
            ),
        );
      });
  }
}