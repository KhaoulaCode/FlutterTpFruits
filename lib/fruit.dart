import 'package:flutter/material.dart';
import 'country.dart';

class Fruit {
  final int id;
  final String name;
  final String color;
  final num price;
  final String img;
  final int? stock;
  final Country origine;
  final String season;

  Fruit(
      {required this.id,
      required this.name,
      required this.color,
      required this.price,
      required this.img,
      required this.stock,
      required this.season,
      required this.origine});

  Color convertToColor(String str) {
    //conversion d'une couleur exprimée en valeur hexadécimale en objet Color
    var hexString = str;
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  factory Fruit.fromJson(Map<String, dynamic> parsedJson) {
    // print(parsedJson);

    return Fruit(
      id: parsedJson['id'],
      name: parsedJson['name'],
      price: parsedJson['price'],
      color: parsedJson['color'],
      stock: parsedJson['stock'],
      origine: Country.fromJson(parsedJson['origin']),
      season: parsedJson['season'],
      img: parsedJson['image'],
    );
  }
}
