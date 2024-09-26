import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:mod_15_app_learn_english/src/widgets/clickable_image.dart';

class Animals extends StatefulWidget {
  const Animals({super.key});

  @override
  State<Animals> createState() => _AnimalsState();
}

class _AnimalsState extends State<Animals> {
  final audioPlayer = AudioPlayer();

  void _playSound(String animal) async {
    audioPlayer.audioCache = AudioCache(prefix: 'assets/sounds/');
    await audioPlayer.play(AssetSource('$animal.mp3'));
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {  

    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: MediaQuery.of(context).size.aspectRatio * 2,
      children: [
        ClickableImage(
          function: () =>_playSound('cao'),
          pathImage: 'assets/images/cao.png',
        ),
        ClickableImage(
          function: () => _playSound('gato'),
          pathImage: 'assets/images/gato.png',
        ),
        ClickableImage(
          function: () => _playSound('leao'),
          pathImage: 'assets/images/leao.png',
        ),
        ClickableImage(
          function: () =>_playSound('macaco'),
          pathImage: 'assets/images/macaco.png',
        ),
        ClickableImage(
          function: () => _playSound('ovelha'),
          pathImage: 'assets/images/ovelha.png',
        ),
        ClickableImage(
          function: () => _playSound('vaca'),
          pathImage: 'assets/images/vaca.png',
        ),
      ],
    );
  }
}
