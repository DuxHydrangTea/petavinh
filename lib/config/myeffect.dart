import 'package:flutter/material.dart';

class MyEffect {
  static LinearGradient getLinearGradient2C(Color color1, Color color2) {
    LinearGradient linearGradient = LinearGradient(
      colors: [color1, color2],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
    return linearGradient;
  }

  static BoxDecoration getBoxRadiusShadown(double radius, Color? bgrcolor) {
    bgrcolor ?? Colors.white;
    BoxDecoration bd = BoxDecoration(
        color: bgrcolor,
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        boxShadow: const [
          BoxShadow(
              color: Color.fromARGB(25, 0, 0, 0),
              offset: Offset(2, 2),
              blurRadius: 5),
          BoxShadow(
              color: Color.fromARGB(25, 0, 0, 0),
              offset: Offset(-2, -2),
              blurRadius: 5)
        ]);

    return bd;
  }
}
