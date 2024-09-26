import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:mod_15_app_learn_english/src/widgets/clickable_image.dart';

class Numbers extends StatefulWidget {
  const Numbers({super.key});

  @override
  State<Numbers> createState() => _NumbersState();
}

class _NumbersState extends State<Numbers> {
  final audioPlayer = AudioPlayer();

  void _playSound(String number) async {
    audioPlayer.audioCache = AudioCache(prefix: 'assets/sounds/');
    await audioPlayer.play(AssetSource('$number.mp3'));
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
          function: () =>_playSound('1'),
          pathImage: 'assets/images/1.png',
        ),
        ClickableImage(
          function: () => _playSound('2'),
          pathImage: 'assets/images/2.png',
        ),
        ClickableImage(
          function: () => _playSound('3'),
          pathImage: 'assets/images/3.png',
        ),
        ClickableImage(
          function: () =>_playSound('4'),
          pathImage: 'assets/images/4.png',
        ),
        ClickableImage(
          function: () => _playSound('5'),
          pathImage: 'assets/images/5.png',
        ),
        ClickableImage(
          function: () => _playSound('6'),
          pathImage: 'assets/images/6.png',
        ),
      ],
    );
  }
}
