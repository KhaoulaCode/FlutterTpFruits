import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'cartModel.dart';
import 'fruits_master.dart';
import 'fruit.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartModel(),
      child: MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  final dio = Dio();

  void request() async {
    Response response;
    response = await dio.get('https://fruits.shrp.dev/items/fruits');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fruits',
      theme: ThemeData(primaryColor: Colors.white),
      
      home: FruitsMaster(),
    );
  }
}













// import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';
// import 'fruits_master.dart';
// import 'fruit.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Fruits',
//       theme: ThemeData(primarySwatch: Colors.orange),
//       home: ,
//     );
//   }
// }


//Provider Wrapp
//Provider of