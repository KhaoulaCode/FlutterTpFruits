import 'package:flutter/material.dart';
import 'fruits_master.dart';
import 'fruit_details.dart';
import 'fruit.dart';

class FruitPreview extends StatelessWidget {
  final Fruit fruit;
  final Function(Fruit) onTap;
  final Function(Fruit) removeFruit;

  FruitPreview(
      {required this.fruit, required this.onTap, required this.removeFruit});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(fruit.name.toString()),
      trailing: IconButton(
        icon: Icon(Icons.add),
        onPressed: () => onTap(fruit),
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
          MaterialPageRoute(
              builder: (context) => FruitDetails(
                  fruit: fruit, onTap: onTap, removeFruit: removeFruit)),
        )
      },
    );
  }
}
