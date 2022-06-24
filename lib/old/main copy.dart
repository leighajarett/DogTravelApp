import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:my_app/old/homepage.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:heic_to_jpg/heic_to_jpg.dart';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'homepage.dart';

//  TO DO: add a data model for the information being retreieved from Firebase?

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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My Dog's World Travels",
      theme: ThemeData(primarySwatch: Colors.green),
      home: HomePage(),
    );
  }
}

// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Puppy Travels!")),
//       body: PupSelector(),
//     );
//   }
// }

// class PupSelector extends StatefulWidget {
//   @override
//   State<PupSelector> createState() => _PupSelectorState();
// }

// class _PupSelectorState extends State<PupSelector> {
//   List<Widget> _mediaList = [];
//   final storageRef = FirebaseStorage.instance.ref();
//   var progress = 0.0;
//   String? deviceId;

//   @override
//   void initState() {
//     super.initState();
//     // _fetchNewMedia();
//   }

//   // Set the device ID in the state
//   _getDeviceInfo() async {
//     print("Getting device info");
//     String? tempId = await _getId();
//     setState(() {
//       deviceId = tempId;
//     });
//   }

//   // Find new photos
//   // _fetchNewMedia() async {
//   //   await _getDeviceInfo();
//   //   print("Fetching media");
//   //   //check permissions on photo album
//   //   final PermissionState _ps = await PhotoManager.requestPermissionExtend();
//   //   // if permissions look good, then take photos and send them to cloud function
//   //   if (_ps.isAuth) {
//   //     //load the album list
//   //     List<AssetPathEntity> albums =
//   //         await PhotoManager.getAssetPathList(onlyAll: true);
//   //     List<AssetEntity> media = await albums[0]
//   //         .getAssetListPaged(page: 0, size: 60); //preloading files
//   //     for (var asset in media) {
//   //       // Set the state for the progress bar
//   //       setState(() {
//   //         progress = progress + (1.0 / media.length);
//   //       });
//   //       if (asset.type == AssetType.image) {
//   //         // Convert the HEIC files to JPG
//   //         var filePath = await FlutterAbsolutePath.getAbsolutePath(asset.id);
//   //         var jpgPath = await HeicToJpg.convert(filePath);
//   //         // if (jpgPath != null) {
//   //         //   var imageId = asset.id.replaceAll('/', '-');
//   //         //   var storagePath = "images/${imageId}";
//   //         //   var spaceRef = storageRef.child(storagePath);
//   //         //   File file = File(jpgPath);
//   //           // Send the photos to cloud storage
//   //           // try {
//   //           //   await spaceRef.putFile(file);
//   //           // } on FirebaseException catch (error) {
//   //           //   print('There is an error when pushing to cloud storage');
//   //           //   print(error.toString());
//   //           //   print(spaceRef);
//   //           // }
//   //           // TO DO: make it so it only adds if the image doesn't exist in firestore yet
//   //           // try {
//   //           //   await FirebaseFirestore.instance
//   //           //       .collection("devices")
//   //           //       // TO DO: handle deviceID being null
//   //           //       .doc(deviceId)
//   //           //       .collection("images")
//   //           //       .doc(imageId)
//   //           //       .set({
//   //           //     "thumbnail_path": filePath,
//   //           //     "storage_path": storagePath,
//   //           //     "jpg_path": jpgPath,
//   //           //     "labels": ''
//   //           //   });
//   //           // } on FirebaseException catch (error) {
//   //           //   print('There is an error when pushing to firestore');
//   //           //   print(error.toString());
//   //           // }
//   //           // Trigger cloud function call to get labels on photos
//   //           // try {
//   //           //   await FirebaseFunctions.instance
//   //           //       .httpsCallable('getLabels')
//   //           //       .call({'deviceId': deviceId});
//   //           // } on FirebaseFunctionsException catch (error) {
//   //           //   print('There is an error when calling the cloud function');
//   //           //   print(error.toString());
//   //           // }
//   //         // }
//   //       }
//   //     }
//   //   } else {
//   //     // open android/ios applicaton's setting to get permission
//   //     PhotoManager.openSetting();
//   //   }
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//         padding: EdgeInsets.symmetric(horizontal: 50.0),
//         child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//           const Text("Hold tight! We're finding your puppies"),
//           const SizedBox(height: 20),
//           LinearProgressIndicator(
//               value: progress, semanticsLabel: 'Linear progress indicator'),
//         ]));
//   }
// }


// // Method to get Device ID
// Future<String?> _getId() async {
//   var deviceInfo = DeviceInfoPlugin();
//   if (Platform.isIOS) {
//     // import 'dart:io'
//     var iosDeviceInfo = await deviceInfo.iosInfo;
//     return iosDeviceInfo.identifierForVendor; // unique ID on iOS
//   } else if (Platform.isAndroid) {
//     var androidDeviceInfo = await deviceInfo.androidInfo;
//     return androidDeviceInfo.androidId; // unique ID on Android
//   }
// }



// return GridView.builder(
    //     itemCount: _mediaList.length,
    //     gridDelegate:
    //         SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
    //     itemBuilder: (BuildContext context, int index) {
    //       return _mediaList[index];
    //     });

// try {
          //   final label = await FirebaseFunctions.instance
          //       .httpsCallable('getLabels')
          //       .call();
          //   print(label);
          // } on FirebaseFunctionsException catch (error) {
          //   print('This is an error');
          //   print(error.code);
          //   print(error.details);
          //   print(error.message);
          // }
          // temp.add(
          //   FutureBuilder(
          //       future: asset.thumbnailDataWithSize(
          //           const ThumbnailSize(200, 200)), //resolution of thumbnail
          //       builder:
          //           (BuildContext context, AsyncSnapshot<Uint8List?> snapshot) {
          //         if (snapshot.connectionState == ConnectionState.done) {
          //           return Stack(children: <Widget>[
          //             Positioned.fill(
          //               child: Image.memory(
          //                 snapshot.data!,
          //                 fit: BoxFit.cover,
          //               ),
          //             ),
          //           ]);
          //         }
          //         return CircularProgressIndicator();
          //       }),
          // );