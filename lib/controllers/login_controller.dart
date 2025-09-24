import 'package:assingment/screens/order_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class LoginController extends GetxController {

  final emailctrl = TextEditingController();
  final passctrl = TextEditingController();
  final formkey = GlobalKey<FormState>();
  RxBool rememberme = false.obs;
  RxBool loading = false.obs;

  //dummy credentials
final String demoEmail = 'driver@email.com';
final String demoPass = 'driver@123';

@override
void dispose(){
  emailctrl.dispose();
  passctrl.dispose();
  super.dispose();
}

Future<void> tryLogin() async {
  if(!formkey.currentState!.validate())return;

  loading.value = true;
  await Future.delayed(const Duration(seconds: 1));
  loading.value = false;

  if(emailctrl.text.trim() == demoEmail && passctrl.text.trim() == demoPass){
    Get.snackbar("Success", "Logged in successfully",snackPosition: SnackPosition.TOP,backgroundColor: Colors.green,colorText: Colors.white,snackStyle: SnackStyle.FLOATING);
    //navigation to next screen
    Get.to(()=> OrderScreen(), transition: Transition.rightToLeftWithFade);
  }else{
    Get.snackbar("error", "Invalid Credentials",snackPosition: SnackPosition.TOP,backgroundColor: Colors.red,colorText: Colors.white, snackStyle: SnackStyle.FLOATING);
  }
}
}