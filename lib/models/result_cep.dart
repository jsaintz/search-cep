import 'dart:convert';

class CepModel {
  String? cep;
  String? logradouro;
  String? complemento;
  String? bairro;
  String? localidade;
  String? uf;
  String? unidade;
  String? ibge;
  String? gia;

  CepModel(
      {this.cep,
      this.logradouro,
      this.complemento,
      this.bairro,
      this.localidade,
      this.uf,
      this.unidade,
      this.ibge,
      this.gia});

  factory CepModel.fromMap(Map<String, dynamic> json) => CepModel(
        cep: json["cep"] == null ? null : json["cep"],
        logradouro: json["logradouro"] == null ? null : json["logradouro"],
        complemento: json["complemento"] == null ? null : json["complemento"],
        bairro: json["bairro"] == null ? null : json["bairro"],
        localidade: json["localidade"] == null ? null : json["localidade"],
        uf: json["uf"] == null ? null : json["uf"],
        unidade: json["unidade"] == null ? null : json["unidade"],
        ibge: json["ibge"] == null ? null : json["ibge"],
        gia: json["gia"] == null ? null : json["gia"],
      );

  Map<String, dynamic> toMap() => {
        "cep": cep == null ? null : cep,
        "logradouro": logradouro == null ? null : logradouro,
        "complemento": complemento == null ? null : complemento,
        "bairro": bairro == null ? null : bairro,
        "localidade": localidade == null ? null : localidade,
        "uf": uf == null ? null : uf,
        "unidade": unidade == null ? null : unidade,
        "ibge": ibge == null ? null : ibge,
        "gia": gia == null ? null : gia,
      };

  factory CepModel.fromJson(String value) => CepModel.fromMap(json.decode(value));

  String toJson() => json.encode(toMap());
}
