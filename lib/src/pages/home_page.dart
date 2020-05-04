import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formvalidation/src/bloc/mensaje_bloc.dart';
import 'package:formvalidation/src/bloc/provider.dart';
import 'package:formvalidation/src/models/mensaje_model.dart';
import 'package:formvalidation/src/preferencias_usuario/usuario.dart';
import 'package:formvalidation/src/utils/utils.dart' as utils;
import 'package:formvalidation/src/widget/crearlistado.dart';

class HomePage extends StatelessWidget {
 
final MensajesBloc mensajesBloc;

HomePage({@required this.mensajesBloc});
  @override
  Widget build(BuildContext context) {
    

      

    return Scaffold(
      
      
      body:Stack(children: <Widget>[utils.crearFondo(context,null),_crearListado(mensajesBloc)]),
      floatingActionButton: _crearBoton( context ),
    );
  }

   Widget _footer(BuildContext context){

    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child: Text('Populares', style: Theme.of(context).textTheme.subhead  )
          ),
          SizedBox(height: 5.0),

          StreamBuilder(
            stream: peliculasProvider.popularesStream,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              
              if ( snapshot.hasData ) {
                return MovieHorizontal( 
                  peliculas: snapshot.data,
                  siguientePagina: peliculasProvider.getPopulares,
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),

        ],
      ),
    );
  


  Widget _crearListado(MensajesBloc mensajesBloc ) {
    
    return StreamBuilder(
      stream: mensajesBloc.mensajesStream,
      builder: (BuildContext context, AsyncSnapshot<List> snapshot){
        
        
        if ( snapshot.hasData ) {
          return CrearListado(mensajes: snapshot.data, siguientePagina: mensajesBloc.cargarMensajes, darmegusta: mensajesBloc.darMeGusta);


        } else {
          return Center( child: CircularProgressIndicator());
        }
      },
    );

  }

  

  _crearBoton(BuildContext context) {
    return FloatingActionButton(
      child: Icon( Icons.add ),
      backgroundColor: Colors.deepPurple,
      onPressed: ()=> Navigator.pushNamed(context, 'mensaje')
      /*.then((value) {
                  setState(() {});})*/,
    );
  }
}