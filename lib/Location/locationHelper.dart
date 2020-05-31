import 'package:geolocator/geolocator.dart';
//import 'package:location/location.dart';

class LocationHelper {
//  Location location = new Location();

  double longitude;
  double latitude;
  String userCountry;
  String userLocality;
  List<Placemark> placemark;

  Future getUserCoordinate() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);

    longitude = position.longitude;
    latitude = position.latitude;

    print('getUserCoordinate: $longitude');
    print('getUserCoordinate: $latitude');

//    bool _serviceEnabled;
//    PermissionStatus _permissionGranted;
//    LocationData _locationData;
//
//    _serviceEnabled = await location.serviceEnabled();
//    if (!_serviceEnabled) {
//      _serviceEnabled = await location.requestService();
//      if (!_serviceEnabled) {
//        return;
//      }
//    }
//
//    _permissionGranted = await location.hasPermission();
//    if (_permissionGranted == PermissionStatus.denied) {
//      _permissionGranted = await location.requestPermission();
//      if (_permissionGranted != PermissionStatus.granted) {
//        return;
//      }
//    }
//
//    _locationData = await location.getLocation();
  }

  Future<void> getUserCountryAndLocality() async {
    await getUserCoordinate();

    placemark =
        await Geolocator().placemarkFromCoordinates(latitude, longitude);

    userCountry = placemark[0].country;
    userLocality = placemark[0].locality;

    print('getUserCountryLocality: $userCountry');
    print('getUserLocality: $userLocality');
  }
}
