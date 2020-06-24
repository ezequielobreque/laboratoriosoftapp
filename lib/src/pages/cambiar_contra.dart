

import 'package:flutter/material.dart';
import 'package:formvalidation/src/bloc/login_bloc.dart';
import 'package:formvalidation/src/providers/usuario_provider.dart';
import 'package:formvalidation/src/utils/utils.dart' as utils;
import 'package:toast/toast.dart';


class CambiarContra extends StatefulWidget {

  @override
  _CambiarContraState createState() => _CambiarContraState();
}

class _CambiarContraState extends State<CambiarContra> {
    final usuarioProvider= new UsuarioProvider();
  String vieja;
  String nueva;
  @override
  void initState() {
    vieja='';
    nueva='';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('Ubicacion del mensaje'),),
      
        
      body: ListView(
        children: <Widget>[
          _crearPasswordVieja(),
          _crearPasswordNueva(),
          _crearBotonDePublicacion(),
            
        ],
      ),

    );
    
  }

  Widget _crearPasswordVieja() {

 

      return Container(
        padding:  EdgeInsets.symmetric(horizontal: 20.0),
        child: TextFormField(
        
          decoration: InputDecoration(
            icon: Icon( Icons.person, color: Colors.deepPurple ),
            hintText: 'contraseña vieja',
            labelText:  'Contraseña vieja',
          ),
        
        
          onChanged:(value)=>(vieja=value)
            
            
          
        ),

      );
    
  

  }

      Widget _crearPasswordNueva() {

 

      return Container(
        padding:  EdgeInsets.symmetric(horizontal: 20.0),
        child: TextFormField(
          
          decoration: InputDecoration(
            icon: Icon( Icons.person, color: Colors.deepPurple ),
            hintText: 'contraseña nueva',
            labelText:  'Contraseña',
          ),
        
        onChanged:(value){
         
          nueva=value;}
           
        ),

      );
    
  

  }

Widget _crearBotonDePublicacion() {
    
      
     
      return RaisedButton.icon(
        
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
        color: Colors.deepPurple,
        textColor: Colors.white,
        label: Text('Guardar'),
        icon: Icon( Icons.save ),
        onPressed: _submit,
      );
  
    
  }

  _submit() async {
    
    print(nueva);
    print(vieja);
    final info = await usuarioProvider.cambiarContra(nueva,vieja);
    print('llege');
    if ( info['ok'] ) {
      
       Toast.show("Contrasña cambiada!!", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
    } else {
      
      utils.mostrarAlerta( context, info['mensaje'] );
    }
     Navigator.pop(context);

    // Navigator.pushReplacementNamed(context, 'home');

  }
}