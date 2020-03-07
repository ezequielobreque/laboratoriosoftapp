import 'package:flutter/material.dart';
import 'package:formvalidation/src/bloc/provider.dart';
import 'package:formvalidation/src/pages/home_page.dart';
import 'package:formvalidation/src/pages/mi_perfil_page.dart';
import 'package:formvalidation/src/pages/tabbed_pad.dart';
import 'package:formvalidation/src/search/search_delegate.dart';


class TabbedAppBarDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
   
    return DefaultTabController(

        length: choices.length,
        child: Scaffold(
          appBar: 
             AppBar(
              elevation: 10.0,
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
                
              new IconButton(
              icon: new Icon(Icons.bookmark),
              onPressed: () {showSearch(
                context: context, 
                delegate: DataSearch(),
                // query: 'Hola'
                );},
              ),  

              Icon(Icons.directions_bike),
            ]

          ),
        ),
      );
    
  }
}
 