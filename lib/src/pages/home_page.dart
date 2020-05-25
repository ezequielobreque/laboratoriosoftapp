import 'package:flutter/material.dart';
import 'package:formvalidation/src/bloc/mensaje_bloc.dart';
import 'package:formvalidation/src/utils/utils.dart' as utils;
import 'package:formvalidation/src/widget/crearlistado.dart';
class HomePage extends StatelessWidget {
 
final MensajesBloc mensajesBloc;
final ConosidosBloc conosidosBloc;

HomePage({@required this.mensajesBloc,@required this.conosidosBloc});
  @override
  Widget build(BuildContext context) {
     final pageController = new ScrollController(
   
  );

       pageController.addListener((){   
         var triggerFetchMoreSize =
        0.9 * pageController.position.maxScrollExtent;   
         if (pageController.position.pixels >
        triggerFetchMoreSize) {mensajesBloc.cargarMensajes();    
    }    
      });   

    return Scaffold(
      
      
      body:Stack(children: <Widget>[utils.crearFondo(context,null),_crearListado(context,mensajesBloc,pageController)]),
      floatingActionButton: _crearBoton( context ),
    );
  }

 /* Widget _principal(BuildContext context,MensajesBloc mensajesBloc){
return Column(
      children:<Widget>[
        Expanded(child: _amigosSwiper(context),),
         Expanded(child:_crearListado(mensajesBloc))
        
        
      ]
      
      );



  }*/
  


  Widget _crearListado(BuildContext context,MensajesBloc mensajesBloc,ScrollController scrollController) {
 return
 /*   children:<Widget>[,
    Builder(
    builder: (BuildContext context){*/
      StreamBuilder(
        
        stream: mensajesBloc.mensajesStream,
        builder: (BuildContext context, AsyncSnapshot<List> snapshot){
          
          
          if ( snapshot.hasData ) {
            
            return CrearListado(mensajes: snapshot.data, scrollController: scrollController, darmegusta: mensajesBloc.darMeGusta,conosidosBloc: conosidosBloc,destroid: mensajesBloc.destroid,);


          } else {
            return Center( child: CircularProgressIndicator());
          }
        },
      
      
  
  
  );

  }
    
    
   /* )
    ]
  
  
    );
  
  }*/

  

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
