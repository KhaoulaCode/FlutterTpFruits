import 'dart:collection';
import 'fruit.dart';
import 'package:flutter/material.dart';

class CartModel extends ChangeNotifier {
  final List<Fruit> _fruits = [];
  final List<Fruit> _cart = [];
  double _sum = 0.0;
  int _selectedIndex = 0;

  /// An unmodifiable view of the fruits in the cart.
  UnmodifiableListView<Fruit> get fruits => UnmodifiableListView(_fruits);

  void removeFruit(Fruit fruit) {
    _cart.remove(fruit);
    _sum -= fruit.price;

    notifyListeners();
  }

  void addFruit(Fruit fruit) {
    _cart.add(fruit);
    _sum += fruit.price;
    notifyListeners();
  }

  onItemTapped(int index) {
    _selectedIndex = index; 
    notifyListeners();
    }

    int getIndex(){
      return _selectedIndex;
    }

    List<Fruit> getCart(){
      return _cart;
    }
    double getPrice(){
      return _sum;
    }
}
