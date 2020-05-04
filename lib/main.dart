import 'package:flutter/material.dart';

import 'package:formvalidation/src/bloc/provider.dart';

import 'package:formvalidation/src/pages/home_page.dart';
import 'package:formvalidation/src/pages/login_page.dart';
import 'package:formvalidation/src/pages/mi_perfil_page.dart';
import 'package:formvalidation/src/pages/perfil_usuario.dart';
import 'package:formvalidation/src/pages/principal_page.dart';
import 'package:formvalidation/src/pages/producto_page.dart';
import 'package:formvalidation/src/pages/registro_page.dart';
import 'package:formvalidation/src/pages/usuarios_megusta_page.dart';
import 'package:formvalidation/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:formvalidation/src/preferencias_usuario/usuario.dart';
import 'package:formvalidation/src/utils/utils.dart' as utils;

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();
  var initialRoute=await utils.fijarse();
  runApp(MyApp(initialRoute: initialRoute));
    


}
 
class MyApp extends StatelessWidget {
  
final String initialRoute;

MyApp({@required this.initialRoute});
  @override
  Widget build(BuildContext context) {
     
    final prefs = new PreferenciasUsuario();
    print( prefs.token );
   
    
    print(prefs.usuarioApp);
    
    return Provider(
      child: MaterialApp(
        
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: initialRoute,
        routes: {
          'login'    : ( BuildContext context ) => LoginPage(),
          'registro' : ( BuildContext context ) => RegistroPage(),
          'mensaje' :(BuildContext context)=>MensajePage(),
          'miperfil' :( BuildContext context ) => MiPerfilPage(),
          'tapped' :(BuildContext context)=>TabbedAppBarDemo(),
          'usuariosmegusta' :(BuildContext context)=>UsuariosMeGustaPage(),
          'perfilusuario' :(BuildContext context)=>PerfilUsuarioPage(),
        },
        theme: ThemeData(
          primaryColor: Colors.deepPurple,
        ),
      ),
    );
      
  }
}