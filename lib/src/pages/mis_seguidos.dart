import 'package:flutter/material.dart';
import 'package:formvalidation/src/bloc/mensaje_bloc.dart';
import 'package:formvalidation/src/bloc/provider.dart';
import 'package:formvalidation/src/models/mensaje_model.dart';
import 'package:formvalidation/src/pages/perfil_usuario.dart';
import 'package:formvalidation/src/preferencias_usuario/usuario.dart';
import 'package:formvalidation/src/utils/utils.dart' as utils;

class MisSeguidosPage extends StatefulWidget {

  @override
  _MisSeguidosPageState createState() => _MisSeguidosPageState();
}

class _MisSeguidosPageState extends State<MisSeguidosPage> {
  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
         appBar: AppBar(
        title: Text('Usuarios que sigo')),
        body:ListView(
              children: utils.seguidos.map( (user) {
                  return ListTile(
                    leading:CircleAvatar(
                      radius: 22.0,
                      
                      backgroundImage:(user.imageName!=null)? NetworkImage('${utils.url}/imagenes/user/${user.imageName}')
                        :AssetImage('assets/perfil-no-image.jpg'),
                      backgroundColor: Colors.transparent,
                    ),
                    title: Text( user.username ),
                    subtitle: Text( user.email),
                    onTap: (){
                      user.id!=userApp().id?
                    Navigator.push(
              context,
                      MaterialPageRoute(builder:(context)=>PerfilUsuarioPage(usuario:user))).then((value){_handleRefresh();}):(){};
                    },
                  );
              }).toList()
        )

          
        );
    
  } 

    Future<void> _handleRefresh()async {
    final mensajes= Provider.mensajesBloc(context);
    final  usuarios= Provider.conocidosBloc(context);
    setState(() {
    mensajes.destroid();
    usuarios.destroid();
    });

    return null;
  }
}