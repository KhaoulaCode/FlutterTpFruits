import 'dart:async';

import 'package:flutter_map/flutter_map.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:latlong2/latlong.dart';
import 'cartModel.dart';
import 'country.dart';
import 'fruits_master.dart';
import 'fruit_preview.dart';
import 'fruit.dart';
import 'quantity_badge.dart';

class FruitDetails extends StatelessWidget {
  final Fruit fruit;

  const FruitDetails({required this.fruit});

  @override
  Widget build(BuildContext context) {

    void _showSnackBar(Fruit fruit, Color color, String message) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: fruit.name == null
              ? Text('$message')
              : Text('${fruit.name} a été $message du panier'),
          duration: Duration(seconds: 1),
          backgroundColor: color,
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(fruit.name),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Image.asset(
              'images/${fruit.img}',
              width: 150,
              height: 150,
            ),
            Text('Origine : ${fruit.origine.name}', style: const TextStyle(fontSize: 15)),
            Text('Season : ${fruit.season}', style: TextStyle(fontSize: 15)),
            Text('Stock : ${fruit.stock}', style: TextStyle(fontSize: 15)),
            Text("Tarif à l'unité : " +fruit.price.toStringAsFixed(2).toString() + " €"),
            Consumer<CartModel>(
              builder: (context, cart, child) {
                return Row(
                  children: [
                    const Text('Quantité sélectionnée:  '),
                    QuantityBadge(qty: cart.nbFruitCart(fruit))
                  ],
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10)),
                  onPressed: () => ({
                    Provider.of<CartModel>(context, listen: false).removeFruit(fruit),
                    _showSnackBar(fruit, Colors.red, 'retiré')
                  }),
                  child: const Icon(IconData(0xe51d, fontFamily: 'MaterialIcons'),
                      color: Colors.white),
                ),
                Consumer<CartModel>(
                  builder: (context, cart, child) {
                    return FloatingActionButton(
                      onPressed: () => {
                        Provider.of<CartModel>(context, listen: false).addFruit(fruit), 
                        _showSnackBar(fruit, Colors.green, 'ajouté')
                      },
                      child: const Icon(Icons.add),
                    );
                  },
                ),
              ],
            ),
            Flexible(
              flex: 3,
              fit: FlexFit.tight,
              child: FlutterMap(
                options: MapOptions(
                  center: fruit.origine.location,
                  zoom: 9.2,
                ),
                nonRotatedChildren: [
                  AttributionWidget.defaultWidget(
                    source: 'OpenStreetMap contributors',
                    onSourceTapped: null,
                  ),
                ],
                children: [
                  TileLayer(
                    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.app',
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        width: 100.0,
                        height: 100.0,
                        point: fruit.origine.location,
                        builder: (ctx) => const Icon(
                            Icons.location_on,
                            color: Colors.red,
                            size: 30.0
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}