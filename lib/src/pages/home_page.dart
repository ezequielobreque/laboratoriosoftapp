import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:formvalidation/src/bloc/mensaje_bloc.dart';
import 'package:formvalidation/src/bloc/provider.dart';
import 'package:formvalidation/src/models/mensaje_model.dart';
import 'package:formvalidation/src/utils/utils.dart' as utils;

class HomePage extends StatelessWidget {
  
  
  @override
  Widget build(BuildContext context) {
    
    final mensajesBloc = Provider.mensajesBloc(context);
    mensajesBloc.cargarMensajes();

    return Scaffold(
      
      
      body:Stack(children: <Widget>[utils.crearFondo(context,null),_crearListado(mensajesBloc)]),
      floatingActionButton: _crearBoton( context ),
    );
  }


  Widget _crearListado(MensajesBloc mensajesBloc ) {
    
    return StreamBuilder(
      stream: mensajesBloc.productosStream,
      builder: (BuildContext context, AsyncSnapshot<List<MensajeModel>> snapshot){
        
        
        if ( snapshot.hasData ) {

          final productos = snapshot.data;

          return ListView.builder(
            
            itemCount: productos.length,
            itemBuilder: (context, i) => _crearItem(context, mensajesBloc, productos[i] ),
          );

        } else {
          return Center( child: CircularProgressIndicator());
        }
      },
    );

  }

  Widget _crearItem(BuildContext context, MensajesBloc productosBloc, MensajeModel mensaje ) {
    
    return Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0 ),
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
      key: UniqueKey(),
      
     /* onDismissed: ( direccion )=> productosBloc.borrarProducto(producto.id),*/
      
        
        child: Column(
          
          children: <Widget>[
           ListTile(
              title:Row(children: <Widget>[
               CircleAvatar
            (
                radius: 22.0,
                backgroundImage:(mensaje.user.imageName!=null)? NetworkImage("${utils.url}/imagenes/user/"+mensaje.user.imageName)
                 :AssetImage('assets/perfil-no-image.jpg'),
                backgroundColor: Colors.transparent,
              )
            
             /*ClipRRect(
                  
                  borderRadius: BorderRadius.circular(20.0),
                 child: Image(image:(mensaje.user.imageName!=null)? NetworkImage("${utils.url}/imagenes/user/"+mensaje.user.imageName)
                 :AssetImage('assets/perfil-no-image.jpg'),
                 )
                 )*/
                 
                 ,
            
               
              Text('  ${ mensaje.user.username }',style: TextStyle(fontSize: 22.0))
              ]
              ),
              subtitle: Text( mensaje.informacion,style: TextStyle(fontSize: 18.5,color: Color.fromRGBO(44, 62, 80,1.0)), ),
              onTap: () => Navigator.pushNamed(context, 'mensaje', arguments: mensaje ),
            ),
            ( mensaje.imageName == null ) 
              ? Container(height:20 )
              : FadeInImage(
                image: AdvancedNetworkImage( "${utils.url}/imagenes/mensaje/"+mensaje.imageName,
                      
                        useDiskCache: true,
                        cacheRule: CacheRule(maxAge: const Duration(days: 7)),
                        ) ,
                placeholder:AssetImage(  'assets/jar-loading.gif'),
                
                width: double.maxFinite,
                fit: BoxFit.contain,
              ),
            
            

          ],
        ),
      );
    


    

  }


  _crearBoton(BuildContext context) {
    return FloatingActionButton(
      child: Icon( Icons.add ),
      backgroundColor: Colors.deepPurple,
      onPressed: ()=> Navigator.pushNamed(context, 'mensaje'),
    );
  }

}