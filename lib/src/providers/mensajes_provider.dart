
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:formvalidation/src/bloc/mensaje_bloc.dart';
import 'package:formvalidation/src/bloc/provider.dart';
import 'package:formvalidation/src/models/mensaje_model.dart';
import 'package:formvalidation/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'package:mime_type/mime_type.dart';

import 'package:formvalidation/src/models/producto_model.dart';

import '../utils/utils.dart' as utils;

class MensajesProvider {
  var pagesMuro=0;
  var pagesUsuarios=0;
  var pagesMiPerfil=0;
  var limit=10;
  var _cargando = false;
  List<MensajeModel> mensajesMiMuro = new List();
  List<MensajeModel> mensajesMiPerfil = new List();
  List<MensajeModel> mensajesUsuarios = new List();
  var lenghtMimuro=-1;
  var lenghtUsuarios=-1;
  var lenghtMiPerfil=-1;
  final String _url = '${utils.url}/api/sec';
  final _prefs = new PreferenciasUsuario();

  Future<bool> crearMensaje( MensajeModel mensaje, File imagen) async {
    
    /*final url = '$_url/crearmensaje?access_token=${_prefs.token}';
    print ('llege1');
     var _bodyToken = new Map<String, dynamic>();
    _bodyToken['informacion'] = mensaje.informacion;
    _bodyToken['imageFile'] =imagen;
   print ('llege2');*/

  

  final url = Uri.parse('$_url/crearmensaje?access_token=${_prefs.token}');
  
  String latitud;
  String longitud;
  if (mensaje.latitud==null){latitud='null';longitud='null';}else{latitud=mensaje.latitud.toString();longitud=mensaje.longitud.toString();}
    if (imagen!=null){
    final mimeType = mime(imagen.path).split('/'); //image/jpeg

    /*final imageUploadRequest = http.MultipartRequest(
      'POST',
      url
    );

    final file = await http.MultipartFile.fromPath
    );

    imageUploadRequest.files.add(file);*/


    var request = http.MultipartRequest('POST', url)
        ..fields['informacion'] = mensaje.informacion
        ..fields['latitud']=longitud
        ..fields['longitud']=latitud
        ..files.add(await http.MultipartFile.fromPath(
      'imagefile',
      imagen.path,
      contentType: MediaType( mimeType[0], mimeType[1] )
          )
          );
      var response = await request.send();
      print(request);
if (response.statusCode == 200) print('Uploaded!');
    


    
    final resp = await http.Response.fromStream(response);

    if ( resp.statusCode != 200 && resp.statusCode != 201 ) {
      print('Algo salio mal');
      print( resp.body );
      return true;
    }
  
    final respData = json.decode(resp.body);
    print( respData);
  
    return true;
  }else{
var response = await http.post(url,body:{"informacion": mensaje.informacion,"latitud":latitud,"longitud":longitud});
  



    
   

    final respData = json.decode(response.body);
    print( respData);
  
    return true;
  }












    /*final resp = await http.post(url,body: _bodyToken );

    
    final decodedData = json.decode(resp.body);

    print( decodedData );

    return true;*/

  }

