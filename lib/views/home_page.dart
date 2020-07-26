import 'package:flutter/material.dart';
import 'package:search_cep/database/local_storage.dart';
import 'package:search_cep/views/cep_form_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cep_detail.dart';

class CepList extends StatefulWidget {
  @override
  _CepListState createState() => _CepListState();
}

class _CepListState extends State<CepList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('cepList build');
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
              final List<String> listCep =
                  snapshot.data.getKeys().toList().reversed.toList();
              if (listCep.length == 0) {
                return Column(
                  children: <Widget>[
                    SizedBox(height: 50),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text(
                          'Cep não cadastrado,\n Adicione um novo CEP',
                          style: TextStyle(
                            fontSize: 24.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(height: 80),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset(
                        'assets/images/cep_icon.png',
                        width: 100,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                );
              } else if (listCep.length <= 4) {
                return ListView.builder(
                  itemCount: listCep.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                              builder: (context) => CepDetail(),
                            )).then((value) => setState(() {}));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Card(
                          child: ListTile(
                            title: Text(
                              listCep[index],
                              style: TextStyle(fontSize: 24.0),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else {
                return ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                              builder: (context) => CepDetail(),
                            )).then((value) => setState(() => {}));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Card(
                          child: ListTile(
                            title: Text(
                              listCep[index],
                              style: TextStyle(fontSize: 24.0),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
              break;
          }
          return Text('Cep não encontrado!!!');
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
                MaterialPageRoute(
                  builder: (context) => SearchCepForm(),
                ),
              )
              .then((value) => setState(() {}));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
