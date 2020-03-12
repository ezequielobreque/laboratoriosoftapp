
import 'package:flutter/material.dart';
import 'package:formvalidation/src/bloc/mensaje_bloc.dart';
import 'package:formvalidation/src/bloc/provider.dart';
import 'package:formvalidation/src/models/mensaje_model.dart';
import 'package:formvalidation/src/models/user_model.dart';
import 'package:formvalidation/src/preferencias_usuario/usuario.dart';
import 'package:formvalidation/src/utils/utils.dart' as utils;

class PerfilUsuarioPage extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    
    final cargarMensajesBloc = Provider.mensajesUsuariosBloc(context);
    UserModel usuario=(ModalRoute.of(context).settings.arguments);
    cargarMensajesBloc.cargarMensajesUsuarios(usuario.id);

    return Scaffold(
      
         appBar: AppBar(
        title: Text(usuario.username)),
      body:Stack(children: <Widget>[utils.crearFondo(context,null),_crearListado(cargarMensajesBloc)]),
      
    );
  }


  Widget _crearListado(MensajesUsuariosBloc misMensajesBloc ) {
    
    return StreamBuilder(
      stream: misMensajesBloc.mensajesStream,
      builder: (BuildContext context, AsyncSnapshot<List<MensajeModel>> snapshot){
        
        
        if ( snapshot.hasData ) {

          final productos = snapshot.data;

          return ListView.builder(
            
            itemCount: productos.length,
            itemBuilder: (context, i) => _crearItem(context, misMensajesBloc, productos[i] ),
          );

        } else {
          return Center( child: CircularProgressIndicator());
        }
      },
    );

  }

  Widget _crearItem(BuildContext context, MensajesUsuariosBloc productosBloc, MensajeModel mensaje ) {
    
    return GestureDetector(

          onTap: () => Navigator.pushNamed(context, 'mensaje', arguments: mensaje ),
          child: Container(
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
                backgroundImage:(userApp().imageName!=null)? NetworkImage("${utils.url}/imagenes/user/"+userApp().imageName)
                   :AssetImage('assets/perfil-no-image.jpg'),
                backgroundColor: Colors.transparent,
              ),
                 
                Text('  ${ mensaje.user.username }',style: TextStyle(fontSize: 22.0))
                ]
                ),
                subtitle: Text( mensaje.informacion,style: TextStyle(fontSize: 18.5,color: Color.fromRGBO(44, 62, 80,1.0)), ),
              ),
              ( mensaje.imageName == null ) 
                ? Container(height:20 )
                : FadeInImage(
                  image: NetworkImage( "${utils.url}/imagenes/mensaje/"+mensaje.imageName,
                        
                          ) ,
                  placeholder:AssetImage(  'assets/jar-loading.gif'),
                  
                  width: double.maxFinite,
                  fit: BoxFit.contain,
                ),
              
              

            ],
          ),
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