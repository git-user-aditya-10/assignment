import 'package:assingment/controllers/login_controller.dart';
import 'package:assingment/screens/order_screen.dart';
import 'package:get/get.dart';
class AppBindings extends Bindings{
@override
  void dependencies() {
  Get.put(LoginController());
  Get.put(OrderScreen());
  }
}