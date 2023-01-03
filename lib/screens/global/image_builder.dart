import 'package:flutter/material.dart';

class ImageBuilder extends StatelessWidget {
  const ImageBuilder({
    super.key,
    required this.url,
  });
  final String url;

  @override
  Widget build(BuildContext context) {
    if (url.isEmpty || url == 'null') {
      return Center(
        child: Icon(
          Icons.error_outline,
          size: 50.0,
        ),
      );
    }
    return Image.network(
      url,
      errorBuilder: (context, error, stackTrace) {
        return Center(
          child: Icon(
            Icons.error_outline,
            size: 50.0,
          ),
        );
      },
    );
  }
}
