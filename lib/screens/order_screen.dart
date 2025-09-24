import 'package:assingment/controllers/order_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final controller = Get.put(OrderController());

  Future<void> _openmaps(double lat, double lng) async {
    final Uri googleMapsUrl = Uri.parse(
        "https://www.google.com/maps/dir/?api=1&destination=$lat,$lng&travelmode=driving");

    try {
      final bool launched = await launchUrl(
        googleMapsUrl,
        mode: LaunchMode.externalApplication,
      );

      if (!launched) {
        Get.snackbar("Error", "Could not launch Google Maps");
      }
    } catch (e) {
      Get.snackbar("Error", "Launch failed: $e");
    }
  }


  Widget _buildActionButton(){
    return Obx(() {
      switch(controller.status.value){
        case TripStatus.notstarted:
          return ElevatedButton(onPressed: controller.startTrip,
              child: const Text("Start Trip"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.yellow,
              foregroundColor: Colors.brown,
            ),
          );
        case TripStatus.started:
          return Column(
            children: [
              ElevatedButton(
                onPressed: controller.arrivedAtRestaurent,
                child: const Text("Arrived at Restaurant"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow,
                  foregroundColor: Colors.brown,
              ),
              ),
              const SizedBox(height: 8),
              OutlinedButton(
                onPressed: () =>
                    _openmaps(controller.restaurantLat, controller.restaurantLng),
                child: const Text("Navigate to Restaurant"),
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white
                ),
              ),
            ],
          );
        case TripStatus.arrivedRestaurent:
          return Column(
            children: [
              ElevatedButton(onPressed: controller.pickup, child: Text("Picked up"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow,
                  foregroundColor: Colors.black
                ),
              ),
              SizedBox(height: 10,),
              OutlinedButton(onPressed: () => _openmaps(controller.customerLat, controller.customerLng) , child: Text("Navigate to Customer"), style: OutlinedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white
              ),
              ),
            ],
          );
        case TripStatus.pickup:
          return ElevatedButton(
              onPressed: controller.arrivedAtCustomer,
              child: const Text("Arrived at Customers Place"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.yellow,
              foregroundColor: Colors.brown,
            )
          );
        case TripStatus.arrivedCustomer:
          return ElevatedButton(
            onPressed: controller.deliverd,
            child: const Text("Delivered"),
          style: ElevatedButton.styleFrom(
          backgroundColor: Colors.yellow,
          foregroundColor: Colors.brown,
      ),
          );
        case TripStatus.deliverd:
          return const Column(
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 50),
              Text("Order Delivered"),
            ],
          );
      }
    },
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[50],
      appBar: AppBar(title: Text("Assigned Order"),backgroundColor: Colors.yellow,),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Order info
            SizedBox(
              width: double.infinity,
              child: Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    children: [
                      Text("Order ID: ${controller.orderId.value}",
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                      ),
                      Text("Amount: ₹${controller.orderAmount.value}  (${controller.restaurantLat}, ${controller.restaurantLng})"),
                      Text("Customer: ${controller.customerName.value} (${controller.customerLat}, ${controller.customerLng})")
                    ],
                  ),
                ),
              ),
            ),
            
            SizedBox(height: 20,),
            
            //Driver location
          Text(
            "Driver Location: ${controller.currentPostion.value == null ? "Unknown" : "Lat: ${controller.currentPostion.value!.latitude}, Lng: ${controller.currentPostion.value!.longitude}"}",
          ),
          Text("Distance: ${controller.distanceText.value}"),
          const SizedBox(height: 20),

          //buttons
          _buildActionButton(),
          ]
        ),
      ),
      )
    );
  }
}
