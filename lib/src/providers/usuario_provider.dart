import 'dart:convert';

import 'package:formvalidation/src/models/user_model.dart';
import 'package:formvalidation/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http/http.dart' as http;

import '../utils/utils.dart' as utils;

class UsuarioProvider {

  
 


  final String _firebaseToken = 'AIzaSyAO749eZf3E35cmxgZA06mRygilezkNVsM';
  final _prefs = new PreferenciasUsuario();


  Future<Map<String, dynamic>> login( String username, String password) async {


    var _bodyToken = new Map<String, dynamic>();
    _bodyToken['grant_type'] = 'password';
    _bodyToken['client_id'] = '1_1jrqbyv8if0g8c8c800ksk00s0kkws4k0k4ok0sck8c8scs4gw';
    _bodyToken['client_secret'] = '5q3zub1jj9c0kw8ok84kgcs8sgg0w8cs00888os0kk0kk4cwoo';
    _bodyToken['username'] = username;
    _bodyToken['password'] = password;


    /*final FormData _bodyToken = new FormData({
      "grant_type" : "password",
        "client_id" : "1_1jrqbyv8if0g8c8c800ksk00s0kkws4k0k4ok0sck8c8scs4gw",
        "client_secret": "5q3zub1jj9c0kw8ok84kgcs8sgg0w8cs00888os0kk0kk4cwoo",
        "username": "facu",
        "password": "test"
   /*"file1": new UploadFileInfo(new File("./upload.jpg"), "upload1.jpg")*/
    });*/

    

    print(utils.url);
    final resp = await http.post(
      '${utils.url}/oauth/v2/token',
      body: _bodyToken
    );
    
    Map<String, dynamic> decodedResp = json.decode( resp.body );

    print(decodedResp);

    if ( decodedResp.containsKey('access_token') ) {
      
      _prefs.token = decodedResp['access_token'];
       final resp = await http.post(
      '${utils.url}/api/sec/usuario?access_token=${_prefs.token}');
      final dynamic decodedData = json.decode(resp.body);
      
      if( decodedData!= null){
      
      _prefs.usuarioApp=decodedData['user'];
      }
      return { 'ok': true, 'token': decodedResp['access_token'] };
    } else {
      return { 'ok': false, 'mensaje': decodedResp['error_description'] };
    }

  }


  Future<Map<String, dynamic>> nuevoUsuario( String email,String username, String password ) async {

    final informacion = {
      'email'    : email,
      'password' : password,
      'username': username
    };

    final resp = await http.post(
      
      '${utils.url}/api/signup',
      headers: {"Content-Type": "application/json"},
      body: json.encode(informacion)
    );

    Map<String, dynamic> decodedResp = json.decode( resp.body );

    print(decodedResp);

    if ( decodedResp.containsKey('id') ) {
      

      return { 'ok': true, 'mensaje': decodedResp['mensaje'] };
    } else {
      return { 'ok': false, 'mensaje': decodedResp['error']['message'] };
    }


  }



}