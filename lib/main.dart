import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_app/choose_album.dart';
import 'package:my_app/home.dart';
import 'package:my_app/timeline.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // final functions =
  //     FirebaseFunctions.instance.useFunctionsEmulator('localhost', 5001);
  // final storage =
  //     FirebaseStorage.instance.useStorageEmulator('localhost', 9199);
  // final firestore =
  //     FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
  // final functions = FirebaseFunctions.instance;
  // final storage = FirebaseStorage.instance;
  // final firestore = FirebaseFirestore.instance;

  runApp(DogTravels());
}

class DogTravels extends StatelessWidget {
  DogTravels({Key? key}) : super(key: key);
  PageController pageController = PageController(initialPage: 0);

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
