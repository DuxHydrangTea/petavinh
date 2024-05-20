import 'package:flutter/widgets.dart';

// ignore: must_be_immutable
class ContainerBorder extends StatelessWidget {
  Widget? child;
  ContainerBorder({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          //color: Colors.amberAccent,
          border: Border.all()),
      child: child,
    );
  }
}
