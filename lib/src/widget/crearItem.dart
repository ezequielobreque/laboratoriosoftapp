import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formvalidation/src/bloc/mensaje_bloc.dart';
import 'package:formvalidation/src/models/mensaje_model.dart';
import 'package:formvalidation/src/models/user_model.dart';
import 'package:formvalidation/src/utils/utils.dart' as utils;
class CrearItem extends StatefulWidget {
   BuildContext context; 
  MensajesUsuariosBloc productosBloc;
  MensajeModel mensaje;
  UserModel user;
  CrearItem({@required this.context,@required this.productosBloc,@required this.mensaje,@required this.user });

  @override
  _CrearItemState createState() => _CrearItemState();
}

class _CrearItemState extends State<CrearItem> {
  
  
  @override
  Widget build(BuildContext context) {
    var variable=false;
    final context=widget.context; 
 final productosBloc=widget.productosBloc;
  final mensaje=widget.mensaje;
  final user=widget.user;

    for ( var item in mensaje.meGustas.users  ) {
      if (item.id==user.id){variable=true;}
    };
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
                backgroundImage:(mensaje.user.imageName!=null)? NetworkImage("${utils.url}/imagenes/user/"+mensaje.user.imageName)
                   :AssetImage('assets/perfil-no-image.jpg'),
                backgroundColor: Colors.transparent,
              ),
                 
                Text('  ${ mensaje.user.username }',style: TextStyle(fontSize: 22.0))
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
    ));
  }
}


