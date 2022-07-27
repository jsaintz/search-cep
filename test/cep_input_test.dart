import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

Widget _buildSearchCepTextField(TextInputFormatter inputFormatter, TextEditingController _searchCepController) {
  return MaterialApp(
    home: MediaQuery(
      data: const MediaQueryData(size: Size(320, 480)),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Material(
          child: TextFormField(
            autocorrect: true,
            maxLength: 10,
            autofocus: true,
            // maxLengthEnforcement: ,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              labelText: 'CEP',
              labelStyle: TextStyle(fontSize: 20.0),
              counter: Offstage(),
            ),
            enabled: true,
            controller: _searchCepController,
            inputFormatters: [
              // WhitelistingTextInputFormatter.digitsOnly,
              CepInputFormatter(),
            ],
          ),
        ),
      ),
    ),
  );
}

void main() {
  testWidgets('Retornar o formato do cep valido', (WidgetTester cepInput) async {
    final textController = TextEditingController();
    when(await cepInput.pumpWidget(_buildSearchCepTextField(CepInputFormatter(), textController)));

    when(await cepInput.enterText(find.byType(TextField), '09852210'));
    expect(textController.text, '09.852-210');
  });
}
