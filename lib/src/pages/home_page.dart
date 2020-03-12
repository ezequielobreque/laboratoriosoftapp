import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formvalidation/src/bloc/mensaje_bloc.dart';
import 'package:formvalidation/src/bloc/provider.dart';
import 'package:formvalidation/src/models/mensaje_model.dart';
import 'package:formvalidation/src/preferencias_usuario/usuario.dart';
import 'package:formvalidation/src/utils/utils.dart' as utils;

class HomePage extends StatefulWidget {
  
  
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  Widget _crearItem(BuildContext context, MensajesBloc mensajesBloc, MensajeModel mensaje ) {
    var variable=false;
    for ( var item in mensaje.meGustas.users  ) {
      if (item.id==userApp().id){variable=true;}
    };
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
                  
                  Column(
                     crossAxisAlignment:  CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('  ${ mensaje.user.username }',style: TextStyle(fontSize: 22.0)),
                          Text('  ${mensaje.fechaHora.hour}:${mensaje.fechaHora.minute}',style: TextStyle(fontSize: 15.0),)
                          ]
                      )
                  ]
              ),
              subtitle: Text( mensaje.informacion,style: TextStyle(fontSize: 18.5,color: Color.fromRGBO(44, 62, 80,1.0)), ),
              onTap: () => Navigator.pushNamed(context, 'mensaje', arguments: mensaje ),
            ),
            ( mensaje.imageName == null ) 
              ? Container(height:0 )
              : FadeInImage(
                image: NetworkImage( "${utils.url}/imagenes/mensaje/"+mensaje.imageName,
                      
                        ) ,
                placeholder:AssetImage(  'assets/jar-loading.gif'),
                
                width: double.maxFinite,
                fit: BoxFit.contain,
              ),
              Divider(),
              Row(

  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FlatButton.icon(
                    icon: Icon(FontAwesomeIcons.solidThumbsUp,color: (
                      (
                      variable?
                      Colors.blue
                      :Colors.grey)
                    )
                      ),
                    label: Text('Me gusta'),
                    color: Colors.black12,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      
                    
                    onPressed:(){setState(() {
                      
                     mensajesBloc.darMeGusta(mensaje.id);
                    });},
                  
                  
                      ),
                    VerticalDivider()
                      ,

                  FlatButton.icon(
                    
                  onPressed: (){Navigator.pushNamed(context, 'usuariosmegusta', arguments: mensaje );},
                  color: Colors.black12,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                          
                  label:Text('(${mensaje.meGustas.users.length})'),
                  icon:Icon(FontAwesomeIcons.thumbsUp,size: 15.0,),

                  )
                  
                ],
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