import 'package:flutter/material.dart';
import 'package:search_cep/views/cep_form_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CepList extends StatefulWidget {
  @override
  _CepListState createState() => _CepListState();
}

class _CepListState extends State<CepList> {
  @override
  void initState() {
    print('iniciou o stado');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('buildou');
    return Scaffold(
      appBar: AppBar(
        title: Text('Ceps'),
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
              final List<String> listCep = snapshot.data.getKeys().toList();
              return ListView.builder(
                itemCount: listCep.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(
                        listCep[index],
                        style: TextStyle(fontSize: 24.0),
                      ),
                    ),
                  );
                },
              );
              break;
          }
          return Text('Nenhum Cep Encontrado!!!');
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => SearchCepForm(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
