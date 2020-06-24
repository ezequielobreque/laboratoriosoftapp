import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formvalidation/src/bloc/mensaje_bloc.dart';
import 'package:formvalidation/src/models/mensaje_model.dart';
import 'package:formvalidation/src/pages/mapa_page.dart';
import 'package:formvalidation/src/pages/perfil_usuario.dart';
import 'package:formvalidation/src/preferencias_usuario/usuario.dart';
import 'package:formvalidation/src/utils/utils.dart' as utils;
import 'package:formvalidation/src/widget/amigos_horizontal.dart';
import 'package:formvalidation/src/widget/crearpost.dart';


class CrearListado extends StatefulWidget {
  final List<MensajeModel> mensajes;
  final MensajesBloc mensajesBloc;
  final Function destroid;
  final ScrollController scrollController;
  final ConosidosBloc conosidosBloc;

  CrearListado({ @required this.mensajes,@required this.conosidosBloc, @required this.mensajesBloc,@required this.scrollController,@required this.destroid});

  @override
  _CrearListadoState createState() => _CrearListadoState();
}

class _CrearListadoState extends State<CrearListado> {
  
 

 


  Widget build(BuildContext context) {
 
    
 
   
    
    
        return ListView.builder(
              controller: widget.scrollController,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              
              itemCount: widget.mensajes.length,
              
               itemBuilder:(context,i)=>/*(i==0)?
                crearPost(context,false):(i==1)?
                amigosSwiper(context,widget.conosidosBloc):*/
                crearItem(context , widget.mensajes[i] ,widget.mensajesBloc.darMeGusta)
              
                  );
    




  }

   Widget crearItem(BuildContext context, MensajeModel mensaje ,Function darMeGusta) {
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
                  ),
                
                /*ClipRRect(
                      
                      borderRadius: BorderRadius.circular(20.0),
                    child: Image(image:(mensaje.user.imageName!=null)? NetworkImage("${utils.url}/imagenes/user/"+mensaje.user.imageName)
                    :AssetImage('assets/perfil-no-image.jpg'),
                    )
                    )*/
                    
            
                
                
                    
                  
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
              onTap: (){  Navigator.push(
              context,
                      MaterialPageRoute(builder:(context)=>PerfilUsuarioPage(usuario:mensaje.user))).then((value){handleRefresh();});}
           
            ),
            ( mensaje.imageName == null ) 
              ? Container(height:0 )
              : 
                 FadeInImage(
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
                      
                    
                    onPressed:(){
                      setState(() {
                        
                       darMeGusta(mensaje.id);
                         
                      });

                    },

                      ),
                    VerticalDivider()
                      ,

                  FlatButton.icon(
                    
                  onPressed: (){Navigator.pushNamed(context, 'usuariosmegusta',  arguments: mensaje).then((value) {
                  handleRefresh();});}
                    
                  
                
                 
                    
                  ,
                  color: Colors.black12,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                          
                  label:Text('(${ mensaje.meGustas.users.length})'),
                  icon:Icon(FontAwesomeIcons.thumbsUp,size: 15.0,),

                  )
                  
                ],
              ),
                ],

              ),
              
              );
              


    

  }
   Future<void> handleRefresh()async {
    setState(() {
      widget.mensajesBloc.destroid();
      widget.conosidosBloc.destroid();
      
    });
    print('handle');
    return null;
  }
    
}

   Widget amigosSwiper(BuildContext context,ConosidosBloc conosidosBloc,MensajesBloc mensajesBloc){

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            color: Colors.white,
            alignment: Alignment.center,
            child: Text('Personas que quizas conoscas ', style:TextStyle(fontSize: 20,),textAlign: TextAlign.center,  )
          ),
          StreamBuilder(
            
            stream: conosidosBloc.conocidostream,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
               if ( snapshot.data==null) {
                return  Center(child: Text('No tenemos a quien recomendarte',style:  TextStyle(fontSize: 18.5,color: Colors.blue)));
                
                
              
            }
            else if ( snapshot.data.length==0) {
                return  Center(child: Text('No tenemos a quien recomendarte',style:  TextStyle(fontSize: 18.5,color: Colors.blue)));
                
                
              
            }
               else {
                 return AmigosHorizontal(
                  personas: snapshot.data,
                  conosidosBloc: conosidosBloc,
                  mensajesBloc: mensajesBloc,
                 );
              }
             
             
              
              },
          ),

        ],
      ),
    );

    
   }



