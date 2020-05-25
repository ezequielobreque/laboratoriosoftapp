import 'package:flutter/material.dart';
import 'package:formvalidation/src/models/user_model.dart';
import 'package:formvalidation/src/providers/usuario_provider.dart';
import 'package:formvalidation/src/utils/utils.dart' as utils;



class InicioUsuario extends StatefulWidget { 
  
 final UserModel user;
final  BuildContext context; 
final  bool yo;
  //Function() notifyParent;

 InicioUsuario({@required this.user,@required this.context,@required this.yo});

  @override
  _InicioUsuarioState createState() => _InicioUsuarioState();
}

class _InicioUsuarioState extends State<InicioUsuario> {
  

  @override
  Widget build(BuildContext context) {
  var variable=false;
 // final notifyParent=widget.notifyParent;
  
  utils.seguidos.forEach((f)=>(f.id==widget.user.id)?variable=true:null);
  
   return Container(
      margin: EdgeInsets.symmetric(horizontal: 3.0,vertical: 10.0),
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0 ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
               
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black54,width: 1.25),
                       
                       borderRadius: BorderRadius.circular(100.0),

                      ),
                      child: ClipRRect(
                        
                       borderRadius: BorderRadius.circular(100.0),
                       child:
                         CircleAvatar
                          (
                            radius: MediaQuery.of(widget.context).size.width * 0.23,
                            backgroundImage:(widget.user.imageName!=null)?NetworkImage("${utils.url}/imagenes/user/"+widget.user.imageName):AssetImage('assets/perfil-no-image.jpg'),
                           backgroundColor: Colors.white,
                            
                          ),
                        
                      ),
                    ),
                    Divider(color: Colors.black54,thickness: 0.5,),
                    Text(widget.user.username,style: TextStyle(color: Colors.black87,fontSize: 25),),
                    
                  (widget.yo==true)?Container(height: 10)
                                   :(
                    RaisedButton.icon(
                      color: variable?Colors.red:Colors.blue,
                    
                      icon:Icon(Icons.group_add)
                      ,onPressed: (){setState((){
                        print('esta variable 1 $variable');
                        variable?variable=false:variable=true;
                        
                        print('esta variable 2 $variable');
                      UsuarioProvider().addSeguidor(widget.user.id,widget.user);
                      });},
                      label: variable?Text('Dejar de seguir'):Text('Empezar a seguir'),
                    )),
                
                    /*(RaisedButton.icon(
                      
                      color: Colors.red,
                      icon:Icon(Icons.group_add)
                      ,onPressed:(){setState((){
                      variable=false;
                       UsuarioProvider().addSeguidor(user.id,user);
                      });},
                      label: Text('Dejar de seguir'),
                    ))*/
              ],
            ) ,

  );
  
  }
}



