import 'package:flutter/material.dart';

class SlidingAppbar extends StatelessWidget implements PreferredSizeWidget {
  const SlidingAppbar({
    Key? key,
    required this.child,
    required this.controller,
    required this.isMap,
  }) : super(key: key);

  final PreferredSizeWidget child;
  final AnimationController controller;
  final bool isMap;

  @override
  Size get preferredSize => child.preferredSize;

  @override
  Widget build(BuildContext context) {
    isMap ? controller.forward() : controller.reverse();
    return SlideTransition(
      position: Tween<Offset>(begin: Offset.zero, end: Offset(0, -1)).animate(
          CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn)),
      child: child,
    );
  }
}
