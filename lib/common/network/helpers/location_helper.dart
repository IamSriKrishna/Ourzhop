// location_helper.dart
import 'package:geolocator/geolocator.dart';

class LocationHelper {
  static Future<Position?> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return null;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return null;
      }
    }
    
    if (permission == LocationPermission.deniedForever) {
      return null;
    } 

    return await Geolocator.getCurrentPosition();
  }

  static Future<({double lat, double lng})?> getCoordinates() async {
    final position = await getCurrentLocation();
    if (position == null) return null;
    
    return (lat: position.latitude, lng: position.longitude);
  }
}
