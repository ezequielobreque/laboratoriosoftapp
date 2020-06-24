import 'package:flutter/material.dart';
import 'package:formvalidation/src/bloc/mensaje_bloc.dart';
import 'package:formvalidation/src/bloc/provider.dart';
import 'package:formvalidation/src/pages/producto_page.dart';
import 'package:formvalidation/src/preferencias_usuario/usuario.dart';
import 'package:formvalidation/src/utils/utils.dart' as utils;
Widget crearPost(BuildContext context,bool publicaciones,dynamic parent){

    
   
    return Container(
      
    margin: EdgeInsets.only(top: 4, bottom:  10.0,left: 2,right: 2),
    
    decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 3.0,
                  offset: Offset(0.0, 5.0),
                  spreadRadius: 3.0
                )
              ]
            ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          publicaciones?
          Container(margin: EdgeInsets.symmetric(horizontal: 10),
            child: Text('Publicaciones',style: TextStyle(fontSize: 25),)):
            Container(),
          Row(
            
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
                  
              _crearRow(context,parent)
            ],
          

          ),
        ],
      )
    );



  }

Widget _crearRow(BuildContext context,dynamic parent) {

        
      return Container(
        padding: EdgeInsets.only(left: 10.0),
        width:MediaQuery.of(context).size.width * 0.80,
        
        child: RaisedButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0),side: BorderSide(width: 0.5,color: Colors.black)),
          color: Colors.white,
               onPressed:(){
                Navigator.push(
                     context,
                 MaterialPageRoute(builder:(context)=>MensajePage(mensajemod:null))).then((value){ parent.refresh();});
                },
              child: Text('¿En que estas pensando?'),
          )
        
      );
    
  }
  