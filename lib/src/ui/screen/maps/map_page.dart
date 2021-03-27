import 'package:covid_19_vaccine_korea/src/model/vaccine_center.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class MapPage extends StatefulWidget {
  final VaccineCenter? vaccineCenter;

  MapPage({required this.vaccineCenter});

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  var markers= [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.vaccineCenter != null){
      widget.vaccineCenter?.data?.forEach((element) {
        double _lat = double.parse(element.lat!);
        double _lng = double.parse(element.lng!);
        markers.add(Marker(
          point: LatLng(_lng, _lat),
          builder: (ctx) => Container(
            child: Icon(Icons.location_pin,
            color: Colors.blue,
            size: 32,)
          ),

        ));
      });
      setState(() {

      });
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.of(context).pop();
      },
      child: Icon(Icons.arrow_back),
      ),
      body: FlutterMap(
        options: MapOptions(center: LatLng(37.55179766564924, 126.98849872802218), zoom: 6, maxZoom: 18),
        layers: [
          TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", subdomains: ['a', 'b', 'c']),
          MarkerLayerOptions(
            markers: [
              ...markers
              // Marker(
              //   point:  LatLng(_lng, _lat),
              //   builder: (ctx) =>
              //       Container(
              //         child: Icon(
              //           Icons.location_pin,
              //           size: 32,
              //           color: Colors.green,
              //         ),
              //       ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
