import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class XDCloud2 extends StatelessWidget {
  const XDCloud2({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      width: 300,
      child: Stack(
        children: <Widget>[
          SizedBox.expand(
              child: SvgPicture.string(
            _svg_quxym4,
            allowDrawingOutsideViewBox: true,
            fit: BoxFit.fill,
          )),
        ],
      ),
    );
  }
}

// ignore: constant_identifier_names
const String _svg_quxym4 =
    '<svg viewBox="0.0 0.0 252.8 196.4" ><path transform="matrix(-0.987688, -0.156434, 0.156434, -0.987688, 227.38, 196.39)" d="M 153.1892700195312 0.5645939707756042 L 62.29577255249023 0.5645939707756042 C 62.15460586547852 0.5516870617866516 62.01189804077148 0.5389189124107361 61.87047576904297 0.5265472531318665 C 55.39077377319336 -0.04006896167993546 49.12062835693359 -0.002854966791346669 43.21518325805664 0.5645939707756042 L 42.00334548950195 0.5645939707756042 L 42.00334548950195 0.6889842748641968 C 18.35029983520508 3.273998737335205 0.8608816862106323 14.42824363708496 0.03071802295744419 29.27289962768555 C -0.7139753699302673 42.58922576904297 12.14594745635986 55.29740524291992 31.50197982788086 62.59233093261719 C 24.57398796081543 70.03395843505859 19.08601760864258 79.85400390625 16.05286598205566 91.3111572265625 C 7.884686946868896 122.1653289794922 20.63086128234863 153.1925811767578 44.52203750610352 160.6124267578125 C 59.22945785522461 165.1803894042969 74.73236846923828 159.73779296875 86.38307952880859 147.6802062988281 C 101.4227447509766 161.6719360351562 119.8594512939453 166.5614624023438 134.5594329833984 158.4489288330078 C 145.4969329833984 152.4126739501953 152.2740936279297 140.3322448730469 154.3631896972656 125.7274475097656 C 176.7359924316406 140.15380859375 202.1360321044922 140.0044555664062 215.7274169921875 123.6546936035156 C 229.3241577148438 107.2985916137695 226.7982788085938 79.90636444091797 211.1983489990234 57.30985641479492 C 221.5068511962891 54.20202255249023 228.5613098144531 48.47864151000977 229.9601287841797 40.84718704223633 C 232.7867584228516 25.42613792419434 211.4335327148438 8.056364059448242 182.2664642333984 2.050695180892944 C 175.5106506347656 0.6596214771270752 168.9241027832031 0.0002775910252239555 162.7619781494141 2.260937037590338e-08 C 159.4349365234375 -0.0001585879072081298 156.2323608398438 0.191938579082489 153.1892700195312 0.5645939707756042 Z" fill="#ffffff" stroke="#707070" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
