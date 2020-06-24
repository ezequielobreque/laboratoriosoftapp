import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formvalidation/src/bloc/mensaje_bloc.dart';
import 'package:formvalidation/src/bloc/provider.dart';
import 'package:formvalidation/src/models/mensaje_model.dart';
import 'package:formvalidation/src/pages/producto_page.dart';
import 'package:formvalidation/src/preferencias_usuario/usuario.dart';
import 'package:formvalidation/src/utils/utils.dart' as utils;
import 'package:formvalidation/src/widget/crearpost.dart';
import 'package:formvalidation/src/widget/iniciousuario.dart';

import 'mapa_page.dart';

class MiPerfilPage extends StatefulWidget {
  MisMensajesBloc misMensajesBloc;
  MiPerfilPage({@required this.misMensajesBloc});
  @override
  _MiPerfilPageState createState() => _MiPerfilPageState();
}

class _MiPerfilPageState extends State<MiPerfilPage> {
  @override
  Widget build(BuildContext context) {
    
    final misMensajesBloc = widget.misMensajesBloc;
    
    return Scaffold(
      body:Stack(children: <Widget>[
      utils.crearFondo(context,null),
      
      _crearListado(misMensajesBloc)
      ]),
    );
  }

  Widget _crearListado(MisMensajesBloc misMensajesBloc ) {
    final _pageController=new ScrollController();

      _pageController.addListener((){        
      if (_pageController.position.pixels == _pageController.position.maxScrollExtent) 
      {         misMensajesBloc.cargarMisMensajes();       }      
      });   
    return StreamBuilder(
      stream: misMensajesBloc.mensajesStream,
      builder: (BuildContext context, AsyncSnapshot<List> snapshot){
        
        
        if ( snapshot.hasData ) {

          final productos = snapshot.data;

          return RefreshIndicator(
            child: ListView.builder( 
              controller: _pageController,
              itemCount: productos.length+2,
              itemBuilder: (context, i) =>(i==0)?
                
              InicioUsuario(user: userApp(),context:context,yo:true):(i==1)?crearPost(context,true,this): _crearItem(context, misMensajesBloc, productos[i-2] ),
            ),
            onRefresh: refresh,
          );

        } else {return ListView(children: <Widget>[InicioUsuario(user: userApp(),context:context,yo:true),crearPost(context,true,this),]);
     
        }
      },
    );

  }

  Widget _crearItem(BuildContext context, MisMensajesBloc productosBloc, MensajeModel mensaje ) {
    var variable=false;
    for ( var item in mensaje.meGustas.users  ) {
      if (item.id==userApp().id){variable=true;}
    };
    return GestureDetector(

           onTap:(){
                Navigator.push(
                    context,
                   MaterialPageRoute(builder:(context)=>MensajePage(mensajemod: mensaje,))).then((value){refresh();});
              },
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
                backgroundImage:(mensaje.user.imageName!=null)? NetworkImage("${utils.url}/imagenes/user/"+mensaje.user.imageName)
                   :AssetImage('assets/perfil-no-image.jpg'),
                backgroundColor: Colors.transparent,
              ),
                Row(
                     crossAxisAlignment:  CrossAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:<Widget>[ Text('  ${ mensaje.user.username }',style: TextStyle(fontSize: 22.0)),
                          Text('  ${mensaje.fechaHora.hour}:${mensaje.fechaHora.minute}',style: TextStyle(fontSize: 15.0),),
                          
                          
                          ]),
                         
                      Column(
                        
                        children:<Widget>[
                            
                            mensaje.latitud==null?Container():
                           FlatButton.icon(
                            icon: Icon(Icons.map,color: Colors.grey,size: 17,), 
                        onPressed: (){
                        Navigator.push(
                                context,
                            MaterialPageRoute(builder:(context)=>MapaPage(mensaje: mensaje,)));
                            },
            
                        label: Text('ubicacion',style: TextStyle(color: Colors.grey,fontSize: 17),)),
                          ]
                         ),
                                ]
                      ), 
              
                ]
                ),
                subtitle: Text( mensaje.informacion,style: TextStyle(fontSize: 18.5,color: Color.fromRGBO(44, 62, 80,1.0)), ),
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
                      
                     productosBloc.darMeGusta(mensaje.id);
                    });},
                  
                  
                      ),
                    VerticalDivider(thickness: 20,color: Colors.red,), 

                  FlatButton.icon(
                    
                   onPressed: (){Navigator.pushNamed(context, 'usuariosmegusta', arguments: mensaje  );},
                  color: Colors.black12,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                          
                  label:Text('(${mensaje.meGustas.users.length})'),
                  icon:Icon(FontAwesomeIcons.thumbsUp,size: 15.0,),

                  )
                  
                ],
              
              

            
          ),
          ],

        ),
    ));
  
    


    

  }

  _crearBoton(BuildContext context){
    return FloatingActionButton(
      child: Icon( Icons.add ),
      backgroundColor: Colors.deepPurple,
      onPressed: ()=> Navigator.pushNamed(context, 'mensaje'),
    );
  }
 Future<void> refresh()async {
    setState(() {
      widget.misMensajesBloc.destroy();
    });

    return null;
  }
}