import 'package:flutter/material.dart';
import 'package:my_app/homescreen_widgets/xd_cloud.dart';
import './homescreen_widgets//xd_pink_balloon.dart';
import './homescreen_widgets//xd_big_cloud.dart';
import './homescreen_widgets//xd_cloud2.dart';
import './homescreen_widgets//xd_orange_balloon.dart';
import './homescreen_widgets//xd_green_balloon.dart';
import './homescreen_widgets//xd_orange_balloon2.dart';
import './homescreen_widgets//xd_yellow_balloon2.dart';
import './homescreen_widgets//xd_yellow_balloon.dart';
import './homescreen_widgets//xd_green_balloon2.dart';
import './homescreen_widgets//logo.dart';
import 'package:rive/rive.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'dart:math' as math;

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  // ScrollController controller = ScrollController(initialScrollOffset: 10.0);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Stack(
        children: <Widget>[
          const Positioned(
            top: 460,
            left: 120,
            child: XDPinkBalloon(),
          ),
          const Positioned(
            top: 140,
            left: -80,
            child: XDBigCloud(),
          ),
          Positioned(
              top: 0,
              left: 200,
              child:
                  Transform.rotate(angle: math.pi / 5, child: const XDCloud())),
          const Positioned(top: 610, left: 5, child: XDCloud2()),
          const Positioned(top: 740, left: 280, child: XDYellowBalloon2()),
          const Positioned(top: 510, left: 300, child: XDOrangeBalloon2()),
          const Positioned(top: 590, left: 50, child: XDGreenBalloon()),
          const Positioned(
            top: 0,
            left: 60,
            child: XDGreenBalloon2(),
          ),
          const Positioned(top: 150, left: 5, child: XDOrangeBalloon()),
          const Positioned(top: 90, left: 220, child: XDYellowBalloon()),
          const Logo(),
          const Center(
              child: RiveAnimation.asset(
            'animations/dog_flying.riv',
            animations: ['Animation 3'],
            fit: BoxFit.cover,
          ))
        ],
      ),
      Padding(
        padding: const EdgeInsets.all(30.0),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: AnimatedTextKit(
            animatedTexts: [
              FadeAnimatedText('Scroll down to get started',
                  textStyle: const TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 15,
                    color: Color(0xffffffff),
                    height: 1,
                  )),
            ],
            repeatForever: true,
            isRepeatingAnimation: true,
            pause: const Duration(milliseconds: 1000),
          ),
        ),
      )
    ]);
  }
}
