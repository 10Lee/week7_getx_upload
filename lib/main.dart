import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:week7_getx_upload/global_binding.dart';
import 'package:week7_getx_upload/ui/cart/cart_binding.dart';
import 'package:week7_getx_upload/ui/cart/cart_screen.dart';
import 'package:week7_getx_upload/ui/home/home_binding.dart';
import 'package:week7_getx_upload/ui/home/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialBinding: GlobalBinding(),
      initialRoute: "/home",
      getPages: [
        GetPage(
            name: "/home", page: () => HomeScreen(), binding: HomeBinding()),
        GetPage(name: "/cart", page: () => CartScreen(), binding: CartBinding())
      ],
    );
  }
}
