import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:mulaney_soundboard/sounds.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.lightBlue,
      ),
      home: MyHomePage(title: 'Mulaney Soundboard'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

AudioPlayer audioPlayer = AudioPlayer();
AudioCache audioCache = AudioCache(fixedPlayer: audioPlayer);

final List<String> _quotes = MulaneyQuotes().quotes;

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    initSounds();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void initSounds() {
    audioPlayer = AudioPlayer();
    audioCache = AudioCache(fixedPlayer: audioPlayer);
    audioCache.loadAll(_quotes);
  }

  void playSound(quote) async {
    var filename = quote;
    if (audioPlayer.state == AudioPlayerState.PLAYING) {
      audioPlayer.stop();
    }
    audioPlayer = await audioCache.play(filename);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        /* appBar: AppBar(
          title: Text(widget.title),
        ), */
        body: Center(
          child: GestureDetector(
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: new BorderRadius.circular(300),
                  image: new DecorationImage(image: new AssetImage('assets/images/mulaney_1.png'), fit: BoxFit.fill,),
                  ),
            ),
            onTap: () {
              if (mounted) {
                setState(() {
                  playSound(_quotes[1]);
                });
              }
            },
            onLongPress: () {
              if (mounted) {
                setState(() {
                  playSound(_quotes[0]);
                });
              }
            },
          ),
        ),
      );
  }
}
