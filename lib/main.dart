import 'package:flutter/material.dart';
import 'package:search_cep/views/home_page.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: CepList(),
    theme: ThemeData(brightness: Brightness.light, primarySwatch: Colors.blue),
    darkTheme: ThemeData(
      brightness: Brightness.dark,
    ),
  ));
}
