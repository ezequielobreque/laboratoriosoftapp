import 'package:flutter/material.dart';
import 'package:formvalidation/src/bloc/provider.dart';
import 'package:formvalidation/src/pages/home_page.dart';
import 'package:formvalidation/src/pages/mi_perfil_page.dart';
import 'package:formvalidation/src/pages/tabbed_pad.dart';


class TabbedAppBarDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
   
    return DefaultTabController(

        length: choices.length,
        child: Scaffold(
          appBar: 
             AppBar(
               
              bottom: PreferredSize(

                preferredSize: Size.fromHeight(18.0),
                child: TabBar( 

                  isScrollable: true,
                  tabs: choices.map<Widget>((Choice choice) {
                    return Tab(
                      text: choice.title,
                      icon: Icon(choice.icon),
                    );
                  }).toList(),
                ),
              ),
            ),
          
          body: TabBarView(
            children: [
              HomePage(),
              MiPerfilPage(),
              Icon(Icons.directions_transit),
              Icon(Icons.directions_bike),
            ]

          ),
        ),
      );
    
  }
}
 