  Future<bool> editarMensaje( MensajeModel mensaje ,File imagen) async {
    

  final url = Uri.parse('$_url/editarmensaje/${mensaje.id}?access_token=${_prefs.token}');
  String latitud;
  String longitud;
  if (mensaje.latitud==null){latitud='null';longitud='null';}else{latitud=mensaje.latitud.toString();longitud=mensaje.longitud.toString();}
if(imagen!=null){

    final mimeType = mime(imagen.path).split('/'); //image/jpeg

    /*final imageUploadRequest = http.MultipartRequest(
      'POST',
      url
    );

    final file = await http.MultipartFile.fromPath
    );

    imageUploadRequest.files.add(file);*/
    var request = http.MultipartRequest('POST', url)
        ..fields['informacion'] = mensaje.informacion
        ..fields['latitud']=longitud
        ..fields['longitud']=latitud
        ..files.add(await http.MultipartFile.fromPath(
      'imagefile',
      imagen.path,
      contentType: MediaType( mimeType[0], mimeType[1] )
          )
          );
      var response = await request.send();
      print(request);
if (response.statusCode == 200) print('Uploaded!');
    


    
    final resp = await http.Response.fromStream(response);

    if ( resp.statusCode != 200 && resp.statusCode != 201 ) {
      print('Algo salio mal');
      print( resp.body );
      return true;
    }

    final respData = json.decode(resp.body);
    print( respData);

    return true;
}else{
  var image='';
  print(mensaje.imageName==null);
  if(mensaje.imageName==null){image='null';}
  print('estoy apunto de editar');
  print(latitud);
  print(longitud);
var response = await http.post(url,body:{"informacion": mensaje.informacion,"imagename":image,"latitud":latitud,"longitud":longitud});
  

    print('pase por aca para la edicion');
    final respData = json.decode(response.body);
    print( respData);
  
    return true;


}











  

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

    Future<List<MensajeModel>> cargarMimuro(MensajeModel men,bool volver) async {
     if (volver==true){
       pagesMuro=0;
       lenghtMimuro=-1;
      mensajesMiMuro= new List();
     }
    if(men!=null){
      print(mensajesMiMuro.length);
      var i=-1;
      mensajesMiMuro.asMap().forEach((index,value){
          if(value.id==men.id){
            i=index;
             
            }

      }

      );
      mensajesMiMuro[i]=men;
      print(mensajesMiMuro[i].meGustas.users.length);
      return mensajesMiMuro;
      

    }else{  
    if(lenghtMimuro==mensajesMiMuro.length){}else{
    _cargando = true;
    pagesMuro++; 
    final url  = '$_url/mimuro?access_token=${ _prefs.token }&page=$pagesMuro&limit=$limit';
    final resp = await http.get(url);

    final Map<String,dynamic> decodedData = json.decode(resp.body);
    

    
    lenghtMimuro=decodedData['total_count'];


    decodedData['items'].forEach( (mens){

      final prodTemp = MensajeModel.fromJson(mens);
      
      print(prodTemp.imageName);
      
      print(prodTemp.id);
      mensajesMiMuro.add( prodTemp );

    } );

    // print( productos[0].id );
    _cargando = false;
    return mensajesMiMuro;
    }}
  }
  
  Future<List<MensajeModel>> cargarMensajesUsuarios(int usuario,MensajeModel men,bool volver) async {
      if (volver==true){
       pagesUsuarios=0;
       lenghtUsuarios=-1;
      mensajesUsuarios= new List();
     }


      if(men!=null){
      
      print(mensajesUsuarios[0].meGustas.users.length);
      var i=-1;
      mensajesUsuarios.asMap().forEach((index,value){
          if(value.id==men.id){
            i=index;
             
            }

      }

      );
      mensajesUsuarios[i]=men;
      print(mensajesUsuarios[i].meGustas.users.length);
      return mensajesUsuarios;
      

    }else{


    if(lenghtUsuarios==mensajesUsuarios.length){}else{
       _cargando = true;
    pagesUsuarios++; 
    final url  = '$_url/${usuario}/mensajes?access_token=${ _prefs.token }&page=$pagesUsuarios&limit=$limit';
    final resp = await http.get(url);

    final Map<String,dynamic> decodedData = json.decode(resp.body);
    

    print(decodedData);
    
    lenghtUsuarios=decodedData['total_count'];


    decodedData['items'].forEach( (mens){

      final prodTemp = MensajeModel.fromJson(mens);
      
      print(prodTemp.imageName);
      
      print(prodTemp.id);
      mensajesUsuarios.add( prodTemp );

    });

    // print( productos[0].id );
    _cargando = false;
    return mensajesUsuarios;
    }
    }
  }

 



    Future<List<MensajeModel>> darMeGusta(int id,String how,int usuario) async {
      
    /*final llamado = Uri.https(_url, '/busquedas/usuarios?access_token=${_prefs.token}', {
      'busqueda':query
    });*/
    final resp = await http.post(
      
      _url+'/megusta/${id}?access_token=${_prefs.token}',
    );
    
    final decodedData = json.decode(resp.body);
    switch (how){
      case 'miMuro':{
       
      return  cargarMimuro(MensajeModel.fromJson(decodedData[0]),false); 
      }
      break;
      case 'misMensajes':
      {
       
      return  cargarMisMensajes(MensajeModel.fromJson(decodedData[0]),false); 
      }
      break;
      case 'mensajesUsuario':
      {
       
      return  cargarMensajesUsuarios(usuario,MensajeModel.fromJson(decodedData[0]),false); 

      
      }
      break;

    }


  }
  

    Future<List<MensajeModel>> cargarMisMensajes(MensajeModel men,bool volver) async {
      if (volver==true){
       pagesMiPerfil=0;
      mensajesMiPerfil= new List();
      lenghtMiPerfil=-1;
     }

    if(men!=null){
      print(mensajesMiPerfil[0].meGustas.users.length);
      var i=-1;
      mensajesMiPerfil.asMap().forEach((index,value){
          if(value.id==men.id){
            i=index;
             
            }

      }

      );
      mensajesMiPerfil[i]=men;
      print(mensajesMiPerfil[0].meGustas.users.length);
      return mensajesMiPerfil;
      

    }else{  


      if(lenghtMiPerfil==mensajesMiPerfil.length){}else{
     _cargando = true;
    pagesMiPerfil++; 
    final url  = '$_url/mismensajes?access_token=${ _prefs.token }&page=$pagesMiPerfil&limit=$limit';
    final resp = await http.get(url);

   final Map<String,dynamic> decodedData = json.decode(resp.body);
    

    print(decodedData);
    
    lenghtMiPerfil=decodedData['total_count'];


    decodedData['items'].forEach( (mens){

      final prodTemp = MensajeModel.fromJson(mens);
      
      print(prodTemp.imageName);
      
      print(prodTemp.id);
      mensajesMiPerfil.add( prodTemp );

    });
    // print( productos[0].id );
    _cargando=false;
    return mensajesMiPerfil;
      }
  }
  }


  Future<int> borrarMensaje( int id ) async { 

    final url  = '$_url/eliminarMensaje/$id?access_token=${ _prefs.token }';
    final resp = await http.get(url);

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

