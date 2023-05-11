import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AudioPlayerScreen extends StatefulWidget {
  @override
  State<AudioPlayerScreen> createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  AudioPlayer player = AudioPlayer();
  int isPlaying = 0;
  int isPaused = 0;
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("asset/audio/apple.jpg"),
              isPlaying == 1
                  ? IconButton(
                      onPressed: () async {
                        var result = await player.pause();
                        setState(() {
                          isPlaying = 0;
                          isPaused = result;
                        });
                      },
                      icon: Icon(Icons.pause))
                  : IconButton(
                      onPressed: () async {
                                   String audioasset2 = "asset/audio/cheer.mp3";
                        ByteData bytes2 = await rootBundle
                            .load(audioasset2); //load audio from assets
                        Uint8List audiobytes2 = bytes2.buffer.asUint8List(
                            bytes2.offsetInBytes, bytes2.lengthInBytes);
                        var result = await player.playBytes(audiobytes2);
                        setState(() {
                          isPlaying = result;
                        });
                      },
                      icon: Icon(
                        Icons.play_arrow,
                        size: 50,
                      )),
              isPaused == 1
                  ? IconButton(
                      onPressed: () async {
                        await player.resume();
                      },
                      icon: Icon(Icons.play_circle))
                  : Container()
            ],
          )),
        ));
  }
}
