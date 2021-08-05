import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:hsm_poc/core/constants.dart';
import 'package:hsm_poc/models/event_model.dart';
import 'package:hsm_poc/models/sermon_model.dart';

class EventsScreen extends StatefulWidget {
  @override
  _EventsScreenState createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  Random random = Random();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: events.length,
        physics: BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) =>
            _buildTileItem(events[index]));
  }

  Widget _buildTileItem(EventModel sermon) {
    double screenSize = MediaQuery.of(context).size.width;

    return Stack(
      alignment: Alignment(0, 0),
      children: [
        Container(
          height: ((screenSize) / (16 / 6)).clamp(100, 400),
          width: (screenSize).clamp(200, 500),
          margin: EdgeInsets.all(kDefaultPadding / 2),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: ExactAssetImage(sermon.imagePath),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.5), BlendMode.dstATop),
            ),
            borderRadius: BorderRadius.circular(20),
            color: Colors.black,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 7,
                offset: Offset(0, 5),
              ),
            ],
          ),
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: kDefaultPadding),
              child: Text(sermon.title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      color: Colors.white)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: kDefaultPadding),
              child: Text(sermon.speaker,
                  style: TextStyle(fontSize: 20, color: Colors.white)),
            ),
            SizedBox(height: 10),
            CountdownTimer(
              endTime: sermon.eventTime.millisecondsSinceEpoch,
              widgetBuilder: (_, CurrentRemainingTime? time) {
                if (time == null) {
                  return Text('Game over');
                }
                return Text(
                  '${time.days} Days ${time.hours} : ${time.min} : ${time.sec}',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                );
              },
            ),
          ],
        )
      ],
    );
  }

  List<EventModel> events = [
    EventModel(
        'Nacho night',
        'September 12, 2021',
        'assets/events/nacho_night.jpg',
        'https://www.youtube.com/watch?v=c6CkBjoKZQA&list=PLbMfNdlwiS7mokKD9CGHfOK-dXcsQlRJv&index=1',
        eventTime: DateTime(2021, 9, 12, 19, 30),
        cost: 0.00),
    EventModel(
        'Mexico Mission Trip',
        'November 25, 2021',
        'assets/events/mission_trip.jpg',
        'https://www.youtube.com/watch?v=voqSvY5JNuI&list=PLbMfNdlwiS7mokKD9CGHfOK-dXcsQlRJv&index=2',
        eventTime: DateTime(2021, 10, 25, 10, 00),
        cost: 3500.00),
    EventModel(
      'Winter Retreat',
      'January 10, 2022',
      'assets/events/winter_retreat.jpg',
      'https://www.youtube.com/watch?v=voqSvY5JNuI&list=PLbMfNdlwiS7mokKD9CGHfOK-dXcsQlRJv&index=2',
      eventTime: DateTime(2022, 1, 10, 7, 30),
      cost: 100.00,
    ),
    EventModel(
      'Home Retreat',
      'Feb 28, 2022',
      'assets/livestream.png',
      'https://www.youtube.com/watch?v=voqSvY5JNuI&list=PLbMfNdlwiS7mokKD9CGHfOK-dXcsQlRJv&index=2',
      eventTime: DateTime(2022, 2, 28, 19, 00),
      cost: 75.00,
    ),
  ];
}
