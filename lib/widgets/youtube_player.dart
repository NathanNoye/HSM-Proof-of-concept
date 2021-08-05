import 'package:flutter/cupertino.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeVideoPlayer extends StatelessWidget {
  final String url;
  final String thumbnail;

  const YoutubeVideoPlayer(
      {Key? key, required this.url, required this.thumbnail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(url)!,
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );

    return YoutubePlayer(
      controller: _controller,
      bottomActions: [
        CurrentPosition(),
        ProgressBar(isExpanded: true),
      ],
      thumbnail: Image.asset(thumbnail),
    );
  }
}
