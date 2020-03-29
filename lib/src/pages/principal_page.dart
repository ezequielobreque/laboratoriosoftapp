
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formvalidation/src/bloc/mensaje_bloc.dart';
import 'package:formvalidation/src/bloc/provider.dart';
import 'package:formvalidation/src/pages/home_page.dart';
import 'package:formvalidation/src/pages/mi_perfil_page.dart';
import 'package:formvalidation/src/pages/tabbed_pad.dart';
import 'package:formvalidation/src/search/search_delegate.dart';


class TabbedAppBarDemo extends StatefulWidget {
  
   



   
  @override
  _TabbedAppBarDemoState createState() => _TabbedAppBarDemoState();
}




class _TabbedAppBarDemoState extends State<TabbedAppBarDemo> {
  @override   
  void initState() {
    super.initState();
      
            
  }    
       
      @override   
      void dispose() 
      {    
         super.dispose();     
       
      }
  




  @override
  Widget build(BuildContext context) {
 
  
final mensajes= Provider.mensajesBloc(context);
mensajes.cargarMensajes();
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
              HomePage(mensajesBloc: mensajes),
              MiPerfilPage(),
              Container(),
              Icon(Icons.directions_bike),
            ]

          ),
        ),
      );
    
  }
}
 