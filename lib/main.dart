import 'package:flutter/material.dart';
import 'package:petavinh/config/route.dart';

// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: "Poppins",
      ),
      initialRoute: MyRoute.getIntroHome(),
      getPages: MyRoute.routes,
    );
  }
}
