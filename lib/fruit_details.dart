import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cartModel.dart';
import 'fruits_master.dart';
import 'fruit_preview.dart';
import 'fruit.dart';

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
            Text(fruit.name, style: TextStyle(fontSize: 20)),
            Text(fruit.price.toStringAsFixed(2).toString() + ' €'),
            Consumer<CartModel>(builder: (context, cart, child) {
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10)),
                onPressed: () => ({cart.removeFruit(fruit), _showSnackBar(fruit, Colors.red, 'retiré')}),
                child: const Icon(IconData(0xe51d, fontFamily: 'MaterialIcons'),
                    color: Colors.white),
              );
            }),
          ],
        ),
      ),
      floatingActionButton:
          Consumer<CartModel>(builder: (context, cart, child) {
        return FloatingActionButton(
          onPressed: () => {cart.addFruit(fruit), _showSnackBar(fruit, Colors.green, 'ajouté')},
          child: const Icon(Icons.add),
        );
      }),
    );
  }
}