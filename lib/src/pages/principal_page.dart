
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formvalidation/src/bloc/mensaje_bloc.dart';
import 'package:formvalidation/src/bloc/provider.dart';
import 'package:formvalidation/src/pages/Settings.dart';
import 'package:formvalidation/src/pages/home_page.dart';
import 'package:formvalidation/src/pages/mi_perfil_page.dart';
import 'package:formvalidation/src/pages/tabbed_pad.dart';
import 'package:formvalidation/src/search/search_delegate.dart';



class TabbedAppBarDemo extends StatefulWidget {

  @override
  _TabbedAppBarDemoState createState() => _TabbedAppBarDemoState();
}

class _TabbedAppBarDemoState extends State<TabbedAppBarDemo> {
  MensajesBloc mensajes;
  ConosidosBloc usuarios;
  MisMensajesBloc misMensajesBloc;
  int contador=0;
  void didChangeDependencies() {
    mensajes= Provider.mensajesBloc(context);
    usuarios= Provider.conocidosBloc(context);
    misMensajesBloc = Provider.misMensajesBloc(context);
     
 
    super.didChangeDependencies();
  }
  
 /* @override
  void initState() {
    mensajes.destroid();
    usuarios.destroid();
    misMensajesBloc.destroy();
    super.initState();
  }*/


  @override
  Widget build(BuildContext context) {
   var variable= ModalRoute.of(context).settings.arguments;
    (variable==null)?null:contador=variable;
    if(contador==0){
     
    mensajes.destroid();
    usuarios.destroid();
    misMensajesBloc.destroy();
    contador=contador+1;
    }
   
    return DefaultTabController(

        length: 4,
        child: Scaffold(
          appBar: 
             AppBar(
              elevation: 10.0,
              
              bottom: PreferredSize(

                preferredSize:Size.fromHeight(0.0),
                child: TabBar(
                   labelPadding: EdgeInsets.symmetric(horizontal: 28.0),
                  
                  isScrollable: true,
                  tabs: [
                  Tab(icon: Icon(Icons.home)),
                  Tab(icon: Icon(FontAwesomeIcons.userAlt)),
                  Tab(icon:IconButton(iconSize: 30,icon: Icon(Icons.search),
                     onPressed: () {
                     showSearch(context: context, delegate: DataSearch());
                  },
                  ),
                  ),
                        
                    
                  
                    
                  Tab(icon: Icon( Icons.settings)),
                    

                  ]
                  
                ),
              ),
            ),
          
          body: TabBarView(
            children: [
              HomePage(mensajesBloc: mensajes,conosidosBloc: usuarios,),
              MiPerfilPage(misMensajesBloc:misMensajesBloc),
              Container(),
              SettingsPage(misMensajesBloc:misMensajesBloc,mensajesBloc: mensajes,conosidosBloc: usuarios,),
            ]

          ),
        ),
      );
    
  }

}
 