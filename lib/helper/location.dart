import 'package:geolocator/geolocator.dart';

class GetLocation {
  static getUserLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium);

        
  }
}
