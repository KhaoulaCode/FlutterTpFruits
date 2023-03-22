import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cartModel.dart';
import 'fruits_master.dart';
import 'fruit_details.dart';
import 'fruit.dart';

class CartScreen extends StatelessWidget {
  final Fruit panier;
  final Function onTap;


  CartScreen({required this.panier, required this.onTap});

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
  return Consumer<CartModel>( builder: (context, cart, child) {
    return ListTile(
      title: Text(panier.name),
      trailing: IconButton(
        icon : const Icon(IconData(0xe1b9, fontFamily: 'MaterialIcons'),
        color: Colors.red
        ),
        onPressed: ()=> {cart.removeFruit(panier), _showSnackBar(panier, Colors.red, 'retiré')},
        ),
        

      tileColor: Colors.white,
      leading: Image(
        image: AssetImage('images/${panier.img}'),
        width: 40,
        height: 40,
        fit: BoxFit.cover,
      ),
      onTap: () => { },
    );
  });

  }
}
