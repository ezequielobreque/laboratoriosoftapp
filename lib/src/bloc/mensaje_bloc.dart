import 'dart:io';

import 'package:formvalidation/src/models/mensaje_model.dart';
import 'package:formvalidation/src/models/user_model.dart';
import 'package:formvalidation/src/providers/mensajes_provider.dart';
import 'package:formvalidation/src/providers/usuario_provider.dart';
import 'package:rxdart/rxdart.dart';



class MisMensajesBloc{

final _mensajesControllerMisMensajes = new BehaviorSubject<List<MensajeModel>>();

  final _mensajesProvider   = new MensajesProvider();

  final _cargandoController  = new BehaviorSubject<bool>();
    var m=0;

  Stream<List<MensajeModel>> get mensajesStream => _mensajesControllerMisMensajes.stream;
  
  Stream<bool> get cargando => _cargandoController.stream;
  
   void cargarMisMensajes() async {
    
    final mensajes = await _mensajesProvider.cargarMisMensajes(null,false);
     if(mensajes.length==m){

    }else{
        m=mensajes.length; 
    _mensajesControllerMisMensajes.sink.add( mensajes );
    }
  }

    void destroy() async{
     _mensajesControllerMisMensajes.drain();
     m=0;
    final mensajes = await _mensajesProvider.cargarMisMensajes(null,true);
    if(mensajes.length==m){

    }else{
     m=mensajes.length; 
    _mensajesControllerMisMensajes.sink.add(mensajes);
    }
    }
      

  void darMeGusta(int id) async {

    _cargandoController.sink.add(true);
    await _mensajesProvider.darMeGusta(id,'misMensajes',0);
    
    _cargandoController.sink.add(false);

  }

    dispose() {
    _mensajesControllerMisMensajes?.close();
    }
}

class ConosidosBloc{

final _personasController = new BehaviorSubject<List<UserModel>>();

final _usuariosProvider   = new UsuarioProvider();

final _cargandoController  = new BehaviorSubject<bool>();
    var m=0;

  Stream<List<UserModel>> get conocidostream => _personasController.stream;
  
  Stream<bool> get cargando => _cargandoController.stream;
  
   void conocido() async {
    
    final usuarios = await _usuariosProvider.conocidos(false);
     if(usuarios.length==m){

    }else{
        m=usuarios.length; 
    _personasController.sink.add( usuarios );
    }
  }
     void destroid() async{
     _personasController.drain();
     m=0;
     final usuarios = await _usuariosProvider.conocidos(true);
     if(usuarios.length==m){
       if(usuarios.length==0){
         _personasController.drain();
       }

    }else{
        m=usuarios.length;
        print('la m $m'); 
    _personasController.sink.add( usuarios );
    }
      
   }

    dispose() {
   _personasController?.close();
    }
}

class AmigosBloc{

final _personasController = new BehaviorSubject<List<UserModel>>();

final _usuariosProvider   = new UsuarioProvider();

final _cargandoController  = new BehaviorSubject<bool>();
    var m=0;

  Stream<List<UserModel>> get conocidostream => _personasController.stream;
  
  Stream<bool> get cargando => _cargandoController.stream;
  
   void amigos() async {
    
    final usuarios = await _usuariosProvider.amigos();
     if(usuarios.length==m){

    }else{
        m=usuarios.length; 
    _personasController.sink.add( usuarios );
    }
  }

    dispose() {
   _personasController?.close();
    }
}






class MensajesBloc {

  final _mensajesControllerMensajes = new BehaviorSubject<List<MensajeModel>>();
  
  final _cargandoController  = new BehaviorSubject<bool>();

  final _mensajesProvider   = new MensajesProvider();
  


  Stream<List<MensajeModel>> get mensajesStream => _mensajesControllerMensajes.stream;
  
  Stream<bool> get cargando => _cargandoController.stream;
  var m=0;


   void cargarMensajes() async {
    
    final mensajes = await _mensajesProvider.cargarMimuro(null,false);
    if(mensajes.length==m){

    }else{
     m=mensajes.length; 
    _mensajesControllerMensajes.sink.add(mensajes);
    }
  }
   
   void destroid() async{
     _mensajesControllerMensajes.drain();
     m=0;
    final mensajes = await _mensajesProvider.cargarMimuro(null,true);
    if(mensajes.length==m){

    }else{
     m=mensajes.length; 
    _mensajesControllerMensajes.sink.add(mensajes);
    }
      
   }

  


  void crearMensaje( MensajeModel mensaje ,File file) async {

    _cargandoController.sink.add(true);
    await _mensajesProvider.crearMensaje(mensaje,file);
    _cargandoController.sink.add(false);

  }
  
 void darMeGusta(int id) async {

    
   final mensajes=await _mensajesProvider.darMeGusta(id,'miMuro',0);
 
    _mensajesControllerMensajes.sink.add(mensajes);
  //  mensajes.insert(0, men1);
  //_mensajesControllerMensajes.sink.add(mensajes);
   // final list= new List<MensajeModel>();
   // list.add(men1);
   
    

    
  
  }

  Future<String> subirFoto( File foto ) async {

    _cargandoController.sink.add(true);
    final fotoUrl = await _mensajesProvider.subirImagen(foto,);
    _cargandoController.sink.add(false);

    return fotoUrl;

  }


   void editarMensaje( MensajeModel mensaje,File file ) async {

    _cargandoController.sink.add(true);
    await _mensajesProvider.editarMensaje(mensaje,file);
    _cargandoController.sink.add(false);

  }

  void borrarMensaje( int id ) async {
    _cargandoController.sink.add(true);
    await _mensajesProvider.borrarMensaje(id);
    _cargandoController.sink.add(false);
  }


  dispose() {
    _mensajesControllerMensajes?.close();
    
    _cargandoController?.close();
  }

}
class MensajesUsuariosBloc{

  final _mensajesControllerMensajesUsuarios = new BehaviorSubject<List<MensajeModel>>();
  final _mensajesProvider   = new MensajesProvider();
  final _cargandoController  = new BehaviorSubject<bool>();
    var m=0;
  Stream<List<MensajeModel>> get mensajesStream => _mensajesControllerMensajesUsuarios.stream;
  
   void cargarMensajesUsuarios(int id) async {

    final mensajes = await _mensajesProvider.cargarMensajesUsuarios(id,null);
       if(mensajes.length==m){

    }else{
      m=mensajes.length; 
    _mensajesControllerMensajesUsuarios.sink.add( mensajes );
    }
  }
  void darMeGusta(int id) async {

    final mensajes= await _mensajesProvider.darMeGusta(id,'mensajesUsuario',0);
  
 
    _mensajesControllerMensajesUsuarios.sink.add(mensajes);

  }

    dispose() {
    _mensajesControllerMensajesUsuarios?.close();
    }
}