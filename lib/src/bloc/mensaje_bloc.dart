import 'dart:io';

import 'package:formvalidation/src/models/mensaje_model.dart';
import 'package:formvalidation/src/providers/mensajes_provider.dart';
import 'package:rxdart/rxdart.dart';





class MensajesBloc {

  final _mensajesController = new BehaviorSubject<List<MensajeModel>>();
  final _cargandoController  = new BehaviorSubject<bool>();

  final _mensajesProvider   = new MensajesProvider();


  Stream<List<MensajeModel>> get productosStream => _mensajesController.stream;
  Stream<bool> get cargando => _cargandoController.stream;



  void cargarMensajes() async {

    final mensajes = await _mensajesProvider.cargarMimuro();
    _mensajesController.sink.add( mensajes );
  }

   void cargarMisMensajes() async {

    final mensajes = await _mensajesProvider.cargarMisMensajes();
    _mensajesController.sink.add( mensajes );
  }


  void crearMensaje( MensajeModel mensaje ,File file) async {

    _cargandoController.sink.add(true);
    await _mensajesProvider.crearMensaje(mensaje,file);
    _cargandoController.sink.add(false);

  }

  Future<String> subirFoto( File foto ) async {

    _cargandoController.sink.add(true);
    final fotoUrl = await _mensajesProvider.subirImagen(foto);
    _cargandoController.sink.add(false);

    return fotoUrl;

  }


   void editarMensaje( MensajeModel mensaje ) async {

    _cargandoController.sink.add(true);
    await _mensajesProvider.editarMensaje(mensaje);
    _cargandoController.sink.add(false);

  }

  void borrarProducto( String id ) async {

    await _mensajesProvider.borrarMensaje(id);

  }


  dispose() {
    _mensajesController?.close();
    _cargandoController?.close();
  }

}