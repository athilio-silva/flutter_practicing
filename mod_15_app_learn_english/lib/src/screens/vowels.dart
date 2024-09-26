import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:mod_15_app_learn_english/src/widgets/clickable_image.dart';

class Vowels extends StatefulWidget {
  const Vowels({super.key});

  @override
  State<Vowels> createState() => _VowelsState();
}

class _VowelsState extends State<Vowels> {
  final audioPlayer = AudioPlayer();

  void _playSound(String vowel) async {
    audioPlayer.audioCache = AudioCache(prefix: 'assets/sounds/');
    await audioPlayer.play(AssetSource('$vowel.mp3'));
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
          function: () =>_playSound('a'),
          pathImage: 'assets/images/a.png',
        ),
        ClickableImage(
          function: () => _playSound('e'),
          pathImage: 'assets/images/e.png',
        ),
        ClickableImage(
          function: () => _playSound('i'),
          pathImage: 'assets/images/i.png',
        ),
        ClickableImage(
          function: () =>_playSound('o'),
          pathImage: 'assets/images/o.png',
        ),
        ClickableImage(
          function: () => _playSound('u'),
          pathImage: 'assets/images/u.png',
        ),
      ],
    );
  }
}