import 'package:flutter/cupertino.dart';

class EventsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text('Events Screen'),
      Text('See upcoming events and where'),
      Text('Register for events and pay'),
      Text('Share buttons to share with friends'),
    ]));
  }
}
