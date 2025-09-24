import 'package:assingment/bindings/app_bindings.dart';
import 'package:assingment/screens/login_screen.dart';
import 'package:assingment/screens/order_screen.dart';
import 'package:get/get_navigation/get_navigation.dart';

import 'app_routes.dart';

class AppPages{
AppPages._();
  static const String initialRoute = Routes.LOGIN_SCREEN;

  //routes
 static final Route = [
  GetPage(name: Routes.LOGIN_SCREEN,
      page: ()=> LoginScreen(),
      binding: AppBindings()
  ),
   GetPage(name: Routes.ORDER_SCREEN,
       page: () => OrderScreen(),
       binding:AppBindings())
];
}