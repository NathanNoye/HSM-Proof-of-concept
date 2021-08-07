import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hsm_poc/helpers/show_platform_dialog.dart';

class MoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> sermonCategories = [
      'Alerts',
      'App Version',
      'Volunteer',
      'My Giving',
      'Instagram',
      'Facebook',
      'YouTube'
    ];

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            children: sermonCategories
                .map((i) => GestureDetector(
                      onTap: () {
                        showModal(context,
                            body:
                                'This will open a detail screen allowing the students to manage parts of the app.');
                      },
                      child: Container(
                          //margin: EdgeInsets.all(16),
                          color: Colors.black,
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
      ),
    );
  }
}
