import 'dart:convert';
import 'dart:async';
import 'package:formvalidation/src/models/user_model.dart';
import 'package:formvalidation/src/preferencias_usuario/preferencias_usuario.dart' ;
import 'package:formvalidation/src/utils/utils.dart' as utils;
import 'package:http/http.dart' as http;

class UsuarioBusquedas {

   final String _url = '${utils.url}/api/sec';
    final _prefs = new PreferenciasUsuario();

    Future<List<UserModel>> _procesarRespuesta(Uri url) async {
    
    final resp = await http.get( url );
    final decodedData = json.decode(resp.body);

    final usuarios = new Usuarios.fromJsonList(decodedData['results']);


    return usuarios.users;
  }


  

    Future<List<UserModel>> buscarUsuario( String query ) async {
      
    /*final llamado = Uri.https(_url, '/busquedas/usuarios?access_token=${_prefs.token}', {
      'busqueda':query
    });*/
    final informacion = {
      'busqueda'    : query
    };


    final resp = await http.post(
      
      _url+'/busquedas/usuarios?access_token=${_prefs.token}',
      headers: {"Content-Type": "application/json"},
      body: json.encode(informacion)
    );
    
    final decodedData = json.decode(resp.body);
    
    final usuarios = new Usuarios.fromJsonList(decodedData);
    print(usuarios);
    
    return usuarios.users;

  }


}