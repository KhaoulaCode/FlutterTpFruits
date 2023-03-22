import 'package:flutter/material.dart';
import 'fruits_master.dart';
import 'fruit_preview.dart';
import 'fruit.dart';

class FruitDetails extends StatelessWidget {
  final Function onTap;
  final Function removeFruit;
  final Fruit fruit;

  const FruitDetails({required this.fruit, required this.onTap, required this.removeFruit});

  @override
  Widget build(BuildContext context) {
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
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10)),
                onPressed: () =>(removeFruit(fruit)),
                child: const Icon(IconData(0xe51d, fontFamily: 'MaterialIcons'),
                    color: Colors.white),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => onTap(fruit),
          child: const Icon(Icons.add),
        ));
  }
}
