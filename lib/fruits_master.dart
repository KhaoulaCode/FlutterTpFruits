import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:tp_fruits/cart_screen.dart';
import './fruit_details.dart';
import 'fruit.dart';
import 'fruit_preview.dart';

List<String> fruitNames = ["Pomme", "Poire", "Framboise", "Fraise"];
List<Color> colors = [Colors.red, Colors.yellow, Colors.purple, Colors.pink];

class FruitsMaster extends StatefulWidget {
  @override
  _FruitsMasterState createState() => _FruitsMasterState();
}

class _FruitsMasterState extends State<FruitsMaster> {
  List<Fruit> _fruits = [];
  List<Fruit> _cart = [];
  double _sum = 0.0;
  int _selectedIndex = 0;

  late Future<List<Fruit>> fruitList;

  @override
  void initState() {
    super.initState();
    fruitList = _fetchFruits();
  }

  final dio = Dio();
  Future<List<Fruit>> _fetchFruits() async {
    List<Fruit> fruits = [];
    try {
      Response response = await dio.get('https://fruits.shrp.dev/items/fruits');
      if (response.statusCode == 200 || response.statusCode == 304) {
        var getFruitsData = response.data['data'];
        // fruits = getFruitsData.map((fruit) => Fruit.fromJson(fruit)).toList();

        for (var element in getFruitsData) {
          Fruit fruit = Fruit.fromJson(element);
          fruits.add(fruit);
        }

      } else {
        throw Exception('Failed to load fruits');
      }
      // return fruits;
    } catch (e) {
      // Gérer les erreurs ici
      throw Exception('Failed to fetch fruits');
    }
    return fruits;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Total panier: ${_sum.toStringAsFixed(2)} €'),
        centerTitle: true,
      ),
      body: _selectedIndex == 0 ?
        FutureBuilder<List<Fruit>>(
          future: fruitList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return FruitPreview(
                    fruit: snapshot.data![index],
                    onTap: _onFruitTap,
                    removeFruit: removeFruit,
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            // Afficher une indication de chargement
            return CircularProgressIndicator();
          },
        )
        :
        ListView.builder(
          itemCount: _cart.length,
          itemBuilder: (context, index) {
            return CartScreen(
              panier: _cart[index],
              onTap: removeFruit,
            );
          },
        ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Fruits',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_basket),
            label: 'Panier',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }

  _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onFruitTap(Fruit fruit) {
    setState(() {
      _cart.add(fruit);
      _sum += fruit.price;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${fruit.name} a été ajouté au panier'),
        duration: Duration(seconds: 1),
        backgroundColor: Colors.green,
      ),
    );
  }

  void removeFruit(Fruit fruit) {
    setState(() {
      _cart.remove(fruit);
      _sum -= fruit.price;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${fruit.name} retiré(e)'),
        duration: Duration(seconds: 1),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _addNewFruit() {
    int randomIndex = Random().nextInt(fruitNames.length);
    String randomName = fruitNames[randomIndex];
    Color randomColor = colors[randomIndex];
    String randomImg = 'images/$randomName.png';

    // setState(() {
    //   _fruits.insert(
    //     0,
    //     Fruit(
    //         id: randomIndex,
    //         name: randomName,
    //         color: randomColor,
    //         price: Random().nextDouble() * 5.0,
    //         img: randomImg),
    //   );
    // });
  }

}