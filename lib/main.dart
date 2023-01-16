import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:one/pages/home/home_view.dart';
import 'package:one/pages/me/me_view.dart';

import 'Route/route.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'one',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: RouteConfig.home,
      getPages: RouteConfig.getPages,
    );
  }
}
