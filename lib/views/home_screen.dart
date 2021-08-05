import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hsm_poc/core/constants.dart';
import 'package:hsm_poc/views/events_screen.dart';
import 'package:hsm_poc/views/more_screen.dart';
import 'package:hsm_poc/views/serve_screen.dart';
import 'package:hsm_poc/views/watch_screen.dart';
import 'package:hsm_poc/widgets/hsm_appbar.dart';

import 'home_feed.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 5);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HsmAppBar(
        tabController: _tabController,
      ),
      extendBody: true,
      body: TabBarView(
          controller: _tabController,
          physics: NeverScrollableScrollPhysics(),
          children: [
            HomeFeed(),
            EventsScreen(),
            WatchScreen(),
            ServeScreen(),
            MoreScreen(),
          ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            _tabController.animateTo(2);
          },
          tooltip: 'watch',
          //child: Icon(Icons.play_arrow),
          child: Container(
              child: Icon(Icons.play_arrow),
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  gradient: LinearGradient(
                      colors: [Colors.orange[600]!, Colors.orange[900]!],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter))),
          elevation: 2.0,
          shape: CircleBorder(side: BorderSide(color: Colors.white, width: 2)),
          backgroundColor: Colors.orange[900]),
      bottomNavigationBar: BottomAppBar(
        elevation: 2,
        color: Colors.white,
        shape: CircularNotchedRectangle(),
        child: TabBar(
          controller: _tabController,
          labelColor: Colors.orange[900],
          unselectedLabelColor: kTextColor,
          indicatorWeight: 0.1,
          tabs: [
            Tab(icon: Icon(Icons.home), text: 'Home'),
            Tab(icon: Icon(Icons.local_activity), text: 'Events'),
            Tab(
                icon: Icon(Icons.play_arrow, color: Colors.white),
                text: 'Watch'),
            Tab(icon: Icon(Icons.volunteer_activism), text: 'Serve'),
            Tab(icon: Icon(Icons.apps), text: 'More'),
          ],
        ),
      ),
    );
  }
}
