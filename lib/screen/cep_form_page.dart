import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:search_cep/database/local_storage.dart';
import 'package:search_cep/services/cep_service.dart';
import 'package:search_cep/utils/alert_info.dart';

class SearchCepForm extends StatefulWidget {
  @override
  _SearchCepForm createState() => _SearchCepForm();
}

class _SearchCepForm extends State<SearchCepForm> {
  TextEditingController _searchCepController = TextEditingController();
  bool _loading = false;
  bool _enableField = true;
  late String _result;

  @override
  void dispose() {
    super.dispose();
    _searchCepController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar CEP'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildSearchCepTextField(),
            _buildSearchCepButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchCepTextField() {
    return TextFormField(
      autocorrect: true,
      maxLength: 10,
      autofocus: true,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        labelText: 'CEP',
        labelStyle: TextStyle(fontSize: 20.0),
        counter: Offstage(),
      ),
      enabled: _enableField,
      controller: _searchCepController,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(8),
        CepInputFormatter(),
      ],
    );
  }

  Widget _buildSearchCepButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.green,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        onPressed: _searchCep,
        child: _loading
            ? _circularLoading()
            : Text(
                'Adicionar',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
      ),
    );
  }

  void _searching(bool enable) {
    setState(() {
      _result = enable ? '' : _result;
      _loading = enable;
      _enableField = !enable;
    });
  }

  Widget _circularLoading() {
    return Container(
      height: 15,
      width: 15,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      ),
    );
  }

  void _searchCep() async {
    final cep = _searchCepController.text.replaceAll('.', '');

    if (cep.isEmpty || cep.length != 9) {
      showAlertInfoCep(context);
      return;
    }
    _searching(true);

    final resultCep = await CepService.fetchCep(cep);

    if (cep == resultCep.cep || resultCep.cep != null) {
      saveCep(resultCep.cep!);
      setState(() {
        Navigator.of(context).pop();
      });
    } else {
      showAlertInfoCep(context);
    }
    _searching(false);
  }

  void saveCep(String cep) async {
    await LocalStorage.saveCepPreference(cep);
  }
}
