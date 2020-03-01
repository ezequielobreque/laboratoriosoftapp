import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:formvalidation/src/bloc/mensaje_bloc.dart';
import 'package:formvalidation/src/bloc/provider.dart';
import 'package:formvalidation/src/models/mensaje_model.dart';
import 'package:formvalidation/src/preferencias_usuario/usuario.dart';
import 'package:formvalidation/src/utils/utils.dart' as utils;

class MiPerfilPage extends StatelessWidget {
  
  
  @override
  Widget build(BuildContext context) {
    
    final mensajesBloc = Provider.mensajesBloc(context);
    mensajesBloc.cargarMisMensajes();

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
               CircleAvatar(
            child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                 child: Image(image:(userApp().imageName!=null)? NetworkImage("${utils.url}/imagenes/user/"+userApp().imageName)
                 :AssetImage('assets/perfil-no-image.jpg'),
                 )
                 ),
            ),
               
              Text('  ${ mensaje.user.username }',style: TextStyle(fontSize: 23.0))
              ]
              ),
              subtitle: Text( mensaje.informacion,style: TextStyle(fontSize: 17.0), ),
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
                height: 300.0,
                width: double.infinity,
                fit: BoxFit.cover,
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