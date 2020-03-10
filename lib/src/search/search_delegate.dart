import 'package:flutter/material.dart';
import 'package:formvalidation/src/models/user_model.dart';
import 'package:formvalidation/src/providers/usuario_busquedas.dart';
import 'package:formvalidation/src/utils/utils.dart' as utils;


class DataSearch extends SearchDelegate {

  String seleccion = '';
  final usuariosProvider = new UsuarioBusquedas();

  /*final peliculas = [
    'Spiderman',
    'Aquaman',
    'Batman',
    'Shazam!',
    'Ironman',
    'Capitan America',
    'Superman',
    'Ironman 2',
    'Ironman 3',
    'Ironman 4',
    'Ironman 5',
  ];

  final peliculasRecientes = [
    'Spiderman',
    'Capitan America'
  ];*/
  

  @override
  List<Widget> buildActions(BuildContext context) {
    // Las acciones de nuestro AppBar
    return [
      IconButton(
        icon: Icon( Icons.clear ),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono a la izquierda del AppBar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: (){
        close( context, null );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crea los resultados que vamos a mostrar
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.blueAccent,
        child: Text(seleccion),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Son las sugerencias que aparecen cuando la persona escribe
    
    if ( query.isEmpty ) {
      return Container();
    }
    
    return FutureBuilder(
      future: usuariosProvider.buscarUsuario(query),
      builder: (BuildContext context, AsyncSnapshot<List<UserModel>> snapshot) {

          if( snapshot.hasData ) {
            
            final usuarios = snapshot.data;

            return ListView(
              children: usuarios.map( (user) {
                  return ListTile(
                    leading:CircleAvatar(
                      radius: 22.0,
                      backgroundImage:(user.imageName!=null)? NetworkImage('${utils.url}/imagenes/user/${user.imageName}')
                        :AssetImage('assets/perfil-no-image.jpg'),
                      backgroundColor: Colors.transparent,
                    ),
                    title: Text( user.username ),
                    subtitle: Text( user.email),
                    onTap: (){
                      close( context, null);
                      
                      Navigator.pushNamed(context, 'perfilUsuario', arguments: user);
                    },
                  );
              }).toList()
            );

          } else {
            return Center(
              child: CircularProgressIndicator()
            );
          }

      },
    );


  }

  // @override
  // Widget buildSuggestions(BuildContext context) {
  //   // Son las sugerencias que aparecen cuando la persona escribe

  //   final listaSugerida = ( query.isEmpty ) 
  //                           ? peliculasRecientes
  //                           : peliculas.where( 
  //                             (p)=> p.toLowerCase().startsWith(query.toLowerCase()) 
  //                           ).toList();


  //   return ListView.builder(
  //     itemCount: listaSugerida.length,
  //     itemBuilder: (context, i) {
  //       return ListTile(
  //         leading: Icon(Icons.movie),
  //         title: Text(listaSugerida[i]),
  //         onTap: (){
  //           seleccion = listaSugerida[i];
  //           showResults( context );
  //         },
  //       );
  //     },
  //   );
  // }

}

