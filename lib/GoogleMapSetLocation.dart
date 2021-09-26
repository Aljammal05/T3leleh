import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:t3leleh_v1/AddPlace.dart';
import 'package:t3leleh_v1/Users/Users.dart';

class MapSetLocation extends StatefulWidget {
  _MapSetLocationState createState() => _MapSetLocationState();
}

class _MapSetLocationState extends State<MapSetLocation> {
  List<Marker> markerlist = [];
  LatLng pos = LatLng(31.963158, 35.930359);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('SET LOCATION')),
        toolbarHeight: 75,
        backgroundColor: Color(0xff08AFBF),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SafeArea(
                    child: AddPlace(pos),
                  ),
                ),
              );
            },
            child: Text(
              'SAVE',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(31.963158, 35.930359),
          zoom: 11.5,
        ),
        mapType: MapType.hybrid,
        markers: Set.from(markerlist),
        onTap: tappoint,
      ),
    );
  }

  tappoint(LatLng tappedPoint) {
    setState(() {
      markerlist = [];
      markerlist.add(Marker(
        markerId: MarkerId(tappedPoint.toString()),
        onDragEnd: (lastpos) {
          setState(() {
            pos = lastpos;
          });
        },
        position: tappedPoint,
        draggable: true,
      ));
      pos = markerlist[0].position;
    });
  }
}
