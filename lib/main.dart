import 'package:flutter/material.dart';
import 'package:search_cep/screen/home_page.dart';

void main() => runApp(SearchCep());

class SearchCep extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CepList(),
    );
  }
}
