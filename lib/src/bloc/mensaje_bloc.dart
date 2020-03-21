import 'dart:io';

import 'package:formvalidation/src/models/mensaje_model.dart';
import 'package:formvalidation/src/providers/mensajes_provider.dart';
import 'package:rxdart/rxdart.dart';



class MisMensajesBloc{

final _mensajesControllerMisMensajes = new BehaviorSubject<List<MensajeModel>>();

  final _mensajesProvider   = new MensajesProvider();

  final _cargandoController  = new BehaviorSubject<bool>();
    var m=0;

  Stream<List<MensajeModel>> get mensajesStream => _mensajesControllerMisMensajes.stream;
  
  Stream<bool> get cargando => _cargandoController.stream;
  
   void cargarMisMensajes() async {
    
    final mensajes = await _mensajesProvider.cargarMisMensajes();
     if(mensajes.length==m){

    }else{
        m=mensajes.length; 
    _mensajesControllerMisMensajes.sink.add( mensajes );
    }
  }
  void darMeGusta(int id) async {

    _cargandoController.sink.add(true);
    await _mensajesProvider.darMeGusta(id,'misMensajes');
    _cargandoController.sink.add(false);

  }

    dispose() {
    _mensajesControllerMisMensajes?.close();
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
    
    final mensajes = await _mensajesProvider.cargarMimuro(null);
    if(mensajes.length==m){

    }else{
     m=mensajes.length; 
    _mensajesControllerMensajes.sink.add( mensajes );
    }
  }
   

  


  void crearMensaje( MensajeModel mensaje ,File file) async {

    _cargandoController.sink.add(true);
    await _mensajesProvider.crearMensaje(mensaje,file);
    _cargandoController.sink.add(false);

  }
  void darMeGusta(int id) async {

    _cargandoController.sink.add(true);
    await _mensajesProvider.darMeGusta(id,'miMuro');
    _cargandoController.sink.add(false);

  }

  Future<String> subirFoto( File foto ) async {

    _cargandoController.sink.add(true);
    final fotoUrl = await _mensajesProvider.subirImagen(foto);
    _cargandoController.sink.add(false);

    return fotoUrl;

  }


   void editarMensaje( MensajeModel mensaje,File file ) async {

    _cargandoController.sink.add(true);
    await _mensajesProvider.editarMensaje(mensaje,file);
    _cargandoController.sink.add(false);

  }

  void borrarProducto( String id ) async {

    await _mensajesProvider.borrarMensaje(id);

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

    final mensajes = await _mensajesProvider.cargarMensajesUsuarios(id);
       if(mensajes.length==m){

    }else{
      m=mensajes.length; 
    _mensajesControllerMensajesUsuarios.sink.add( mensajes );
    }
  }
  void darMeGusta(int id) async {

    _cargandoController.sink.add(true);
    await _mensajesProvider.darMeGusta(id,'mensajesUsuario');
    _cargandoController.sink.add(false);

  }

    dispose() {
    _mensajesControllerMensajesUsuarios?.close();
    }
}