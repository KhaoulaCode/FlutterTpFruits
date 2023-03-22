import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tp_fruits/cartModel.dart';
import 'fruits_master.dart';
import 'fruit_details.dart';
import 'fruit.dart';

class FruitPreview extends StatelessWidget {
  final Fruit fruit;

  FruitPreview({required this.fruit});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartModel>(builder: (context, cart, child) {

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

      return ListTile(
        title: Text(fruit.name.toString()),
        trailing: IconButton(
          icon: Icon(Icons.add),
          onPressed: () => {cart.addFruit(fruit), _showSnackBar(fruit, Colors.green,'ajouté')},
        ),
        tileColor: fruit.convertToColor(fruit.color),
        leading: Image(
          image: AssetImage('images/${fruit.img}'),
          width: 40,
          height: 40,
          fit: BoxFit.cover,
        ),
        onTap: () => {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FruitDetails(fruit: fruit)),
          )
        },
      );
    });
  }
}
