import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:formvalidation/src/bloc/mensaje_bloc.dart';
import 'package:formvalidation/src/bloc/provider.dart';
import 'package:formvalidation/src/models/mensaje_model.dart';

class HomePage extends StatelessWidget {
  
  
  @override
  Widget build(BuildContext context) {

    final mensajesBloc = Provider.mensajesBloc(context);
    mensajesBloc.cargarMensajes();

    return Scaffold(
      appBar: AppBar(
        title: Text('Home')
      ),
      body: _crearListado(mensajesBloc),
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

  Widget _crearItem(BuildContext context, MensajesBloc productosBloc, MensajeModel producto ) {

    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
     /* onDismissed: ( direccion )=> productosBloc.borrarProducto(producto.id),*/
      child: Card(
        child: Column(
          children: <Widget>[
           
            ( producto.imageName == null ) 
              ? Image(image: AssetImage('assets/no-image.png'))
              : FadeInImage(
                image: AdvancedNetworkImage( producto.imageName,
                      
                        useDiskCache: true,
                        cacheRule: CacheRule(maxAge: const Duration(days: 7)),
                        ) ,
                placeholder:AssetImage(  'assets/jar-loading.gif'),
                height: 300.0,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            
            ListTile(
              title: Text('${ producto.user.username }'),
              subtitle: Text( producto.informacion ),
              onTap: () => Navigator.pushNamed(context, 'producto', arguments: producto ),
            ),

          ],
        ),
      )
    );


    

  }


  _crearBoton(BuildContext context) {
    return FloatingActionButton(
      child: Icon( Icons.add ),
      backgroundColor: Colors.deepPurple,
      onPressed: ()=> Navigator.pushNamed(context, 'producto'),
    );
  }

}