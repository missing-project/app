import 'package:flutter/material.dart';

class LoadingStack extends StatefulWidget {
  const LoadingStack({
    super.key,
    required this.child,
    required this.isLoading,
  });

  final Widget child;
  final bool isLoading;

  @override
  State<LoadingStack> createState() => _LoadingStackState();
}

class _LoadingStackState extends State<LoadingStack> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        Positioned(
          child: widget.isLoading
              ? Center(child: CircularProgressIndicator())
              : SizedBox(),
        )
      ],
    );
  }
}
