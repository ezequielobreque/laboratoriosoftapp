import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:formvalidation/src/models/mensaje_model.dart';
import 'package:formvalidation/src/preferencias_usuario/usuario.dart';
import 'package:latlong/latlong.dart';


class MapaPage extends StatefulWidget {
  MensajeModel mensaje;
  MapaPage({@required this.mensaje}); 
  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  final map = new MapController();
  var longitud;
  var latitud;
  String tipoMapa = 'streets';  
  @override
  void initState() {
    latitud = widget.mensaje.latitud;
    
    longitud = widget.mensaje.longitud; 
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    


    return Scaffold(
      appBar: AppBar(
        title: Text('Ubicacion del mensaje'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.my_location),
            onPressed: (){
              //map.move(scan.getLatLng(), 15);
            },
          )
        ],
      ),
      body: _crearFlutterMap(latitud,longitud),
     // floatingActionButton: _crearBotonFlotante( context ),
    );
  }

  Widget _crearBotonFlotante(BuildContext context ) {

    return FloatingActionButton(
      child: Icon( Icons.repeat ),
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: () {

        // streets, dark, light, outdoors, satellite
        if ( tipoMapa == 'streets' ) {
          tipoMapa = 'dark';
        } else if ( tipoMapa == 'dark' ) {
          tipoMapa = 'light';
        } else if ( tipoMapa == 'light' ) {
          tipoMapa = 'outdoors';
        } else if ( tipoMapa == 'outdoors' ) {
          tipoMapa = 'satellite';
        } else {
          tipoMapa = 'streets';
        }

        setState((){});

      },
    );

  }

  Widget _crearFlutterMap(double latitud, double longitud ) {

    return FlutterMap(
      mapController: map,
      options: MapOptions(
        center: LatLng(latitud,longitud),
        zoom: 15
      ),
      layers: [
        _crearMapa(),
        _crearMarcadores(latitud,longitud)
      ],
    );

  }

  _crearMapa() {

    return TileLayerOptions(
        urlTemplate: 'https://api.tiles.mapbox.com/v4/'
            '{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
        additionalOptions: {
        'accessToken':'pk.eyJ1Ijoiam9yZ2VncmVnb3J5IiwiYSI6ImNrODk5aXE5cjA0c2wzZ3BjcTA0NGs3YjcifQ.H9LcQyP_-G9sxhaT5YbVow',
        'id': 'mapbox.streets'
        }
      );
  }

  _crearMarcadores( latitud,longitud ) {

    return MarkerLayerOptions(
      markers: <Marker>[
        Marker(
          width: 100.0,
          height: 100.0,
          point: LatLng(latitud,longitud),
          builder: ( context ) => Container(
            child: Icon( 
              Icons.location_on, 
              size: 70.0,
              color: Theme.of(context).primaryColor,
              ),
          )
        )
      ]
    );

  }
}