import 'dart:io';

import 'package:formvalidation/src/models/mensaje_model.dart';
import 'package:formvalidation/src/providers/mensajes_provider.dart';
import 'package:rxdart/rxdart.dart';

import 'package:formvalidation/src/models/producto_model.dart';




class MensajesBloc {

  final _mensajesController = new BehaviorSubject<List<MensajeModel>>();
  final _cargandoController  = new BehaviorSubject<bool>();

  final _mensajesProvider   = new MensajesProvider();


  Stream<List<MensajeModel>> get productosStream => _mensajesController.stream;
  Stream<bool> get cargando => _cargandoController.stream;



  void cargarProductos() async {

    final mensajes = await _mensajesProvider.cargarProductos();
    _mensajesController.sink.add( mensajes );
  }


  void agregarProducto( MensajeModel mensaje ) async {

    _cargandoController.sink.add(true);
    await _mensajesProvider.crearProducto(mensaje);
    _cargandoController.sink.add(false);

  }

  Future<String> subirFoto( File foto ) async {

    _cargandoController.sink.add(true);
    final fotoUrl = await _mensajesProvider.subirImagen(foto);
    _cargandoController.sink.add(false);

    return fotoUrl;

  }


   void editarProducto( ProductoModel producto ) async {

    _cargandoController.sink.add(true);
    await _mensajesProvider.editarProducto(producto);
    _cargandoController.sink.add(false);

  }

  void borrarProducto( String id ) async {

    await _mensajesProvider.borrarProducto(id);

  }


  dispose() {
    _mensajesController?.close();
    _cargandoController?.close();
  }

}