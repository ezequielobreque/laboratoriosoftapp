import 'dart:async';



class Validators {


  final validarEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: ( username, sink ) {


      /*Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regExp   = new RegExp(pattern);

      if ( regExp.hasMatch( email ) ) {
        sink.add( email );
      } else {
        sink.addError('Email no es correcto');
      }*/

        if ( username.length >= 4 ) {
        sink.add( username );
      } else {
        sink.addError('el nombre de usario es mayor a 4 caracteres por favor');
      }


    }
  );


  final validarPassword = StreamTransformer<String, String>.fromHandlers(
    handleData: ( password, sink ) {

      if ( password.length >= 3 ) {
        sink.add( password );
      } else {
        sink.addError('Más de 6 caracteres por favor');
      }

    }
  );


}