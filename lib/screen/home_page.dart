import 'package:flutter/material.dart';
import 'package:search_cep/screen/cep_form_page.dart';
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
    return Scaffold(
      appBar: AppBar(
          title: Text('Lista de Ceps'), automaticallyImplyLeading: false),
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
              List<String> listCep =
                  snapshot.data.getKeys().toList().reversed.toList();
              if (listCep.length > 5) {
                listCep = listCep.getRange(0, 5).toList();
              }
              if (listCep.length == 0) {
                return EmptyListWidget();
              } else {
                return ListView.builder(
                  itemCount: listCep.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CepDetail(cep: listCep[index]),
                            ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Card(
                          elevation: 8,
                          color: Colors.blue,
                          child: ListTile(
                            title: Text(
                              listCep[index],
                              style: TextStyle(
                                  fontSize: 24.0, color: Colors.white),
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
        backgroundColor: Colors.green,
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

class EmptyListWidget extends StatelessWidget {
  const EmptyListWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 50),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            title: Text(
              'Seja bem vindo,\n Adicione um novo Cep',
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
            'assets/images/empty-list.png',
            width: 100,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }
}
