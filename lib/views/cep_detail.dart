import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:search_cep/database/local_storage.dart';
import 'package:search_cep/models/result_cep.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CepDetail extends StatefulWidget {
  @override
  _CepDetailState createState() => _CepDetailState();
}

class _CepDetailState extends State<CepDetail> {
  @override
  void initState() {
    super.initState();
  }

  ResultCep resultCep = ResultCep();

  _loadCep() async {
    final obj = ResultCep.fromJson(await LocalStorage.readCep("cep"));
    final result = jsonDecode(obj.toJson());
    setState(() {
      resultCep = result;
    });
  }

  Widget _tileCep(String title, String subtitle, IconData icon) {
    return ListTile(
        title: Text(title),
        subtitle: Text(subtitle != "" ? subtitle : 'Sem dados'),
        leading: Icon(icon, color: Colors.blue));
  }

  @override
  Widget build(BuildContext context) {
    print('chegou no detalhe');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Informações ',
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Text("Carregando"),
                  ],
                ),
              );
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              Text(_loadCep().logradouro);
              // _tileCep('Endereço', _loadCep().logradouro, Icons.location_on);
              // _tileCep('Complemento', _loadCep().complemento,
              //     Icons.collections_bookmark);
              // _tileCep('Bairro', _loadCep().bairro, Icons.explore);
              // _tileCep('Cidade', _loadCep().localidade, Icons.location_city);
              // _tileCep('UF', _loadCep().uf, Icons.location_searching);
              break;
          }
          return Text('Sem dados');
        },
      ),
    );
  }
}
