import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formvalidation/src/utils/utils.dart' as utils;


class SettingsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
          
          leading: Icon( FontAwesomeIcons.cog),
          title: Text('Configuracion y privacidad',style:TextStyle(fontSize: 22)),
          onTap: (){},
          trailing: Icon(Icons.keyboard_arrow_right),
          
        ),
        ListTile(
          
          leading: Icon( FontAwesomeIcons.signOutAlt),
          title: Text('Cerrar sesion',style:TextStyle(fontSize: 22)),
          onTap: (){utils.cerrarSesion(context);},
          trailing: Icon(Icons.keyboard_arrow_right),
          
        ),

      ],

    );


  
  }
}