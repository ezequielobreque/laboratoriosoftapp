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

    Usuarios meGustas;
    String informacion;
    String imageName;
    DateTime fechaHora;
    double longitud;
    double latitud;
    

    MensajeModel({
        this.id,
        this.user,
        this.informacion,
        this.fechaHora,
        this.imageName,
        this.meGustas,
        this.latitud,
        this.longitud
    });

    factory MensajeModel.fromJson(Map<String, dynamic> json) => MensajeModel(
        id: json["id"],
        user: UserModel.fromJson(json["user"]),
        informacion: json["informacion"],
        fechaHora: DateTime.parse(json["fecha_hora"]),
        meGustas: Usuarios.fromJsonList(json["me_gustas"]),
        longitud: (json['longitud']==null)?null: json['longitud'],
        latitud:  (json['latitud']==null)?null:json['latitud'],
        imageName:(json["image_name"]==null)? null : json["image_name"]
    );

    Map<String, dynamic> toJson() => {
        "id" : id,
        "user": user.toJson(),
        "informacion": informacion,
        "imageName" :imageName,
        "latitud" : latitud,
        "longitud": longitud,
        "fecha_hora": fechaHora.toIso8601String(),
    };
}

