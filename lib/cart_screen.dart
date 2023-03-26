import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cartModel.dart';
import 'fruits_master.dart';
import 'fruit_details.dart';
import 'fruit.dart';
import 'auth_form.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  @override
  Widget build(BuildContext context) {
    void _showSnackBar(Fruit fruit, Color color, String message) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: fruit.name == null
              ? Text('$message')
              : Text('${fruit.name} a été $message du panier'),
          duration: const Duration(seconds: 1),
          backgroundColor: color,
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [ 
            const Text('Panier'),
            Consumer(builder: (context, CartModel cart, child) {
              return Text(
                  '${cart.panier.length} fruits',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  )
              );
            }),
            IconButton(
              icon: const Icon(Icons.delete_forever),
              onPressed: () => Provider.of<CartModel>(context, listen: false).viderPanier(),
            ),
          ],
        ),
      ),
      body: Consumer<CartModel>(
        builder: (context, cart, child) {
          return ListView.builder(
            itemCount: cart.panier.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(cart.panier[index].name),
                trailing: IconButton(
                  icon: const Icon(
                    IconData(0xe1b9, fontFamily: 'MaterialIcons'),
                    color: Colors.red,
                  ),
                  onPressed: () => {
                    _showSnackBar(cart.panier[index], Colors.red, 'retiré'),
                    cart.removeFruit(cart.panier[index]) 
                  },
                ),
                tileColor: Colors.white,
                leading: Image(
                  image: AssetImage('images/${cart.panier[index].img}'),
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                ),
              );
            },
          );
        },
      ),
      AuthForm(
        onLogin :(String email, String password)
    );
    )
  }
}
