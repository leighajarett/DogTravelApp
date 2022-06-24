import 'package:flutter/material.dart';
import 'package:my_app/xd_home.dart';
import 'swipe_detector.dart';

// class ChooseAlbum extends StatelessWidget {
//   const ChooseAlbum({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SwipeDetector(
//         child: Text('This is choose album'),
//         onSwipeDown: () {
//           Navigator.push(context, MaterialPageRoute(builder: (context) {
//             return XDHome();
//           }));
//         });
//   }
// }

class ChooseAlbum extends StatelessWidget {
  const ChooseAlbum({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('This is choose album');
  }
}
