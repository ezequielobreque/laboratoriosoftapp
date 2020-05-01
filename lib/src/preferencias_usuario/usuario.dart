




import 'dart:convert';

import 'package:formvalidation/src/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:formvalidation/src/preferencias_usuario/preferencias_usuario.dart';
 
UserModel _user;
final _prefs = new PreferenciasUsuario();
UserModel userApp(){
    if(_prefs.usuarioApp!=null &&_prefs.usuarioApp!=[] ){
    _user= userModelFromJson(_prefs.usuarioApp);
    return _user;
    }else{
    return null;}

  }