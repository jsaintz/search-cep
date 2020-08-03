import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:search_cep/models/result_cep.dart';
import 'package:search_cep/services/cep_service.dart';

class ApiClient extends Mock implements http.Client {}

main() {
  group('Buscar Cep', () {
    test('Retornar Cep caso a chamada for com sucesso', () async {
      final client = ApiClient();
      final cep = '09852-210';

      when(client.get('https://viacep.com.br/ws/$cep/json/'))
          .thenAnswer((_) async => http.Response('{"cep": "09852-210"}', 200));

      expect(await CepService.fetchCep(cep), isA<CepModel>());
    });

    test('Retornar uma exceção caso a chamada não ocorra', () async {
      final client = ApiClient();
      final cep = "0000000";

      when(client.get('https://viacep.com.br/ws/$cep/json/'))
          .thenAnswer((_) async => http.Response('Falha ao acessar o servidor', 400));

      expect(Future.error(StateError('bad state')), throwsStateError);
    });
  });
}
