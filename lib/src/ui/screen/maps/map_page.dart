import 'package:covid_19_vaccine_korea/src/model/vaccine_center.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapPage extends StatefulWidget {
  final VaccineCenter? vaccineCenter;

  MapPage({required this.vaccineCenter});

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  var markers = [];
  num _zoom = 6;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.vaccineCenter != null) {
      widget.vaccineCenter?.data?.forEach((element) {
        double _lat = double.parse(element.lat!);
        double _lng = double.parse(element.lng!);
        markers.add(Marker(
          point: LatLng(_lat, _lng),
          builder: (ctx) => Container(
              child: Icon(
            Icons.location_pin,
            color: Colors.blue,
            size: 32,
          )),
        ));
      });
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pop(),
        child: Icon(Icons.arrow_back),
      ),
      body: Stack(
        children: [
          Positioned(
            child: FlutterMap(
              options: MapOptions(
                center: LatLng(37.55179766564924, 126.98849872802218),
                zoom: _zoom.toDouble(),
                maxZoom: 18,

              ),

              layers: [
                TileLayerOptions(
                  urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'],
                ),
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
            left: 0,
            right: 0,
            bottom: 0,
            top: 0,
          ),
          // Positioned(
          //   bottom: 16,
          //     right: 16,
          //     child: Column(
          //   children: [
          //     Container(
          //       decoration: BoxDecoration(
          //         color: Colors.white
          //       ),
          //       child: IconButton(
          //           onPressed: () {
          //
          //             if (_zoom > 17) {
          //               _zoom = 17;
          //             }
          //             _zoom += 1;
          //             print(_zoom);
          //             setState(() {});
          //           },
          //           icon: Icon(Icons.add)),
          //     )
          //   ],
          // ))
        ],
      ),
    );
  }
}
