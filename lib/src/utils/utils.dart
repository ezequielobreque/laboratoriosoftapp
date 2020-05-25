import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:formvalidation/src/models/user_model.dart';

import 'package:formvalidation/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:formvalidation/src/providers/usuario_provider.dart';
import 'package:http/http.dart' as http;
bool isNumeric( String s ) {

  if ( s.isEmpty ) return false;

  final n = num.tryParse(s);

  return ( n == null ) ? false : true;

}

List<UserModel> seguidos= new List();
String url= 'http://192.168.100.104:8000';




void mostrarAlerta(BuildContext context, String mensaje ) {
 
  showDialog(
    context: context,
    builder: ( context ) {
      return AlertDialog(
        title: Text('Información incorrecta'),
        
        content: Text(mensaje),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: ()=> Navigator.of(context).pop(),
          )
        ],
      );
    }
  );



  
 


}
crearFondo(BuildContext context, String fondo){

    final size = MediaQuery.of(context).size;

    final fondoModaro = Container(
 
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/544750.jpg'),
          fit: BoxFit.cover,
          colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),
      
        ),
        gradient: LinearGradient(
          colors: <Color> [
            Color.fromRGBO(63, 63, 156, 1.0),
            Color.fromRGBO(90, 70, 178, 1.0)
          ]
        
        )
      
      ),
    );

    /*final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Color.fromRGBO(255, 255, 255, 0.05)
      ),
    );*/
  Widget fon= (fondo!=null)? (Container(      
          padding: EdgeInsets.only(top: 80.0),
          child: Column(
            children: <Widget>[
              
              Icon( Icons.person_pin_circle, color: Colors.white, size: 100.0 ),
              SizedBox( height: 10.0, width: double.infinity ),
              Text(fondo, style: TextStyle( color: Colors.white, fontSize: 25.0 ))
            ],
          ),
        )):Container();


    return Stack(
      children: <Widget>[
        fondoModaro,
        /*Positioned( top: 90.0, left: 30.0, child: circulo ),
        Positioned( top: -40.0, right: -30.0, child: circulo ),
        Positioned( bottom: -50.0, right: -10.0, child: circulo ),
        Positioned( bottom: 120.0, right: 20.0, child: circulo ),
        Positioned( bottom: -50.0, left: -20.0, child: circulo ),
        */
        fon
        

      ],
    );

  }


  cerrarSesion(BuildContext context){
      final _prefs = new PreferenciasUsuario();
    _prefs.token=null;
    _prefs.usuarioApp=[];
    Navigator.pushReplacementNamed(context, 'login');


  }


Future<String> fijarse() async {
   String initialRoute;
  final _prefs = new PreferenciasUsuario();
  if  (_prefs.token==null){
    initialRoute='login';
    
    }else{
    initialRoute='tapped';
    }
   
    if(initialRoute!='login'){
      final resp = await http.post(
      '${url}/api/sec/usuario?access_token=${_prefs.token}');
      final dynamic decodedData = json.decode(resp.body);
      
      print(decodedData);
      if (decodedData['error']=="invalid_grant"){
      
     return "login";
        

      }else{
        
      
        return "tapped";
      }

    }else{
    return "login";
    }
}
  misSeguidos() async {
  seguidos=await UsuarioProvider().amigos();
  print('mis seguidos:${seguidos}');
  }