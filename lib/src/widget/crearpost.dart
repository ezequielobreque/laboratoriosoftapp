import 'package:flutter/material.dart';
import 'package:formvalidation/src/preferencias_usuario/usuario.dart';
import 'package:formvalidation/src/utils/utils.dart' as utils;
Widget crearPost(BuildContext context){
  
    return Card(
  
    margin: EdgeInsets.only(top: 2, bottom:  10.0),
    elevation: 20,
    color: Colors.white,
      child: Row(
        
        children: <Widget>[
              
                  Container(
                    padding: EdgeInsets.only(left: 10.0),
                    child: CircleAvatar
                (

                      radius: 22.0,
                      backgroundImage:(userApp().imageName!=null)? NetworkImage("${utils.url}/imagenes/user/"+userApp().imageName)
                      :AssetImage('assets/perfil-no-image.jpg'),
                      backgroundColor: Colors.transparent,
                    ),
                  )

                    ,
              
          _crearRow(context)
        ],
      

      )
    );



  }

Widget _crearRow(BuildContext context) {

        
      return Container(
        padding: EdgeInsets.only(left: 10.0),
        width:MediaQuery.of(context).size.width * 0.80,
        
        child: RaisedButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0),side: BorderSide(width: 0.5,color: Colors.black)),
          color: Colors.white,
              onPressed: ()=>Navigator.pushNamed(context, 'mensaje'),
              child: Text('¿En que estas pensando?'),
          )
        
      );
  }