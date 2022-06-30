import 'package:adobe_xd/pinned.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Pinned.fromPins(
          Pin(size: 169.0, start: 24.6),
          Pin(size: 428.0, middle: 0.2669),
          child: Transform.rotate(
            angle: -0.3142,
            child: BorderedText(
              strokeWidth: 2.0,
              strokeColor: Colors.black,
              child: const Text(
                'Oh',
                style: TextStyle(
                  fontFamily: 'GoodDog New',
                  fontSize: 128,
                  color: Color(0xffffca0d),
                  shadows: [
                    Shadow(
                      color: Color(0xfa000000),
                      offset: Offset(-3, 1),
                    )
                  ],
                ),
                softWrap: false,
              ),
            ),
          ),
        ),
        Align(
          alignment: const Alignment(0.05, -.38),
          child: SizedBox(
            width: 53.0,
            height: 40.0,
            child: Transform.rotate(
              angle: -0.2,
              child: BorderedText(
                strokeWidth: 2.0,
                strokeColor: Colors.black,
                child: const Text(
                  'the',
                  style: TextStyle(
                    fontFamily: 'GoodDog New',
                    fontSize: 30,
                    color: Color(0xffb7c245),
                    shadows: [
                      Shadow(
                        color: Color(0xfa000000),
                        offset: Offset(-2, 1),
                      )
                    ],
                  ),
                  softWrap: false,
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: const Alignment(0.4, -0.3),
          child: SizedBox(
            width: 110.0,
            height: 45.0,
            child: Transform.rotate(
              angle: -0.2,
              child: BorderedText(
                strokeWidth: 2.0,
                strokeColor: Colors.black,
                child: const Text(
                  'Places',
                  style: TextStyle(
                    fontFamily: 'GoodDog New',
                    fontSize: 40,
                    color: Color(0xffe99dbf),
                    shadows: [
                      Shadow(
                        color: Color(0xfa000000),
                        offset: Offset(-2, 1),
                      )
                    ],
                  ),
                  softWrap: false,
                ),
              ),
            ),
          ),
        ),
        Pinned.fromPins(
          Pin(size: 157.0, end: 70.5),
          Pin(size: 624.0, middle: 0.3539),
          child: Transform.rotate(
            angle: -0.1745,
            child: BorderedText(
              strokeWidth: 1.0,
              strokeColor: Colors.black,
              child: const Text(
                'Go',
                style: TextStyle(
                  fontFamily: 'GoodDog New',
                  fontSize: 124,
                  color: Color(0xff19b6ee),
                  shadows: [
                    Shadow(
                      color: Color(0xfa000000),
                      offset: Offset(-2, 1),
                    )
                  ],
                ),
                softWrap: false,
              ),
            ),
          ),
        ),
        Align(
          alignment: const Alignment(-0.448, -0.08),
          child: SizedBox(
            width: 84.0,
            height: 41.0,
            child: Transform.rotate(
              angle: -0.2,
              child: const Text(
                'You’ll',
                style: TextStyle(
                  fontFamily: 'GoodDog New',
                  fontSize: 41,
                  color: Color(0xff040504),
                ),
                softWrap: false,
              ),
            ),
          ),
        ),
        Pinned.fromPins(
          Pin(size: 200.0, start: 18),
          Pin(size: 50.0, middle: 0.52),
          child: Transform.rotate(
            angle: -0.2,
            child: AnimatedTextKit(
              animatedTexts: [
                TyperAnimatedText('Your Dog',
                    textStyle: const TextStyle(
                      fontFamily: 'GoodDog New',
                      fontSize: 45,
                      color: Color(0xffea3927),
                    ),
                    speed: const Duration(milliseconds: 300)),
              ],
              // softWrap: false,
              isRepeatingAnimation: false,
            ),
          ),
        ),
        Align(
          alignment: const Alignment(-0.467, -0.07),
          child: SizedBox(
            width: 28.0,
            height: 55.0,
            child: Transform.rotate(
              angle: 1.4137,
              child: const Text(
                'X',
                style: TextStyle(
                  fontFamily: 'GoodDog New',
                  fontSize: 55,
                  color: Color(0xffea3927),
                ),
                softWrap: false,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
