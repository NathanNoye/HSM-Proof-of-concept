import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hsm_poc/core/constants.dart';
import 'package:hsm_poc/core/giving_types.dart';
import 'package:hsm_poc/helpers/show_platform_dialog.dart';
import 'package:hsm_poc/models/giving_model.dart';
import 'dart:math';

class GivingScreen extends StatefulWidget {
  @override
  _GivingScreenState createState() => _GivingScreenState();
}

class _GivingScreenState extends State<GivingScreen> {
  double _currentGivingValue = 15;
  GivingTypes givingType = GivingTypes.oneTime;

  List<GivingModel> givingTypesNamesOne = [
    GivingModel('One Time', GivingTypes.oneTime),
    GivingModel('Weekly', GivingTypes.weekly),
  ];
  List<GivingModel> givingTypesNamesTwo = [
    GivingModel('Bi-Weekly', GivingTypes.biweekly),
    GivingModel('Monthly', GivingTypes.monthly),
  ];

  late ConfettiController _confettiController;
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _confettiController =
        new ConfettiController(duration: Duration(seconds: 4));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Stack(
        children: [
          Column(children: [
            SizedBox(height: 20),
            Center(
              child: Neumorphic(
                style: NeumorphicStyle(
                    shadowLightColor: Colors.white,
                    border:
                        NeumorphicBorder(color: Colors.grey.withOpacity(0.1)),
                    shape: NeumorphicShape.concave,
                    boxShape:
                        NeumorphicBoxShape.roundRect(BorderRadius.circular(25)),
                    depth: 5,
                    lightSource: LightSource.topLeft,
                    surfaceIntensity: 0.2,
                    color: kBackgroundColor),
                child: Container(
                  padding: EdgeInsets.all(30),
                  constraints: BoxConstraints(maxWidth: 325),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${_currentGivingValue.toStringAsFixed(0)}',
                          style: TextStyle(
                              fontSize: 150, fontWeight: FontWeight.w200)),
                      Text('\$',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w200)),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Container(
                constraints: BoxConstraints(maxWidth: 400),
                padding: EdgeInsetsDirectional.all(10),
                child: NeumorphicSlider(
                  min: 5,
                  max: 100,
                  value: _currentGivingValue,
                  style: SliderStyle(
                      accent: Colors.orangeAccent.shade700,
                      variant: Colors.red),
                  onChanged: (double value) {
                    setState(() {
                      _currentGivingValue = value;
                    });
                  },
                ),
              ),
            ),
            givingButtons(givingTypesNamesOne),
            givingButtons(givingTypesNamesTwo),
            SizedBox(
              height: 35,
            ),
            TextButton(
              onPressed: () {
                showModal(context,
                    title: 'Confirm giving',
                    body:
                        'Donate \$${_currentGivingValue.toStringAsFixed(0)} ${givingType.toString().split(".")[1]} to Hillside Student Ministries?',
                    actions: [
                      BasicDialogAction(
                        title: Text("Cancel"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      BasicDialogAction(
                        title: Text("Looks good"),
                        onPressed: () {
                          Navigator.pop(context);

                          showDialog(
                              context: context,
                              builder: (_) => Center(
                                    child: CircularProgressIndicator(),
                                  ));

                          Future.delayed(Duration(seconds: 3), () {
                            Navigator.pop(context);

                            showModal(context,
                                title: 'Giving Success!',
                                body:
                                    'Thanks to you, you\'ve helped further God\'s kingdom. To see the details of this giving, visits "my givings" in your account.');

                            _confettiController.play();
                            audioPlayer.play('assets/ding.mp3', isLocal: true);
                            HapticFeedback.heavyImpact();
                          });
                        },
                      )
                    ]);
                setState(() {});
              },
              child: Container(
                width: 100,
                child: Center(
                  child: Text(
                    'Donate',
                  ),
                ),
              ),
              style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.symmetric(vertical: 10, horizontal: 20)),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.black)),
            ),
          ]),
          Align(
            alignment: Alignment(0, -0.3),
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirection: 10,
              maxBlastForce: 7,
              minBlastForce: 5,
              emissionFrequency: 0.05,
              colors: [
                Colors.teal,
                Colors.deepOrangeAccent.shade700,
                Colors.green
              ],
            ),
          ),
          Align(
            alignment: Alignment(0, -0.3),
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirection: pi - 10,
              maxBlastForce: 7,
              minBlastForce: 5,
              emissionFrequency: 0.05,
              colors: [
                Colors.teal,
                Colors.deepOrangeAccent.shade700,
                Colors.green
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget givingButtons(List<GivingModel> models) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: models
            .map((e) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 7),
                  child: TextButton(
                    onPressed: () {
                      givingType = e.givingType;
                      setState(() {});
                    },
                    child: Text(
                      e.givingNamePretty,
                    ),
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20)),
                        foregroundColor: e.givingType == givingType
                            ? MaterialStateProperty.all<Color>(Colors.white)
                            : MaterialStateProperty.all<Color>(Colors.black),
                        backgroundColor: e.givingType == givingType
                            ? MaterialStateProperty.all<Color>(Colors.grey)
                            : MaterialStateProperty.all<Color>(Colors.white)),
                  ),
                ))
            .toList());
  }
}
