
import 'dart:convert';
import 'dart:io';

import 'package:formvalidation/src/models/mensaje_model.dart';
import 'package:formvalidation/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'package:mime_type/mime_type.dart';

import 'package:formvalidation/src/models/producto_model.dart';

import '../utils/utils.dart' as utils;

class MensajesProvider {

  final String _url = '${utils.url}/api/sec';
  final _prefs = new PreferenciasUsuario();

  Future<bool> crearMensaje( MensajeModel mensaje ) async {
    
    final url = '$_url/productos.json?auth=${ _prefs.token }';

    final resp = await http.post( url, body: mensajeModelToJson(mensaje) );

    final decodedData = json.decode(resp.body);

    print( decodedData );

    return true;

  }

  Future<bool> editarMensaje( MensajeModel mensaje ) async {
    
    final url = '$_url/productos/${ mensaje.id }.json?auth=${ _prefs.token }';

    final resp = await http.put( url, body: mensajeModelToJson(mensaje) );

    final decodedData = json.decode(resp.body);

    print( decodedData );

    return true;

  }



  /*Future<List<MensajeModel>> cargarMensajes() async {

    final url  = '$_url/productos.json?auth=${ _prefs.token }';
    final resp = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<MensajeModel> productos = new List();


    if ( decodedData == null ) return [];
    
    if ( decodedData['error'] != null ) return [];


    decodedData.forEach( ( id, prod ){

      final prodTemp = MensajeModel.fromJson(prod);
      prodTemp.id = id;

      productos.add( prodTemp );

    });

    // print( productos[0].id );

    return productos;

  }*/

    Future<List<MensajeModel>> cargarMimuro() async {

    final url  = '$_url/mimuro?access_token=${ _prefs.token }';
    final resp = await http.get(url);

    final List<dynamic> decodedData = json.decode(resp.body);
    final List<MensajeModel> mensajes = new List();


    if ( decodedData == null ) return [];
    


    decodedData.forEach( (mens){

      final prodTemp = MensajeModel.fromJson(mens);
      
      print(prodTemp.imageName);
      
      print(prodTemp.id);
      mensajes.add( prodTemp );

    });

    // print( productos[0].id );

    return mensajes;

  }


  Future<int> borrarMensaje( String id ) async { 

    final url  = '$_url/productos/$id.json?auth=${ _prefs.token }';
    final resp = await http.delete(url);

    print( resp.body );

    return 1;
  }


  Future<String> subirImagen( File imagen ) async {

    final url = Uri.parse('https://api.cloudinary.com/v1_1/dc0tufkzf/image/upload?upload_preset=cwye3brj');
    final mimeType = mime(imagen.path).split('/'); //image/jpeg

    final imageUploadRequest = http.MultipartRequest(
      'POST',
      url
    );

    final file = await http.MultipartFile.fromPath(
      'file', 
      imagen.path,
      contentType: MediaType( mimeType[0], mimeType[1] )
    );

    imageUploadRequest.files.add(file);


    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if ( resp.statusCode != 200 && resp.statusCode != 201 ) {
      print('Algo salio mal');
      print( resp.body );
      return null;
    }

    final respData = json.decode(resp.body);
    print( respData);

    return respData['secure_url'];


  }


}

