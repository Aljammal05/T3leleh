import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:t3leleh_v1/Place.dart';
import 'package:t3leleh_v1/PlaceMainPage.dart';
import 'package:t3leleh_v1/Users/Users.dart';
class MapGetDirection extends StatefulWidget {
  LatLng destination;
  String name;
  MapGetDirection(this.destination,this.name);

  @override
  _MapGetDirectionState createState() => _MapGetDirectionState();
}
class _MapGetDirectionState extends State<MapGetDirection> {
  @override
  void initState() {
    super.initState();
    markerlist.add(Marker(
      markerId: MarkerId(widget.destination.toString()),
      position: widget.destination,
      infoWindow: InfoWindow(title: widget.name,),
    ));
    markerlist.add(Marker(markerId: MarkerId('')));
  }
  List<Marker> markerlist = [];
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('SET LOCATION'),
        toolbarHeight: 75,
        backgroundColor: Color(0xff08AFBF),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'DONE',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: widget.destination,
          zoom: 11.5,
        ),
        mapType: MapType.hybrid,
        markers: Set.from(markerlist),
      ),
    );
  }

}
