import 'package:geolocator/geolocator.dart';

class GeoLocation {
  double lat;
  double long;
  GeoLocation();

  Future<void> getLocation() async {
    try {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      lat = position.latitude;
      long = position.longitude;
    } catch (e) {
      //print(e);
    }
  }
}
