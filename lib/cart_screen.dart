import 'package:flutter/material.dart';
import 'fruits_master.dart';
import 'fruit_details.dart';
import 'fruit.dart';

class CartScreen extends StatelessWidget {
  final Fruit panier;
  final Function onTap;


  CartScreen({required this.panier, required this.onTap});

  @override
Widget build(BuildContext context) {
    return ListTile(
      title: Text(panier.name),
      trailing: IconButton(
        icon : const Icon(IconData(0xe1b9, fontFamily: 'MaterialIcons'),
                    color: Colors.red
        ),
        onPressed: ()=> onTap(panier),
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
  }

  }

