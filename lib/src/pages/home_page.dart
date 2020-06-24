import 'package:flutter/material.dart';
import 'package:formvalidation/src/bloc/mensaje_bloc.dart';
import 'package:formvalidation/src/utils/utils.dart' as utils;
import 'package:formvalidation/src/widget/crearlistado.dart';
import 'package:formvalidation/src/widget/crearpost.dart';

class HomePage extends StatefulWidget {
 
final MensajesBloc mensajesBloc;
final ConosidosBloc conosidosBloc;
HomePage({@required this.mensajesBloc,@required this.conosidosBloc});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final listController = new ScrollController(
   
  );
  /*if(utils.recienInicie==true){_handleRefresh();
  utils.recienInicie=false;}*/
  

       listController.addListener((){   
         var triggerFetchMoreSize =
        0.98 * listController.position.maxScrollExtent;   
         if (listController.position.pixels >
        triggerFetchMoreSize) {
          setState(() {
            
          widget.mensajesBloc.cargarMensajes();   
          }); 
    }    
      });
     final pageController = new ScrollController(
   
  );
  /*if(utils.recienInicie==true){_handleRefresh();
  utils.recienInicie=false;}*/
  

      
    return Scaffold(
      
      
      body:Stack(children: <Widget>[utils.crearFondo(context,null),_crearListado(context,widget.mensajesBloc,pageController,listController)]),
     // floatingActionButton: _crearBoton( context ),
    );
  }

  Widget _crearListado(BuildContext context,MensajesBloc mensajesBloc,ScrollController scrollController,ScrollController listController) {

 return RefreshIndicator(

       child: ListView(
         scrollDirection: Axis.vertical,
         controller: listController,
         shrinkWrap: true,
         children: <Widget>[
        
          crearPost(context,false,this),
           amigosSwiper(context,widget.conosidosBloc,widget.mensajesBloc),
         
      StreamBuilder(
          
          stream: mensajesBloc.mensajesStream,
          builder: (BuildContext context, AsyncSnapshot<List> snapshot){
            
            
            if ( snapshot.hasData ) {
              
              return CrearListado(mensajes: snapshot.data, scrollController: scrollController, mensajesBloc: mensajesBloc,conosidosBloc: widget.conosidosBloc,destroid: mensajesBloc.destroid,);


            } else  {
              return Center(child: CircularProgressIndicator()); /*ListView(children: <Widget>[crearPost(context,false),
                  amigosSwiper(context,widget.conosidosBloc)],);*/
            }
          },

    ),
         ]
        
        
       ),
     
     
     
     
   

 onRefresh: refresh,
 
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
  Future<void> refresh()async {
    setState(() {
      widget.mensajesBloc.destroid();
      widget.conosidosBloc.destroid();
    });

    return null;
  }
  

}
