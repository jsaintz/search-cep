import 'package:flutter/material.dart';
import 'package:search_cep/models/result_cep.dart';
import 'package:search_cep/services/cep_service.dart';
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

  var ceps = new CepModel();

  Future _searchCep(ceps) async {
    final data = await CepService.fetchCep(cep: ceps);
    if (data != null) {
      ceps = data;
      ceps.add(new CepModel.fromJson(ceps.toString()));
    }

    // Map<String, dynamic> tes = json.decode(data.toJson());
    return ceps;
  }

  Widget _titleCep(String title, String subtitle, IconData icon) {
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
              // final listCep = snapshot.data.getKeys().first;
              final String listCep =
                  snapshot.data.getKeys().toList().reversed.first;
              _searchCep(listCep);
              return Column(
                children: <Widget>[
                  _titleCep('Complemento', ceps.bairro, Icons.location_on),
                ],
              );
              //     Icons.location_on);
              // _titleCep('Complemento', _loadCep().complemento,
              //     Icons.collections_bookmark);
              // _titleCep('Bairro', _loadCep().bairro, Icons.explore);
              // _titleCep('Cidade', _loadCep().localidade, Icons.location_city);
              // _titleCep('UF', _loadCep().uf, Icons.location_searching);
              break;
          }
          return Text('Sem dados');
        },
      ),
    );
  }
}
