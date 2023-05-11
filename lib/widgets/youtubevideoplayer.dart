import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class YoutubeVideoPlayer extends StatefulWidget {
  @override
  State<YoutubeVideoPlayer> createState() => _YoutubeVideoPlayerState();
}

class _YoutubeVideoPlayerState extends State<YoutubeVideoPlayer> {
  late YoutubePlayerController _controller;
  @override
  void initState() {
    // TODO: implement initState
    _controller = YoutubePlayerController(
        params: YoutubePlayerParams(
      mute: false,
      showControls: true,
      showFullscreenButton: true,
    ));

    _controller.loadVideoById(videoId: "QV2WS535nyI");
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Youtube")),
      body: Container(
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: _controller != null
              ? YoutubePlayer(controller: _controller)
              : Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
