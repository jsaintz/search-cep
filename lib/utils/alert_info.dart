import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

showAlertInfoCep(context) {
  Alert(
    context: context,
    type: AlertType.warning,
    title: "AVISO!",
    desc: "Insira um CEP valido!!",
    buttons: [
      DialogButton(
        child: Text(
          "OK",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () => Navigator.pop(context),
        width: 120,
      )
    ],
  ).show();
}