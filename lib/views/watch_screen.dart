import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hsm_poc/core/constants.dart';
import 'package:hsm_poc/helpers/show_platform_dialog.dart';
import 'package:hsm_poc/widgets/videoplayer.dart';

class WatchScreen extends StatefulWidget {
  @override
  _WatchScreenState createState() => _WatchScreenState();
}

class _WatchScreenState extends State<WatchScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        extendBody: true,
        appBar: AppBar(
          toolbarHeight: 50,
          backgroundColor: Colors.white,
          bottom: TabBar(
            labelColor: Colors.black,
            tabs: [
              Tab(text: 'Sermons'),
              Tab(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.record_voice_over,
                    size: 20,
                    color: Colors.redAccent[700],
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text('LIVE',
                      style: TextStyle(
                        color: Colors.redAccent[700],
                      ))
                ],
              )),
            ],
          ),
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [sermons(), liveBroadcast()],
        ),
      ),
    );
  }

  Widget sermons() {
    List<String> sermonCategories = [
      'The Vibe',
      'Jesus Is',
      'Impact Tonight',
      'Life Lines',
      'Identity',
      'Grace Is',
      'Morning Juice',
      'Moments of Encouragement',
      'One Offs',
      'Moments With...',
      'DIG'
    ];
    return Container(
      child: GridView.count(
          crossAxisCount: 2,
          children: sermonCategories
              .map((i) => GestureDetector(
                    onTap: () {
                      showModal(context,
                          body:
                              'This will open a detail screen showing all videos in the series and give a series summary. Also design is not final');
                    },
                    child: Container(
                        margin: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.blueGrey[900],
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 7,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                              child: Wrap(children: [
                            Text(i,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 22))
                          ])),
                        )),
                  ))
              .toList()),
    );
  }

  Widget liveBroadcast() {
    double screenSize = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Stack(
          children: [
            Container(
                height: ((screenSize) / (16 / 9)),
                width: (screenSize),
                child: VideoApp(
                  assetPath: 'assets/live_preview.mp4',
                  mute: false,
                )),
            Positioned(
                top: 10,
                left: 10,
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'LIVE',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w900),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.red[600],
                      borderRadius: BorderRadius.circular(10)),
                )),
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Center(
                    child: Text('Seriously Getting Serious',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24)),
                  ),
                  SizedBox(height: 5),
                  Center(
                      child: Text('Pastor Roger Reid',
                          style:
                              TextStyle(fontSize: 18, color: kTextLightColor))),
                  SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.all(kDefaultPadding),
                    child: Wrap(
                      children: [
                        Text(
                            'Cover details in this series as well as any other episodes in this series here. Cover key points, questions, and other things down here',
                            style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                  SizedBox(height: 100)
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
