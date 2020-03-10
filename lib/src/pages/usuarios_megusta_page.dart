
import 'package:flutter/material.dart';
import 'package:formvalidation/src/bloc/mensaje_bloc.dart';
import 'package:formvalidation/src/bloc/provider.dart';
import 'package:formvalidation/src/models/mensaje_model.dart';
import 'package:formvalidation/src/utils/utils.dart' as utils;

class UsuariosMeGustaPage extends StatelessWidget {

  MensajesBloc mensajesBloc;
    MensajeModel mensaje= new MensajeModel();
  @override
  Widget build(BuildContext context) {
        mensajesBloc = Provider.mensajesBloc(context);




    final MensajeModel prodData = ModalRoute.of(context).settings.arguments;
    if ( prodData != null ) {
      mensaje = prodData;
    }
    return Scaffold(
        body:ListView(
              children: mensaje.meGustas.users.map( (user) {
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
                      
                      Navigator.pushNamed(context, 'detalle', arguments: user);
                    },
                  );
              }).toList()
        )


        );
    
  } 
  }
