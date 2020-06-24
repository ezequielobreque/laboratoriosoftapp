import 'dart:convert';
import 'dart:io';
import 'package:formvalidation/src/preferencias_usuario/usuario.dart';
import 'package:http/http.dart' as http;
import 'package:formvalidation/src/models/user_model.dart';
import 'package:formvalidation/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:mime_type/mime_type.dart';
import 'package:http_parser/http_parser.dart';
import '../utils/utils.dart' as utils;

class UsuarioProvider {

  var pagesConocidos=0;
  var limit=10;
  var _cargando = false;
  List<UserModel> conocidoss = new List();
  var lenghtConocidos=-1;
 


  final String _firebaseToken = 'AIzaSyAO749eZf3E35cmxgZA06mRygilezkNVsM';
  final _prefs = new PreferenciasUsuario();

  Future<Map<String, dynamic>> login( String username, String password) async {


    var _bodyToken = new Map<String, dynamic>();
    _bodyToken['grant_type'] = 'password';
    _bodyToken['client_id'] ='5_hajy7d5sbg8wgsgcswwoowsswg44s0c8gwc8w80kwokogoogs';//'1_1jrqbyv8if0g8c8c800ksk00s0kkws4k0k4ok0sck8c8scs4gw';//
    _bodyToken['client_secret'] ='dnpzpa49nzksccwwo8wk88g0co4cc4swosg4gg0ocgsg40csw'; //'5q3zub1jj9c0kw8ok84kgcs8sgg0w8cs00888os0kk0kk4cwoo';//
    _bodyToken['username'] = username;
    _bodyToken['password'] = password;
/*1_1wvefv1u14cgw0sg0s4k444ccwo4oowwg4kogck08c0gwkgcwo   4bsbp0z49wg0s0gckwgg4gkgwkcoo0cog08w84kggccsw
sgocg*/


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

  Future addSeguidor(int id,UserModel user) async {
      
    /*final llamado = Uri.https(_url, '/busquedas/usuarios?access_token=${_prefs.token}', {
      'busqueda':query
    });*/
    
  final String _url = '${utils.url}/api/sec';
    final resp = await http.post(
      
      _url+'/seguiramigo/${id}?access_token=${_prefs.token}',
    );
    
    final decodedData = json.decode(resp.body);
    
    print(decodedData['loSigo']);
    print('el${id}');
    var vara=false;
    utils.seguidos.forEach((f){(f.id==id)?vara=true:null;});
    
    if(vara==true){


      utils.seguidos.removeWhere((v)=>v.id==id);
      utils.seguidos.forEach((f){print(f.id);});


      

    }else{
      utils.seguidos.add(user);
    }

  }

  Future<List<UserModel>> conocidos(bool volver) async {
      if (volver==true){
       pagesConocidos=0;
      conocidoss= new List();
      lenghtConocidos=-1;
     }
    
  final String _url = '${utils.url}/api/sec';
  
    if(lenghtConocidos==conocidoss.length){}else{
    _cargando = true;
    pagesConocidos++; 
    
    final url  = '$_url/amigos?access_token=${ _prefs.token }&page=$pagesConocidos&limit=3';
    final resp = await http.get(url);

    final Map<String,dynamic> decodedData = json.decode(resp.body);
    

   // print(decodedData);
    
    lenghtConocidos=decodedData['total_count'];


    decodedData['items'].forEach( (user){

      final prodTemp = UserModel.fromJson(user);
      
      print(prodTemp.imageName);
      
      print(prodTemp.id);
      if(prodTemp.id!=userApp().id){
      conocidoss.add( prodTemp );
      }
    });
    _cargando = false;
    print(conocidoss.length);
    return conocidoss;
    }
    
  }

  Future<List<UserModel>> amigos() async {
   
  final String _url = '${utils.url}/api/sec';
  
    

    final url  = '$_url/seguidos?access_token=${_prefs.token}';
    final resp = await http.get(url);
     
    final List<dynamic> decodedData = json.decode(resp.body);
    
  List<UserModel> amigos = new List();

 
  decodedData.forEach((v) => amigos.add(UserModel.fromJson(v)) ); 

   
    return amigos;
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

    print(decodedResp['mensaje']);

    if ( decodedResp['mensaje'].containsKey('id') ) {
      

      return { 'ok': true, 'mensaje': decodedResp['mensaje'] };
    } else {
      return { 'ok': false, 'mensaje': decodedResp['error']['message'] };
    }


  }
  

  Future<Map<String, dynamic>> cambiarContra(String nueva, String vieja ) async {
    print(vieja);
    print(nueva);
    final informacion = {
      "vieja" : vieja,
      "nueva": nueva
    };
    

    final resp = await http.post(
      
      '${utils.url}/api/sec/cambiar_contrasenia?access_token=${_prefs.token}',
      headers: {"Content-Type": "application/json"},
      body: json.encode(informacion)
    );

    Map<String, dynamic> decodedResp = json.decode( resp.body );

    print(decodedResp['resultado']);

    if ( decodedResp['resultado']!='bien' ) {
      
      
      return { 'ok': false, 'mensaje': 'hubo un error con la contraseña anterior' };
    } else {
      return { 'ok': true, 'mensaje': 'Felicidades contraseña cambiada' };
    }


  }



 Future<Map<String, dynamic>> editarUsuario( String email,String username,String rutaUser,String rutaPortada,File imageNameUser,File imageNamePortada ) async {
   
  final String _url = '${utils.url}/api/sec';
   final url = Uri.parse('$_url/editarperfil?access_token=${_prefs.token}');
    var mimeTypePortada;
   var  mimeTypeUser;
   http.MultipartRequest request;
 

   if(imageNameUser!=null){
     mimeTypeUser = mime(imageNameUser.path).split('/');
   }
   if(imageNamePortada!=null){
     
     mimeTypePortada = mime(imageNamePortada.path).split('/');
   }
   
  if(imageNamePortada!=null && imageNameUser!=null){
     
      request = http.MultipartRequest('POST', url)
        ..fields['email'] = email
        ..fields['username'] = username
        ..files.add(await http.MultipartFile.fromPath(
      'imageportada',
       imageNamePortada.path,
      contentType: MediaType( mimeTypePortada[0], mimeTypePortada[1] )
          )
          )
     ..files.add(await http.MultipartFile.fromPath(
      'imageuser',
      imageNameUser.path,
      contentType: MediaType( mimeTypeUser[0], mimeTypeUser[1] )
          ));

   }else if(imageNamePortada!=null || imageNameUser!=null){
     
   print('Estoy en editar usuario\n\n\n $email $username $rutaUser $rutaPortada $imageNamePortada $imageNameUser');
  
   String imageuser2;
  if(rutaUser==null){imageuser2='null';}else{imageuser2=rutaUser;}
  String imageportada2;
  if(rutaPortada==null){imageportada2='null';}{imageportada2=rutaPortada;}
     if(imageNamePortada!=null ){
       print('llege hasta aca');
     request = http.MultipartRequest('POST', url)
        ..fields['email'] = email
        ..fields['username'] = username
        ..fields['imagenameuser']=imageuser2
         ..files.add(await http.MultipartFile.fromPath(
      'imageportada',
       imageNamePortada.path,
      contentType: MediaType( mimeTypePortada[0], mimeTypePortada[1] )
          )
          );}else{
           
      request = http.MultipartRequest('POST', url)
        ..fields['email'] = email
        ..fields['username'] = username
        ..fields['imagenameportada'] = imageportada2
       ..files.add(await http.MultipartFile.fromPath(
      'imageuser',
      imageNameUser.path,
      contentType: MediaType( mimeTypeUser[0], mimeTypeUser[1] )
          ));
          
          }
    }else{
       var imageuser='';
  if(rutaUser==null){imageuser='null';}
      var imageportada='';
  if(rutaPortada==null){imageportada='null';}
  
     var response = await http.post(url,body:{"username": username,"email":email,"imagenameportada":imageportada,"imagenameuser":imageuser});
  
    final respData = json.decode(response.body);
    print(respData);
    _prefs.usuarioApp=respData;
    return respData['id'];
    
    }      
    
    print(request.fields);
    var response = await request.send();
    print(request);
    if (response.statusCode == 200) print('Uploaded!');
        


    
    final resp = await http.Response.fromStream(response);

    if ( resp.statusCode != 200 && resp.statusCode != 201 ) {
      print('Algo salio mal');
      print( resp.body );
      return null;
    }
  
    final respData = json.decode(resp.body);
     print(respData);
    _prefs.usuarioApp=respData;
    
    return respData;
    
  }

}
