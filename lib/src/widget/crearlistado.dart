import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formvalidation/src/models/mensaje_model.dart';
import 'package:formvalidation/src/preferencias_usuario/usuario.dart';
import 'package:formvalidation/src/utils/utils.dart' as utils;
import 'package:formvalidation/src/widget/megusta.dart';


class CrearListado extends StatefulWidget {
  final List<MensajeModel> mensajes;
  final Function siguientePagina;
  final Function darmegusta;

  CrearListado({ @required this.mensajes, @required this.siguientePagina,@required this.darmegusta });

  @override
  _CrearListadoState createState() => _CrearListadoState();
}

class _CrearListadoState extends State<CrearListado> {
  
  final _pageController = new ScrollController(
   
  );

 


  Widget build(BuildContext context) {
 
    
  _pageController.addListener((){        
      if (_pageController.position.pixels == _pageController.position.maxScrollExtent) 
      {         widget.siguientePagina();       }      
      });   
   
    
    return Container(
       child: ListView.builder(
            controller: _pageController,
            
            // children: _tarjetas(context),
            itemCount: widget.mensajes.length,
                  itemBuilder: (context, i) => crearItem(context , widget.mensajes[i] ,widget.darmegusta),
                )
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
                      
                    
                    onPressed:(){
                     darMeGusta(mensaje.id);
                    
                    
                     
                    },

                  
                  
                      ),
                    VerticalDivider()
                      ,

                  FlatButton.icon(
                    
                  onPressed: (){Navigator.pushNamed(context, 'usuariosmegusta',  arguments: mensaje).then((value) {
                  setState(() {});});}
                    
                  
                
                 
                    
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
}