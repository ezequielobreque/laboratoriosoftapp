import 'package:flutter/material.dart';

import 'package:formvalidation/src/bloc/login_bloc.dart';
import 'package:formvalidation/src/bloc/mensaje_bloc.dart';
export 'package:formvalidation/src/bloc/login_bloc.dart';



class Provider extends InheritedWidget {

  final loginBloc     = new LoginBloc();
  final _mensajesBloc = new MensajesBloc();
  final _misMensajesBloc = new MisMensajesBloc();

  final _mensajesUsuariosBloc = new MensajesUsuariosBloc();
  
  final _conocidosBloc = new ConosidosBloc();


  static Provider _instancia;

  factory Provider({ Key key, Widget child }) {

    if ( _instancia == null ) {
      _instancia = new Provider._internal(key: key, child: child );
    }

    return _instancia;

  }

  Provider._internal({ Key key, Widget child })
    : super(key: key, child: child );


  

  // Provider({ Key key, Widget child })
  //   : super(key: key, child: child );

 
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static LoginBloc of ( BuildContext context ){
   return context.dependOnInheritedWidgetOfExactType<Provider>().loginBloc;
}
  static MensajesBloc mensajesBloc ( BuildContext context ){
   return context.dependOnInheritedWidgetOfExactType<Provider>()._mensajesBloc;
}
 static MisMensajesBloc misMensajesBloc ( BuildContext context ){
   return context.dependOnInheritedWidgetOfExactType<Provider>()._misMensajesBloc;
}
static MensajesUsuariosBloc mensajesUsuariosBloc ( BuildContext context ){
   return context.dependOnInheritedWidgetOfExactType<Provider>()._mensajesUsuariosBloc;
}
static ConosidosBloc conocidosBloc ( BuildContext context ){
   return context.dependOnInheritedWidgetOfExactType<Provider>()._conocidosBloc;
}
static ConosidosBloc amigosBloc ( BuildContext context ){
   return context.dependOnInheritedWidgetOfExactType<Provider>()._conocidosBloc;
}


}