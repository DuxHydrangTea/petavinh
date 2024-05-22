import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Get.toNamed("/introhome");
              },
              child: const Text("To Client"),
            ),
            ElevatedButton(
              onPressed: () {
                Get.toNamed("/admin/");
              },
              child: const Text("To Administrator"),
            ),
          ],
        ),
      ),
    );
  }
}
