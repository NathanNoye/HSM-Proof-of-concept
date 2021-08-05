import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:video_player/video_player.dart';

class VideoApp extends StatefulWidget {
  final String assetPath;
  final bool mute;

  const VideoApp({Key? key, required this.assetPath, this.mute = true})
      : super(key: key);

  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.assetPath)
      ..initialize().then((_) {
        _controller.setLooping(true);
        _controller.play();
        if (widget.mute) _controller.setVolume(0);
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: _controller.value.isInitialized
            ? VideoPlayer(_controller)
            : Container());
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
