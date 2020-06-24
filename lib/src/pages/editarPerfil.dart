import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formvalidation/src/bloc/provider.dart';
import 'package:formvalidation/src/models/user_model.dart';
import 'package:formvalidation/src/preferencias_usuario/usuario.dart';
import 'package:formvalidation/src/providers/usuario_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:formvalidation/src/utils/utils.dart' as utils;
import 'package:toast/toast.dart';

class EditarPerfil extends StatefulWidget {

  @override
  _EditarPerfilState createState() => _EditarPerfilState();
}

class _EditarPerfilState extends State<EditarPerfil> {

  @override
  final formKey     = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  UserModel userModel=userApp();
  bool _guardando = false;
  File imagePortada;
  File imageUser;
  bool fxuser=true;
  bool us=false;
  bool fxportada=true;
  @override
  
  Widget build(BuildContext context) {
  
    
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Editar Perfil'),
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
                _inicio(),
                _editarNombre(),
                
                Container(height: 3),
                _editarEmail(),
                Container(height: 3),
                Center(child: Text('Foto perfil',style: TextStyle(fontSize: 22,color: Color.fromRGBO(63, 63, 156, 1.0)),)),
                _mostrarFotoUser(),
                Container(height: 3),
                Center(child: Text('Foto portada',style: TextStyle(fontSize: 22,color: Color.fromRGBO(63, 63, 156, 1.0)),)),
                _mostrarFotoPortada(),
                Container(height: 3),
                _crearBotonDePublicacion(),
              ],
            ),
          ),
          SizedBox( height: 0.0 )
        ],
      ),
    ));


  }

  Widget _inicio(){
  return Container(
    margin: EdgeInsets.symmetric(vertical:10),
    child: Center(
          
      child: Text('Editar tu Pefil',style: TextStyle(fontSize: 30,color: Color.fromRGBO(63, 63, 156, 1.0))),
    ),
  );

  }

  Widget _editarNombre(){

      return Container(
        padding:  EdgeInsets.symmetric(horizontal: 20.0),
        child: TextFormField(
        textCapitalization: TextCapitalization.sentences,
        initialValue: userModel.username,
          decoration: InputDecoration(
            icon: Icon( Icons.person, color: Colors.deepPurple ),
            hintText: 'catarina 14',
            labelText:  'Nombre de usuario',
          ),
             validator: (value) {
          if ( value.length < 3 ) {
            return 'Ingrese un nombre de usario mas grande';
          } else {
            return null;
          }
        },
          onSaved: (value) => userModel.username= value,
           
        ),

      );
    
  

  }

    Widget _editarEmail(){
      

        
      return Container(
        padding:  EdgeInsets.symmetric(horizontal: 20.0),
        child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        initialValue: userModel.email,
          decoration: InputDecoration(
            icon: Icon( Icons.alternate_email, color: Colors.deepPurple ),
            hintText: 'ejemplo@correo.com',
            labelText: 'Correo electrónico',
          ),
          validator: (String value) {
          return value.contains('@') ? null: 'el mensaje debe tener un @algo';
          },
           onSaved: (value) => userModel.email= value,
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
        onPressed: ( _guardando ) ? null : _submit,
      );
  
    
  }

  void _submit() async {

    

    if ( !formKey.currentState.validate() ) return;

    formKey.currentState.save();

    setState(() {_guardando = true; });





      UsuarioProvider().editarUsuario(userModel.email, userModel.username, userModel.imageName, userModel.portada.imageName, imageUser, imagePortada);
      userApp().email=userModel.email;
      userApp().username=userModel.username;
      Toast.show("Perfil Editado !!", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);



    setState(() {_guardando = false; 
    
    });

    Navigator.pop(context);

  }





  Widget _mostrarFotoUser() {

    if ( userModel.imageName != null ) {
    
    
    return  Stack(alignment: Alignment.topRight,
      children: <Widget>[
      FadeInImage(
        image: NetworkImage( "${utils.url}/imagenes/user/"+userModel.imageName ),
        placeholder: AssetImage('assets/jar-loading.gif'),
       width: double.maxFinite,
        fit: BoxFit.contain,
      ),
      
      _crearBotonSacarFoto(true),]);
      
    } else {
      if(fxuser!=false){
       return Container(
         child:(imageUser==null)?unRow(true):
      
        Stack(alignment: Alignment.topRight,
                  children: <Widget>[
        Image(
        image: new FileImage(new File( imageUser?.path ?? 'assets/no-image.png')),
        
        fit: BoxFit.contain,

      ),
      _crearBotonSacarFoto(true),
                
      ])
         
       ); 
     /* (foto!=null)?
      Image(
        image: new FileImage(new File( foto?.path ?? 'assets/no-image.png')),
        
        fit: BoxFit.contain,

      )*/
      }else{return unRow(true);}
    }

  }

  Widget _mostrarFotoPortada() {

    if ( userModel.portada.imageName != null ) {
    
    
    return  Stack(alignment: Alignment.topRight,
      children: <Widget>[
      FadeInImage(
        image: NetworkImage( "${utils.url}/imagenes/portada/"+ userModel.portada.imageName  ),
        placeholder: AssetImage('assets/jar-loading.gif'),
       width: double.maxFinite,
        fit: BoxFit.contain,
      ),
      
      _crearBotonSacarFoto(false),]);
      
    } else {
      if(fxportada!=false){
       return Container(
         child:(imagePortada==null)?unRow(false):
      
        Stack(alignment: Alignment.topRight,
                  children: <Widget>[
        Image(
        image: new FileImage(new File( imagePortada?.path ?? 'assets/no-image.png')),
        
        fit: BoxFit.contain,

      ),
      _crearBotonSacarFoto(false),
                
      ])
         
       ); 
     /* (foto!=null)?
      Image(
        image: new FileImage(new File( foto?.path ?? 'assets/no-image.png')),
        
        fit: BoxFit.contain,

      )*/
      }else{return unRow(false);}
    }

  }


  _seleccionarFoto() async {
    _procesarImagen( ImageSource.gallery);

  }
  Widget unRow(bool user){
    user==true?us=true:us=false;
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          Container(
            
            child: IconButton(
              
              iconSize: 50,
              icon: Icon( Icons.photo_size_select_actual ),
              onPressed: _seleccionarFoto,
            ),
          ),
        
          Container(
            
            child: IconButton(
              iconSize: 50,
              icon: Icon( Icons.camera_alt ),
              onPressed: _tomarFoto,
            ),
          ),
      ],
      );
  }
  
  _tomarFoto() async {
    
    _procesarImagen( ImageSource.camera );

  }

  _procesarImagen( ImageSource origen) async {
    if(us==true){
        imageUser = await ImagePicker.pickImage(
      source: origen
    );

    if ( imageUser != null ) {
      userModel.imageName = null;
    }

    setState(() {fxuser=true;});


    }else{
    imagePortada = await ImagePicker.pickImage(
      source: origen
    );

    if ( imagePortada != null ) {
      userModel.portada.imageName = null;
    }

    setState(() {fxportada=true;});
    }
  } 

 Widget _crearBotonSacarFoto( bool user) {

   return IconButton(
      
      color: Colors.red,
      
      
      icon:Icon(FontAwesomeIcons.times,size: 30,),
      onPressed: (){setState((){
        if(user==true){userModel.imageName=null;fxuser=false;}
        else{
        userModel.portada.imageName=null;fxportada=false;
        }
        });}
    );
 }



}
