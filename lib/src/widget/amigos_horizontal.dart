import 'package:flutter/material.dart';
import 'package:formvalidation/src/models/user_model.dart';
import 'package:formvalidation/src/utils/utils.dart' as utils;


class AmigosHorizontal extends StatefulWidget {

  final List<UserModel> personas;
  final Function siguientePagina;

 AmigosHorizontal({ @required this.personas, @required this.siguientePagina });

  @override
  _AmigosHorizontalState createState() => _AmigosHorizontalState();
}

class _AmigosHorizontalState extends State<AmigosHorizontal> {
  final _pageController = new PageController(
    
    viewportFraction: 0.33
  );

  @override
  Widget build(BuildContext context) {
    
    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener( () {

      if ( _pageController.position.pixels >= _pageController.position.maxScrollExtent ){
        widget.siguientePagina();
      }

    });


    return Container(
      decoration: BoxDecoration(
              color: Colors.white,
              
            ),
      height: _screenSize.height * 0.2,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        // children: _tarjetas(context),
        itemCount: widget.personas.length,
        itemBuilder: ( context, i ) => _tarjeta(context, widget.personas[i] ),
      ),
    );


  }

  Widget _tarjeta(BuildContext context, UserModel personas) {
    
    final tarjeta = Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey,width: 0.4),
       borderRadius: BorderRadius.circular(20),
        boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 3.0,
                  offset: Offset(0.0, 5.0),
                  spreadRadius: 3.0
                )
              ]
       
       ),
        
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          
          children: <Widget>[
            Expanded(

              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child:Image
                (
                     
                    image:(personas.imageName!=null)? NetworkImage("${utils.url}/imagenes/user/"+personas.imageName)
                    :AssetImage('assets/perfil-no-image.jpg'),
                    fit: BoxFit.cover,
                  )
                
              ),
            ),
            SizedBox(height: 5.0),

            Text(
              
              personas.username,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color:Colors.black87),

            )
          ],
        ),
      );

    return GestureDetector(
      child: tarjeta,
      onTap: (){
      Navigator.pushNamed(context, 'perfilusuario', arguments: personas);

      },
    );

  }
}
