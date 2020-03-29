import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formvalidation/src/bloc/mensaje_bloc.dart';
import 'package:formvalidation/src/bloc/provider.dart';
import 'package:formvalidation/src/models/mensaje_model.dart';
import 'package:formvalidation/src/preferencias_usuario/usuario.dart';
import 'package:formvalidation/src/utils/utils.dart' as utils;

class MiPerfilPage extends StatefulWidget {
  
  
  @override
  _MiPerfilPageState createState() => _MiPerfilPageState();
}

class _MiPerfilPageState extends State<MiPerfilPage> {
  @override
  Widget build(BuildContext context) {
    
    final misMensajesBloc = Provider.misMensajesBloc(context);
    misMensajesBloc.cargarMisMensajes();
    
   
    return Scaffold(
      
      
      body:Stack(children: <Widget>[utils.crearFondo(context,null),_crearListado(misMensajesBloc)]),
      floatingActionButton: _crearBoton( context ),
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
      builder: (BuildContext context, AsyncSnapshot<List<MensajeModel>> snapshot){
        
        
        if ( snapshot.hasData ) {

          final productos = snapshot.data;

          return ListView.builder(
            controller: _pageController,
            itemCount: productos.length,
            itemBuilder: (context, i) => _crearItem(context, misMensajesBloc, productos[i] ),
          );

        } else {
          return Center( child: CircularProgressIndicator());
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

  _crearBoton(BuildContext context) {
    return FloatingActionButton(
      child: Icon( Icons.add ),
      backgroundColor: Colors.deepPurple,
      onPressed: ()=> Navigator.pushNamed(context, 'mensaje').then((value) {
                  setState(() {});}),
    );
  }
}