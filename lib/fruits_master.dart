import 'dart:convert';
import 'dart:math';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:tp_fruits/cart_screen.dart';
import './fruit_details.dart';
import 'fruit.dart';
import 'fruit_preview.dart';
import 'cartModel.dart';


List<String> fruitNames = ["Pomme", "Poire", "Framboise", "Fraise"];
List<Color> colors = [Colors.red, Colors.yellow, Colors.purple, Colors.pink];

class FruitsMaster extends StatefulWidget {
  @override
  _FruitsMasterState createState() => _FruitsMasterState();
}

class _FruitsMasterState extends State<FruitsMaster> {

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
      Response response = await dio.get('https://fruits.shrp.dev/items/fruits?fields=*.*');
      if (response.statusCode == 200 || response.statusCode == 304) {
        var getFruitsData = response.data['data'];


        for (var element in getFruitsData) {
          Fruit fruit = Fruit.fromJson(element);
          fruits.add(fruit);
        }

      } else {
        throw Exception('Failed to load fruits');
      }

    } catch (e) {
      // Gérer les erreurs ici
      throw Exception('Failed to fetch fruits');
    }
    return fruits;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartModel>(
      builder: (context, cart, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Total panier: ${cart.getPrice().toStringAsFixed(2)} €'),
            centerTitle: true,
          ),
          body: cart.getIndex() == 0
              ? FutureBuilder<List<Fruit>>(
                  future: fruitList,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return FruitPreview(
                            fruit: snapshot.data![index],
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
              : Consumer<CartModel>(
                  builder: (context, cart, child) {
                    return ListView.builder(
                      itemCount: cart.getCart().length,
                      itemBuilder: (context, index) {
                        return CartScreen(
                          panier: cart.getCart()[index],
                          onTap: () {
                            ;
                          },
                        );
                      },
                    );
                  },
                ),
          bottomNavigationBar: Consumer<CartModel>(
            builder: (context, cart, child) {
              return BottomNavigationBar(
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
                currentIndex: cart.getIndex(),
                selectedItemColor: Colors.amber[800],
                onTap: (int index) => cart.onItemTapped(index),
              );
            },
          ),
        );
      },
    );
  }
  
}