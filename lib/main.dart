import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:search_cep/screen/home_page.dart';

void main() => runApp(SearchCep());

class SearchCep extends StatefulWidget {
  @override
  _SearchCepState createState() => _SearchCepState();
}

class _SearchCepState extends State<SearchCep> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LocationAnimation(),
    );
  }
}

class LocationAnimation extends StatefulWidget {
  @override
  _LocationAnimation createState() => _LocationAnimation();
}

class _LocationAnimation  extends State<LocationAnimation> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5), () {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => CepList(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: FlareActor("assets/animation/location.flr",
          alignment: Alignment.center, fit: BoxFit.contain, animation: "idle"),
    );
  }
}
