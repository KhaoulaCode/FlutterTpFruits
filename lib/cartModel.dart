import 'dart:collection';
import 'fruit.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:dio/dio.dart';

class CartModel extends ChangeNotifier {
  
  final List<Fruit> _fruits = [];
  final List<Fruit> _cart = [];
  List<Fruit> get panier => _cart;
  
  double _sum = 0.0;
  int _selectedIndex = 0;
  int _qte = 0;

  /// An unmodifiable view of the fruits in the cart.

  CartModel() {
     _fetchFruits();
  }

  final dio = Dio();
Future<List<Fruit>> _fetchFruits() async {
  List<Fruit> fruits = [];
  try {
    var response =
        await dio.get('https://fruits.shrp.dev/items/fruits?fields=*.*');
    if (response.statusCode == 200 || response.statusCode == 304) {
      var getFruitsData = response.data['data'];

      for (var element in getFruitsData) {
        Fruit fruit = Fruit.fromJson(element);
        fruits.add(fruit);
      }
      // assign the fetched fruits to the _fruits list
      _fruits.addAll(fruits);
      notifyListeners();
    } else {
      throw Exception('Failed to load fruits');
    }
  } catch (e) {
    // Gérer les erreurs ici
    throw Exception('Failed to fetch fruits');
  }
  return fruits;
}

  UnmodifiableListView<Fruit> get fruits => UnmodifiableListView(_fruits);

  void removeFruit(Fruit fruit) {
    _cart.remove(fruit);
    _sum -= fruit.price;
    _qte -=1;

    notifyListeners();
  }

  void addFruit(Fruit fruit) { 
    _cart.add(fruit);
    _sum += fruit.price;
    _qte +=1;
    notifyListeners();
  }
    int getQte(){
      return _qte;
    }

    List<Fruit> getCart(){
      return _cart;
    }

    double getPrice(){
      return _sum;
    }

    int nbFruitCart(Fruit fruit){
    var nbFruit=_cart.where((element) => element.id == fruit.id).length;
    if(nbFruit==0){
      return 0;
    }
    return nbFruit;
  }

  void viderPanier() {
    _cart.clear();
    notifyListeners();
  }

   UnmodifiableListView<Fruit> getFruitsBySeason(String season) {
    if (season == 'Tous') return UnmodifiableListView(_fruits);
    return UnmodifiableListView(_fruits.where((e) => e.season == season));
  }
}
