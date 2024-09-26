import 'package:flutter/material.dart';

class ClickableImage extends StatelessWidget {
  final VoidCallback function;
  final String pathImage;
  const ClickableImage(
      {super.key, required this.function, required this.pathImage});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Image(image: AssetImage(pathImage)),
    );
  }
}
