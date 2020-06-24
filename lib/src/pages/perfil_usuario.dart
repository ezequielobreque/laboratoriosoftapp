import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formvalidation/src/bloc/mensaje_bloc.dart';
import 'package:formvalidation/src/bloc/provider.dart';
import 'package:formvalidation/src/models/mensaje_model.dart';
import 'package:formvalidation/src/models/user_model.dart';
import 'package:formvalidation/src/pages/producto_page.dart';
import 'package:formvalidation/src/preferencias_usuario/usuario.dart';
import 'package:formvalidation/src/utils/utils.dart' as utils;
import 'package:formvalidation/src/widget/crearItem.dart';
import 'package:formvalidation/src/widget/iniciousuario.dart';


class PerfilUsuarioPage extends StatefulWidget {
  UserModel usuario;
  PerfilUsuarioPage({@required this.usuario});

  @override
  _PerfilUsuarioPageState createState() => _PerfilUsuarioPageState();
}

class _PerfilUsuarioPageState extends State<PerfilUsuarioPage> {
  @override
  Widget build(BuildContext context) {
    
    final cargarMensajesBloc = Provider.mensajesUsuariosBloc(context);
    setState(() {
      
    cargarMensajesBloc.drenar(widget.usuario.id);
    });
     final pageController = new ScrollController(
   
  );

    return Scaffold(
      
       
         appBar: AppBar( 
        title: Text(widget.usuario.username)),
      body:Stack(children: <Widget>[utils.crearFondo(context,null),_crearListado(widget.usuario,cargarMensajesBloc,pageController)]),
      
    );
  }

  Widget _crearListado(UserModel usuario,MensajesUsuariosBloc misMensajesBloc,ScrollController scrollController) {
  
    return ListView(
      children:<Widget>[ 
        
        InicioUsuario(user: usuario,context:context,yo:false),
        StreamBuilder(
          
        stream: misMensajesBloc.mensajesStream,
        builder: (BuildContext context, AsyncSnapshot<List<MensajeModel>> snapshot){
          
          
          if ( snapshot.hasData ) {

            final productos = snapshot.data;

            return ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: productos.length,
              itemBuilder: (context, i) =>
                
             CrearItem(context:context,productosBloc: misMensajesBloc,mensaje: productos[i],user: userApp()),
            );

          } else {
                return Center(child:CircularProgressIndicator());
          }
        },
      ),
      ]
    );

  }

  _crearBoton(BuildContext context) {
    return FloatingActionButton(
      child: Icon( Icons.add ),
      backgroundColor: Colors.deepPurple,
       onPressed:(){
       Navigator.push(
              context,
        MaterialPageRoute(builder:(context)=>MensajePage(mensajemod: null)));
       },
    );
  }

  
}