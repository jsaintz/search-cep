import 'package:http/http.dart' as http;
import 'package:search_cep/models/result_cep.dart';

class CepService {
  static Future<CepModel> fetchCep(String cep) async {
    Uri url = Uri.parse(('https://viacep.com.br/ws/$cep/json/'));
    final response = await http.get(url);
    try {
      if (response.statusCode == 200) {
        return CepModel.fromJson(response.body);
      } else {
        throw new ArgumentError('Falha ao acessar o serviço');
      }
    } on Exception catch (e) {
      throw Exception(e);
    }
  }
}
