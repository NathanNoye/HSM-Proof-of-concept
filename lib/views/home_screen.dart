import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hsm_poc/core/constants.dart';
import 'package:hsm_poc/core/locator.dart';
import 'package:hsm_poc/core/navigator.dart';
import 'package:hsm_poc/views/events_screen.dart';
import 'package:hsm_poc/views/more_screen.dart';
import 'package:hsm_poc/views/giving_screen.dart';
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
  //HsmNavigator _hsmNavigator = locator<HsmNavigator>();

  double value = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 5);
    locator<HsmNavigator>().init(_tabController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.orangeAccent, Colors.deepOrangeAccent],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter)),
          ),
          SafeArea(
              child: Container(
            width: 200,
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                DrawerHeader(
                    child: Column(
                  children: [
                    CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage('assets/nate.jpeg')),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Hey Nate!',
                        style: TextStyle(color: Colors.white, fontSize: 22)),
                  ],
                )),
                Expanded(
                    child: ListView(
                  children: [
                    ListTile(
                        onTap: () {},
                        leading: Icon(
                          Icons.health_and_safety,
                          color: Colors.white,
                        ),
                        title: Text(
                          'Prayer Request',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )),
                    ListTile(
                        onTap: () {},
                        leading: Icon(
                          Icons.volunteer_activism,
                          color: Colors.white,
                        ),
                        title: Text(
                          'My Giving',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )),
                    ListTile(
                        onTap: () {},
                        leading: Icon(
                          Icons.calendar_today,
                          color: Colors.white,
                        ),
                        title: Text(
                          'Volunteer Schedule',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )),
                    ListTile(
                        onTap: () {},
                        leading: Icon(
                          Icons.settings,
                          color: Colors.white,
                        ),
                        title: Text(
                          'Settings',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )),
                    ListTile(
                        onTap: () {},
                        leading: Icon(
                          Icons.logout,
                          color: Colors.white,
                        ),
                        title: Text(
                          'Log out',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )),
                    ListTile(
                        onTap: () {
                          setState(() {
                            value = 0;
                          });
                        },
                        leading: Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                        title: Text(
                          'Close menu',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ))
                  ],
                ))
              ],
            ),
          )),
          TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: value),
              duration: Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              builder: (_, double val, __) {
                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..setEntry(0, 3, 200 * val)
                    ..rotateY((pi / 6) * val),
                  child: ClipRRect(
                    borderRadius: value == 1
                        ? BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20))
                        : BorderRadius.circular(0),
                    child: Scaffold(
                      appBar: HsmAppBar(
                        tabController: _tabController,
                        onTap: () {
                          setState(() {
                            value == 0 ? value = 1 : value = 0;
                          });
                        },
                      ),
                      extendBody: true,
                      body: TabBarView(
                          controller: _tabController,
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            HomeFeed(),
                            EventsScreen(),
                            WatchScreen(),
                            GivingScreen(),
                            MoreScreen(),
                          ]),
                      floatingActionButtonLocation:
                          FloatingActionButtonLocation.centerDocked,
                      floatingActionButton: FloatingActionButton(
                          onPressed: () {
                            _tabController.animateTo(2);
                          },
                          tooltip: 'watch',
                          child: Container(
                              child: Icon(Icons.play_arrow),
                              width: 55,
                              height: 55,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  gradient: LinearGradient(
                                      colors: [
                                        Colors.orange[600]!,
                                        Colors.orange[900]!
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter))),
                          elevation: 2.0,
                          shape: CircleBorder(
                              side: BorderSide(color: Colors.white, width: 2)),
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
                            Tab(
                                icon: Icon(Icons.local_activity),
                                text: 'Events'),
                            Tab(
                                icon:
                                    Icon(Icons.play_arrow, color: Colors.white),
                                text: 'Watch'),
                            Tab(
                                icon: Icon(Icons.volunteer_activism),
                                text: 'Give'),
                            Tab(icon: Icon(Icons.apps), text: 'More'),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
          /*
          GestureDetector(
            onTap: () {
              setState(() {
                value = 0;
              });
            },
            
          )*/
        ],
      ),
    );

/*
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
            GivingScreen(),
            MoreScreen(),
          ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            _tabController.animateTo(2);
          },
          tooltip: 'watch',
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
            Tab(icon: Icon(Icons.volunteer_activism), text: 'Give'),
            Tab(icon: Icon(Icons.apps), text: 'More'),
          ],
        ),
      ),
    );
  */
  }
}

/*
Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.orangeAccent, Colors.deepOrangeAccent],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter)),
          ),
          SafeArea(
              child: Container(
            width: 200,
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                DrawerHeader(
                    child: Column(
                  children: [
                    CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage('assets/roger.jpg')),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Roger Reid',
                        style: TextStyle(color: Colors.white, fontSize: 22)),
                  ],
                )),
                Expanded(
                    child: ListView(
                  children: [
                    ListTile(
                        onTap: () {},
                        leading: Icon(
                          Icons.health_and_safety,
                          color: Colors.white,
                        ),
                        title: Text(
                          'Prayer Request',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )),
                    ListTile(
                        onTap: () {},
                        leading: Icon(
                          Icons.volunteer_activism,
                          color: Colors.white,
                        ),
                        title: Text(
                          'My Giving',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )),
                    ListTile(
                        onTap: () {},
                        leading: Icon(
                          Icons.calendar_today,
                          color: Colors.white,
                        ),
                        title: Text(
                          'Volunteer Schedule',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )),
                    ListTile(
                        onTap: () {},
                        leading: Icon(
                          Icons.settings,
                          color: Colors.white,
                        ),
                        title: Text(
                          'Settings',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )),
                    ListTile(
                        onTap: () {},
                        leading: Icon(
                          Icons.logout,
                          color: Colors.white,
                        ),
                        title: Text(
                          'Log out',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ))
                  ],
                ))
              ],
            ),
          )),
          TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: value),
              duration: Duration(milliseconds: 500),
              builder: (_, double val, __) {
                return Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..setEntry(0, 3, 200 * val)
                      ..rotateX((pi / 6) * val));
              })
/*
          TabBarView(
              controller: _tabController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                HomeFeed(),
                EventsScreen(),
                WatchScreen(),
                GivingScreen(),
                MoreScreen(),
              ]),
              */
        ],
      )
 */