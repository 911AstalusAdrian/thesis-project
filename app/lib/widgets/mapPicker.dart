import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPicker extends StatefulWidget {
  const MapPicker({Key? key}) : super(key: key);

  @override
  State<MapPicker> createState() => _MapPickerState();
}

const gApiKey = "AIzaSyA-bNACRe14lBVDViNcsu4AyMhV-7cCsBI";

class _MapPickerState extends State<MapPicker> {

  static const CameraPosition initialCameraPos = CameraPosition(target: LatLng(37.422, -122.084), zoom: 14);
  Set<Marker> markersList = {};
  late GoogleMapController gMapController;


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: initialCameraPos,
            markers: markersList,
            mapType: MapType.normal,
            onMapCreated: (GoogleMapController ctrl) {gMapController = ctrl;},
          ),
          ElevatedButton(onPressed: _handleButtonPress, child: const Text("Search"))
        ],
      ),
    );
  }

  _handleButtonPress() async {
    // Prediction? p = PlacesAutocomplete.show(
    //     context: context,
    //     apiKey: gApiKey,
    //     onError: onError,
    //     mode: Mode.overlay,
    // language: 'en',
    // strictbounds: false,
    // types: [""]);
  }
}
