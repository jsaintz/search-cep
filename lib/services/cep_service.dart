import 'package:http/http.dart' as http;
import 'package:search_cep/models/result_cep.dart';

class CepService {
  static Future<ResultCep> fetchCep({String cep}) async {
    final response = await http.get('https://viacep.com.br/ws/$cep/json/');
    if (response.statusCode == 200) {
      return ResultCep.fromJson(response.body);
    } else {
      throw Exception('Cep não encontrado!!!');
    }
  }
}
