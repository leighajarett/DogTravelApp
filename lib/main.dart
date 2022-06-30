import 'package:flutter/material.dart';
import 'package:my_app/choose_album.dart';
import 'package:my_app/home.dart';
import 'package:my_app/timeline.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(DogTravels());
}

class DogTravels extends StatelessWidget {
  DogTravels({Key? key}) : super(key: key);
  final PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "My Dog's World Travels",
        // home: const XDHome(),
        theme: ThemeData(scaffoldBackgroundColor: const Color(0xff19b6ee)),
        home: Scaffold(
          body: PageView(
              controller: pageController,
              scrollDirection: Axis.vertical,
              children: [
                const Home(),
                ChooseAlbum(
                  pageController,
                ),
                const Timeline()
              ]),
        ));
  }
}
