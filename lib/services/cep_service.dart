import 'package:http/http.dart' as http;
import 'package:search_cep/models/result_cep.dart';

class CepService {
  static Future<CepModel> fetchCep({String cep}) async {
    final response = await http.get('https://viacep.com.br/ws/$cep/json/');
    
    try {
      if (response.statusCode == 200) {
        return CepModel.fromJson(response.body);
      }
    } catch (e) {
      throw Exception('Falha ao acessar o serviço');
    }
  }
}
