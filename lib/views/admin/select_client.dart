import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenAdminClient extends StatelessWidget {
  const ScreenAdminClient({super.key});

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
                Get.toNamed("/admin/user/");
              },
              child: const Text("To Administrator"),
            ),
          ],
        ),
      ),
    );
  }
}
