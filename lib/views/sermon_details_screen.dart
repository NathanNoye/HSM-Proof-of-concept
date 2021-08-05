import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hsm_poc/core/constants.dart';
import 'package:hsm_poc/models/sermon_model.dart';
import 'package:hsm_poc/widgets/youtube_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class SermonDetailsScreen extends StatefulWidget {
  final SermonModel model;

  const SermonDetailsScreen({Key? key, required this.model}) : super(key: key);

  @override
  _SermonDetailsScreenState createState() => _SermonDetailsScreenState();
}

class _SermonDetailsScreenState extends State<SermonDetailsScreen> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _isVisible = true;
      setState(() {});
    });

    return Scaffold(
        backgroundColor: kTextColor,
        body: Hero(
          tag: widget.model.title,
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      youtubePlayer(),
                      Padding(
                        padding: const EdgeInsets.all(kDefaultPadding),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  fadeInInformation(),
                ],
              ),
            ),
          ),
        ));
  }

  Widget youtubePlayer() {
    /*
    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.model.url)!,
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
      thumbnail: Image.asset(widget.model.imagePath),
    );
    */

    return YoutubeVideoPlayer(
      url: widget.model.url,
      thumbnail: widget.model.imagePath,
    );
  }

  Widget fadeInInformation() {
    return AnimatedOpacity(
      opacity: _isVisible ? 1 : 0,
      duration: Duration(milliseconds: 500),
      child: Column(
        children: [
          SizedBox(height: 20),
          Center(
            child: Text(widget.model.title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.white)),
          ),
          SizedBox(height: 5),
          Center(
              child: Text(widget.model.speaker,
                  style: TextStyle(fontSize: 18, color: kTextLightColor))),
          SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Wrap(
              children: [
                Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc auctor egestas nibh vitae consectetur. Sed porttitor ullamcorper egestas. Proin nec dictum ligula, eget consequat nisi. Maecenas quis turpis neque. Etiam ut feugiat massa. Proin ut tristique justo, vestibulum hendrerit nunc. Proin ultricies mi a auctor malesuada. Cras bibendum vulputate porta..',
                    style: TextStyle(fontSize: 16, color: Colors.white)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
