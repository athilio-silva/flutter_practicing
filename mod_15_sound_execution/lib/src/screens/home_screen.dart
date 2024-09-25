import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:mod_15_sound_execution/src/widgets/buttom_sound.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AudioPlayer audioPlayer = AudioPlayer();
  bool firstPlay = true;
  double value = 0.8;
  Duration currentPosition = Duration.zero;
  Duration duration = Duration.zero;

  // Recuperando som da internet
  // void _playSound() async {
  //   String url = 'https://ccrma.stanford.edu/~jos/wav/gtr-jaz-2.wav';
  //   await audioPlayer.setSource(UrlSource(url));
  //   await audioPlayer.resume();
  // }

  void _playSoundLocal() async {
    String sound = 'oboe-bassoon.wav';
    audioPlayer.audioCache = AudioCache(prefix: 'assets/sounds/');
    audioPlayer.setVolume(value);

    audioPlayer.onDurationChanged.listen((Duration d) {
      setState(() => duration = d);
      debugPrint('Duration: $duration');
    });

    audioPlayer.onPlayerComplete.listen((event) {
      setState(() {
        firstPlay = true;
        currentPosition = Duration.zero;
      });
    });

    audioPlayer.onPositionChanged.listen((Duration p) {
      setState(() => currentPosition = p);
    });

    if (firstPlay) {
      setState(() {
        firstPlay = false;
      });
      await audioPlayer.play(AssetSource(sound));
    } else {
      _resumeSound();
    }
  }

  void _pauseSound() async {
    await audioPlayer.pause();
  }

  void _stopSound() async {
    await audioPlayer.stop();
    setState(() {
      firstPlay = true;
    });
  }

  void _resumeSound() async {
    await audioPlayer.resume();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Executando som'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          audioPlayer.dispose();
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Text(
              'Volume:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Slider(
            value: value,
            min: 0.0,
            max: 1.0,
            onChanged: (newValue) {
              setState(() {
                value = newValue;
              });
              audioPlayer.setVolume(value);
            },
          ),
          const Spacer(),
          const Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Text(
              'Duração:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Slider(
            value: currentPosition.inSeconds.toDouble(),
            min: 0.0,
            max: duration.inSeconds.toDouble(),
            onChanged: (newPosition) {
              audioPlayer.seek(Duration(seconds: newPosition.toInt()));
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ButtomSound(
                function: _playSoundLocal,
                pathImage: 'assets/images/executar.png',
              ),
              ButtomSound(
                function: _pauseSound,
                pathImage: 'assets/images/pausar.png',
              ),
              ButtomSound(
                function: _stopSound,
                pathImage: 'assets/images/parar.png',
              ),
            ],
          ),
          const SizedBox(height: 62.0),
        ],
      ),
    );
  }
}
