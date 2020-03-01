// To parse this JSON data, do
//
//     final client = clientFromJson(jsonString);

import 'dart:convert';

import 'package:formvalidation/src/models/user_model.dart';

import '../utils/utils.dart' as utils;

MensajeModel mensajeModelFromJson(String str) => MensajeModel.fromJson(json.decode(str));

String mensajeModelToJson(MensajeModel data) => json.encode(data.toJson());

class MensajeModel {
    int id;
    UserModel user;
    String informacion;
    String imageName;
    DateTime fechaHora;
    

    MensajeModel({
        this.id,
        this.user,
        this.informacion,
        this.fechaHora,
        this.imageName
    });

    factory MensajeModel.fromJson(Map<String, dynamic> json) => MensajeModel(
        id: json["id"],
        user: UserModel.fromJson(json["user"]),
        informacion: json["informacion"],
        fechaHora: DateTime.parse(json["fecha_hora"]),
        
        imageName:(json["image_name"]==null)? null : json["image_name"]
        
    );

    Map<String, dynamic> toJson() => {
        "id" : id,
        "user": user.toJson(),
        "informacion": informacion,
        "imageName" :imageName,
        "fecha_hora": fechaHora.toIso8601String(),
    };
}

