import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';

enum TripStatus {
  notstarted,
  started,
  arrivedRestaurent,
  pickup,
  arrivedCustomer,
  deliverd,
}
class OrderController  extends GetxController{

final orderId = "ORD1001".obs;
final restaurantName = "Tasty Bites".obs;
final restaurantLat =18.5204;
final restaurantLng = 73.8567;
final customerName = "Rohit Sharma".obs;
final customerLat = 18.5204;
final customerLng =  73.8567;
final orderAmount = 299.0.obs;

  //Driver state
var status = TripStatus.notstarted.obs;
var distanceText = "Unknown".obs;
Rx<Position?> currentPostion = Rx<Position?>(null);

Timer? _locTimer;
final int geofenceMeters = 50;

@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _initLocationUpdates();

  }
  Future<void> _initLocationUpdates() async{
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if(!serviceEnabled){
    Get.snackbar("Error", "Enable Location Service");
    return;
  }

  LocationPermission permisson = await Geolocator.checkPermission();
  if(permisson == LocationPermission.denied
      || permisson == LocationPermission.deniedForever){
    permisson = await Geolocator.requestPermission();
    if(permisson == LocationPermission.denied || permisson == LocationPermission.deniedForever){
      Get.snackbar("Error", "Location permission denied ");
      return;
    }
  }

  await _updatePosition();

  // Start the periodic timer for updates
  _locTimer = Timer.periodic(const Duration(seconds: 10), (_) async {
    await _updatePosition();
  });
  }

  Future<void> _updatePosition() async {
    try {
      final pos = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      currentPostion.value = pos;

      // Distance text based on status
      if (status.value == TripStatus.started ||
          status.value == TripStatus.notstarted) {
        final d = Geolocator.distanceBetween(
          pos.latitude, pos.longitude, restaurantLat, restaurantLng,
        );
        distanceText.value = "${d.toStringAsFixed(0)} m away from restaurant";
      } else {
        final d = Geolocator.distanceBetween(
          pos.latitude, pos.longitude, customerLat, customerLng,
        );
        distanceText.value = "${d.toStringAsFixed(0)} m away from customer";
      }

      // simulate sending location to server
      print("Sending location: ${pos.latitude}, ${pos.longitude}");
    } catch (e) {
      print("Location error: $e");
    }
  }

  bool _withGeofince(double lat, double lng){
  if(currentPostion.value == null) return false;
  final distance = Geolocator.distanceBetween(currentPostion.value!.latitude, currentPostion.value!.longitude, lat, lng
  );
  return distance <= geofenceMeters;
  }

  //Actions
void startTrip() => status.value = TripStatus.started;

void arrivedAtRestaurent() {
  status.value = TripStatus.arrivedRestaurent;
}

void pickup(){
  status.value = TripStatus.pickup;
  Get.snackbar("Done", "Order PickedUp ",snackPosition: SnackPosition.TOP, backgroundColor: Colors.blue);
}

void arrivedAtCustomer() {
  status.value = TripStatus.arrivedCustomer;
}
void deliverd() {
  status.value = TripStatus.deliverd;

  Get.defaultDialog(
    title: "Success",
    middleText: "Order delivered successfully!",
    backgroundColor: Colors.green[200],
    titleStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    middleTextStyle: TextStyle(color: Colors.white),
    textConfirm: "OK",
    confirmTextColor: Colors.white,
    onConfirm: () {
      Get.back(); // closes the dialog
    },
  );


@override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

}
}
