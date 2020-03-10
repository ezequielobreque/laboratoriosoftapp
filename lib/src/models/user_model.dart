// To parse this JSON data, do
//
//     final client = clientFromJson(jsonString);

import 'dart:convert';
import '../utils/utils.dart' as utils;



UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class Usuarios {

  List<UserModel> users = new List();

  Usuarios();

  Usuarios.fromJsonList( List<dynamic> jsonList  ) {

    if ( jsonList == null ) return;

    for ( var item in jsonList  ) {
      final user = new UserModel.fromJson(item);
      users.add( user );
    }

  }

}





class UserModel {
    int id;
    String username;
    String email;
    String imageName;

    UserModel({
        this.id,
        this.username,
        this.email,
        this.imageName,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        imageName: (json["image_name"]==null)? null : json["image_name"],
    );

    

    Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "image_name": imageName,
    };

 /*   List<UserModel> crearUsuarios(List<Map<String, dynamic>> json){
      
     List<UserModel> usuarios= new List();
    for ( var value in json  ) {
      final user = new UserModel.fromJson(value);
      usuarios.add( user );
    }
    return usuarios;
}*/

}