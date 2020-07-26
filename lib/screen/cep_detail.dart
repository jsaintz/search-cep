import 'package:flutter/material.dart';
import 'package:search_cep/models/result_cep.dart';
import 'package:search_cep/services/cep_service.dart';
import '../models/result_cep.dart';

class CepDetail extends StatefulWidget {
  final String cep;

  const CepDetail({Key key, @required this.cep}) : super(key: key);

  @override
  _CepDetailState createState() => _CepDetailState();
}

class _CepDetailState extends State<CepDetail> {
  @override
  void initState() {
    super.initState();
  }

  Future<CepModel> _fetchCep() async {
    return await CepService.fetchCep(widget.cep);
  }

  Widget _titleCep(String title, String subtitle, IconData icon) {
    return ListTile(
        title: Text(title,style: TextStyle(fontSize: 22),),
        subtitle: Text(subtitle != "" ? subtitle : 'Sem dados', style:TextStyle(fontSize: 20),),
        leading: Icon(icon, color: Colors.blue));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'CEP - ${widget.cep}',
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: FutureBuilder<CepModel>(
        future: _fetchCep(),
        builder: (context, snapshot) {
          final cep = snapshot.data;
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
              return Column(
                children: <Widget>[
                  _titleCep('Rua', cep.logradouro, Icons.location_on),
                  _titleCep('Complemento', cep.complemento,
                      Icons.library_books),
                  _titleCep('Bairro', cep.bairro, Icons.explore),
                  _titleCep('Cidade', cep.localidade, Icons.location_city),
                  _titleCep('Estado', cep.uf, Icons.my_location)
                ],
              );
              break;
          }
          return Text('Sem dados');
        },
      ),
    );
  }
}
