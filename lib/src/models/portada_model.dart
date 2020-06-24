import 'dart:convert';


import '../utils/utils.dart' as utils;

PortadaModel portadaModelFromJson(String str) => PortadaModel.fromJson(json.decode(str));

String portadaModelToJson(PortadaModel data) => json.encode(data.toJson());

class PortadaModel {
    int id;
    String imageName;

    

    PortadaModel({
        this.id,
        this.imageName,
    });

    factory PortadaModel.fromJson(Map<String, dynamic> json) => PortadaModel(
        id: json["id"],
        imageName:(json["image_name"]==null)? null : json["image_name"]
        
    );

    Map<String, dynamic> toJson() => {
        "id" : id,
        "imageName" :imageName,
    };
}

