import 'package:flutter/material.dart';

class ButtomSound extends StatelessWidget {
  final VoidCallback function;
  final String pathImage;

  const ButtomSound(
      {super.key, required this.function, required this.pathImage});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image(image: AssetImage(pathImage)),
      ),
    );
  }
}
