import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formvalidation/src/bloc/mensaje_bloc.dart';
import 'package:formvalidation/src/bloc/provider.dart';
import 'package:formvalidation/src/models/mensaje_model.dart';
import 'package:formvalidation/src/models/user_model.dart';
import 'package:formvalidation/src/preferencias_usuario/usuario.dart';
import 'package:formvalidation/src/utils/utils.dart' as utils;
import 'package:formvalidation/src/widget/crearItem.dart';
import 'package:formvalidation/src/widget/iniciousuario.dart';


class PerfilUsuarioPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    final cargarMensajesBloc = Provider.mensajesUsuariosBloc(context);
    UserModel usuario=(ModalRoute.of(context).settings.arguments);
    cargarMensajesBloc.cargarMensajesUsuarios(usuario.id);

    return Scaffold(

         appBar: AppBar(
        title: Text(usuario.username)),
      body:Stack(children: <Widget>[utils.crearFondo(context,null),_crearListado(usuario,cargarMensajesBloc)]),
      
    );
  }

  Widget _crearListado(UserModel usuario,MensajesUsuariosBloc misMensajesBloc ) {
   
    return StreamBuilder(
      stream: misMensajesBloc.mensajesStream,
      builder: (BuildContext context, AsyncSnapshot<List<MensajeModel>> snapshot){
        
        
        if ( snapshot.hasData ) {

          final productos = snapshot.data;

          return ListView.builder(
            
            itemCount: productos.length+1,
            itemBuilder: (context, i) =>(i==0)?
              
            InicioUsuario(user: usuario,context:context,yo:false): CrearItem(context:context,productosBloc: misMensajesBloc,mensaje: productos[i-1],user: userApp()),
          );

        } else {
          return Center( child: CircularProgressIndicator());
        }
      },
    );

  }

 

  _crearBoton(BuildContext context) {
    return FloatingActionButton(
      child: Icon( Icons.add ),
      backgroundColor: Colors.deepPurple,
      onPressed: ()=> Navigator.pushNamed(context, 'mensaje'),
    );
  }
}