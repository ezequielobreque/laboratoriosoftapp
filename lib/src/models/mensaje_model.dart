// To parse this JSON data, do
//
//     final client = clientFromJson(jsonString);

import 'dart:convert';

import 'package:formvalidation/src/models/user_model.dart';

MensajeModel clientFromJson(String str) => MensajeModel.fromJson(json.decode(str));

String clientToJson(MensajeModel data) => json.encode(data.toJson());

class MensajeModel {
    UserModel user;
    String informacion;
    DateTime fechaHora;

    MensajeModel({
        this.user,
        this.informacion,
        this.fechaHora,
    });

    factory MensajeModel.fromJson(Map<String, dynamic> json) => MensajeModel(
        user: UserModel.fromJson(json["user"]),
        informacion: json["informacion"],
        fechaHora: DateTime.parse(json["fecha_hora"]),
    );

    Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "informacion": informacion,
        "fecha_hora": fechaHora.toIso8601String(),
    };
}

