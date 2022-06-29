// ignore_for_file: prefer_const_constructors

// import 'package:flutter/material.dart';
// import 'package:my_app/choose_album.dart';
// import 'package:my_app/home.dart';

// class XDHome extends StatefulWidget {
//   const XDHome({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<XDHome> createState() => _XDHomeState();
// }

// class _XDHomeState extends State<XDHome> {
//   ScrollController _controller = ScrollController(initialScrollOffset: 10.0);
//   bool showAlbum = false;

//   @override
//   void initState() {
//     _controller.addListener(() {
//       if (_controller.offset > 150) {
//         setState(() {
//           showAlbum = true;
//         });
//       }
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (showAlbum) {
//       Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => ChooseAlbum(),
//           ));
//     } else {
//       Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => Home(
//               controller: _controller,
//             ),
//           ));

//       return Text('');
//     }
//   }
// }

// class TiktokScrollWidget extends StatelessWidget {
//   final List<String> list = <String>['1', '2', '3', '4', '5'];
//   TiktokScrollWidget({Key? key}) : super(key: key);
//   PageController pageController = PageController(initialPage: 1);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: Scaffold(
//         appBar: AppBar(title: const Text("Readerstack")),
//         body: PageView(
//             controller: pageController,
//             scrollDirection: Axis.vertical,
//             children: buildContainers()),
//       ),
//     );
//   }
// }



// // GestureDetector(
// //     onVerticalDragUpdate: ((details) {
// //       Navigator.push(context, MaterialPageRoute(builder: (context) {
// //         return ChooseAlbum();
// //       }));
// //     }),
// //     child:
// //     Scaffold(
// //   body: DraggableScrollableSheet(
// //       builder: (BuildContext context, ScrollController scrollController) {
// //     return SingleChildScrollView(
// //         child: Stack(children: <Widget>[
// //       Positioned(top: 20, left: 500, child: XDBigCloud())
// //     ]));
// //     // );
// //   }),
// // );
// //   }
// // }

// // class _XDHomeState extends State<XDHome> {

// // }
