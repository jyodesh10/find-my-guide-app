


import 'package:location/location.dart';

class LocationHelper {
  Location location = Location();

  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData _locationData;

  Future<bool> checkLocationService() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return false;
      } else {
      return true;
      }
    } else {
      return true;
    }

  }

  Future<PermissionStatus> checkLocationPermission() async {
    _permissionGranted = await location.hasPermission();
    switch (_permissionGranted) {
      case PermissionStatus.denied:
        await location.requestPermission();
        return PermissionStatus.denied;
      case PermissionStatus.deniedForever:
        return PermissionStatus.deniedForever;
      case PermissionStatus.grantedLimited:
        return PermissionStatus.grantedLimited;
      case PermissionStatus.granted:
        return PermissionStatus.granted;
      default:
        return PermissionStatus.granted;
    }
    // if (_permissionGranted == PermissionStatus.denied) {


    //   // if (_permissionGranted != PermissionStatus.granted) {
    //   //   return PermissionStatus.granted;
    //   // } else {
    //   //   return PermissionStatus.granted;

    //   // }
    // }
    // return PermissionStatus.denied;
  }

  Future<LocationData?> getLocation() async {
    bool locationservice = await checkLocationService();
    PermissionStatus locationperm = await checkLocationPermission();
    if(locationservice == true && locationperm == PermissionStatus.granted) {
      _locationData = await location.getLocation();
      return _locationData;
    }
    return null;
  }
}