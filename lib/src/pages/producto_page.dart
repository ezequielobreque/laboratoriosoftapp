import 'dart:io';

import 'package:flutter/material.dart';
import 'package:formvalidation/src/bloc/mensaje_bloc.dart';
import 'package:formvalidation/src/bloc/provider.dart';
import 'package:formvalidation/src/models/mensaje_model.dart';
import 'package:formvalidation/src/preferencias_usuario/usuario.dart';
import 'package:image_picker/image_picker.dart';

import 'package:formvalidation/src/utils/utils.dart' as utils;



class MensajePage extends StatefulWidget {

  @override
  _MensajePageState createState() => _MensajePageState();
}

class _MensajePageState extends State<MensajePage> {
  
  final formKey     = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  
  MensajesBloc mensajesBloc;
  MensajeModel mensaje = new MensajeModel();
  bool _guardando = false;
  File foto;
  var _user=userApp();
  @override
  Widget build(BuildContext context) {

    mensajesBloc = Provider.mensajesBloc(context);


    final MensajeModel prodData = ModalRoute.of(context).settings.arguments;
    if ( prodData != null ) {
      mensaje = prodData;
    }
    
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Mensaje'),
        actions: <Widget>[
          IconButton(
            icon: Icon( Icons.photo_size_select_actual ),
            onPressed: _seleccionarFoto,
          ),
          IconButton(
            icon: Icon( Icons.camera_alt ),
            onPressed: _tomarFoto,
          ),
        ],
      ),
      body: Stack(

       children:<Widget>[ 
        utils.crearFondo(context,null),
        _container(context)
      
      
      ]),
      /*body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                _mostrarNombre(),
                _mostrarFoto(),
                //_crearNombre(),
                //_crearPrecio(),
                //_crearDisponible(),
                _crearBoton()
              ],
            ),
          ),
        ),
      ),*/
    );

  }

  Widget _container(BuildContext context) {
    
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      
      child: Form(
        key: formKey,
        child: Column(
        children: <Widget>[

          SafeArea(
            child: Container(
              height: 10.0,
            ),
          ),

          Container(
            width: size.width * 0.97,
            margin: EdgeInsets.symmetric(vertical: 5.0),
            padding: EdgeInsets.symmetric( vertical: 10.0 ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
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
              children: <Widget>[
                _mostrarNombre(),
                _crearInformacion(),
                _mostrarFoto(),
                _crearBoton()
              ],
            ),
          ),
          SizedBox( height: 0.0 )
        ],
      ),
    ));


  }


  Widget _mostrarNombre(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
      
      children: <Widget>[
      CircleAvatar(
        
        
        child: ClipRRect(
          
          borderRadius: BorderRadius.circular(20.0),
          child: Image(image: NetworkImage("${utils.url}/imagenes/user/"+userApp().imageName),
        
        
        )
        
        ),
  
      ),
      Text('  '+_user.username[0].toUpperCase()+_user.username.substring(1),style: TextStyle(
      fontSize: 20.0
      ),
      ),
  
      ],

      ),
    );
    

  }

  Widget _crearInformacion() {


      
    return Container(
      padding:  EdgeInsets.symmetric(horizontal: 20.0),
          child: TextFormField(
            
        initialValue: mensaje.informacion,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
         
          border:OutlineInputBorder(),
          hintText: '¿En que estas pensando?',
            ),
        onSaved: (value) => mensaje.informacion= value,
        validator: (value) {
          if ( value.length < 3 ) {
            return 'Ingrese el nombre del Mensaje';
          } else {
            return null;
          }
        },
      ),
    );

  }

  /*Widget _crearPrecio() {
    return TextFormField(
      initialValue: mensaje.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'Precio'
      ),
      onSaved: (value) => mensaje.valor = double.parse(value),
      validator: (value) {

        if ( utils.isNumeric(value)  ) {
          return null;
        } else {
          return 'Sólo números';
        }

      },
    );
  }*/

 /* Widget _crearDisponible() {

    return SwitchListTile(
      value: mensaje.disponible,
      title: Text('Disponible'),
      activeColor: Colors.deepPurple,
      onChanged: (value)=> setState((){
        mensaje.disponible = value;
      }),
    );

  }*/



  Widget _crearBoton() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)
      ),
      color: Colors.deepPurple,
      textColor: Colors.white,
      label: Text('Guardar'),
      icon: Icon( Icons.save ),
      onPressed: ( _guardando ) ? null : _submit,
    );
  }

  void _submit() async {

    

    if ( !formKey.currentState.validate() ) return;

    formKey.currentState.save();

    setState(() {_guardando = true; });




    if ( mensaje.id == null ) {
      mensajesBloc.crearMensaje(mensaje,foto);
    } else {
      mensajesBloc.editarMensaje(mensaje);
    }


    setState(() {_guardando = false; });
    mostrarSnackbar('Registro guardado');

    Navigator.pop(context);

  }


  void mostrarSnackbar(String mensaje) {

    final snackbar = SnackBar(
      content: Text( mensaje ),
      duration: Duration( seconds: 5),
    );

    scaffoldKey.currentState.showSnackBar(snackbar);

  }


  Widget _mostrarFoto() {

    if ( mensaje.imageName != null ) {
      
      return FadeInImage(
        image: NetworkImage( "${utils.url}/imagenes/mensaje/"+mensaje.imageName ),
        placeholder: AssetImage('assets/jar-loading.gif'),
        width: double.infinity,
        
        
        fit: BoxFit.contain,
      );

    } else {

      return Image(
        image: new FileImage(new File( foto?.path ?? 'assets/no-image.png')),
        height: 300.0,
        fit: BoxFit.contain,

      );

    }

  }


  _seleccionarFoto() async {
    _procesarImagen( ImageSource.gallery );

  }
  
  
  _tomarFoto() async {

    _procesarImagen( ImageSource.camera );

  }

  _procesarImagen( ImageSource origen ) async {

    foto = await ImagePicker.pickImage(
      source: origen
    );

    if ( foto != null ) {
      mensaje.imageName = null;
    }

    setState(() {});

  }


}



