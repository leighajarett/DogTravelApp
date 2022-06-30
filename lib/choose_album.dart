import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:my_app/homescreen_widgets/xd_cloud.dart';
import 'package:my_app/homescreen_widgets/xd_cloud2.dart';
import 'package:my_app/homescreen_widgets/xd_green_balloon.dart';
import 'package:my_app/homescreen_widgets/xd_green_balloon2.dart';
import 'package:my_app/homescreen_widgets/xd_orange_balloon2.dart';
import 'package:my_app/homescreen_widgets/xd_yellow_balloon.dart';
import 'package:my_app/homescreen_widgets/xd_yellow_balloon2.dart';
import 'package:photo_manager/photo_manager.dart';
import 'dart:math' as math;
import 'package:shared_preferences/shared_preferences.dart';

class Album {
  AssetPathEntity album;
  AssetEntity firstPhoto;

  Album(this.album, this.firstPhoto);
}

class ChooseAlbum extends StatefulWidget {
  // const ChooseAlbum({Key? key}) : super(key: key);
  final ScrollController controller;
  // ignore: use_key_in_widget_constructors
  const ChooseAlbum(this.controller);

  @override
  State<ChooseAlbum> createState() => _ChooseAlbumState();
}

class _ChooseAlbumState extends State<ChooseAlbum> {
  int pageNumber = 0;
  int albumsOnPage = 6;
  String? selectedAlbum;

  @override
  void initState() {
    super.initState();
    () async {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        selectedAlbum = prefs.getString('album');
      });
    }();
  }

  Future<List<Album>> getAlbums() async {
    List<AssetPathEntity> paths = [];
    List<Album> albums = [];
    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    if (ps.isAuth) {
      // Get all albums
      paths = await PhotoManager.getAssetPathList();
      if (paths.isNotEmpty) {
        // For each album get the first photo to use as thumbnail
        for (var path in paths) {
          List<AssetEntity> photos =
              await path.getAssetListRange(start: 0, end: 1);
          albums.add(Album(path, photos[0]));
        }
      }
    } else {
      // Limited(iOS) or Rejected, use `==` for more precise judgements.
      // You can call `PhotoManager.openSetting()` to open settings for further steps.
    }
    return albums;
  }

  void setAlbum(String albumID) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('album', albumID);
    setState(() {
      selectedAlbum = albumID;
    });
    widget.controller.animateTo(MediaQuery.of(context).size.height * 2,
        duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned(
          top: 0,
          left: 200,
          child: Transform.rotate(angle: math.pi / 5, child: const XDCloud())),
      const Positioned(top: 610, left: 5, child: XDCloud2()),
      const Positioned(top: 740, left: 280, child: XDYellowBalloon2()),
      const Positioned(top: 510, left: 300, child: XDOrangeBalloon2()),
      const Positioned(top: 590, left: 50, child: XDGreenBalloon()),
      const Positioned(
        top: 0,
        left: 60,
        child: XDGreenBalloon2(),
      ),
      const Positioned(top: 90, left: 220, child: XDYellowBalloon()),
      FutureBuilder(
          future: getAlbums(),
          builder: (BuildContext context, AsyncSnapshot<List<Album>> snapshot) {
            if (!snapshot.hasData) {
              return Container();
            } else {
              if (snapshot.data != null && snapshot.data!.isNotEmpty) {
                return Center(
                  child: Wrap(
                      direction: Axis.horizontal,
                      spacing: 10,
                      runSpacing: 10,
                      alignment: WrapAlignment.center,
                      children: [
                        ...[
                          SizedBox(
                              width: double.infinity,
                              height: 80,
                              child: Column(
                                children: [
                                  BorderedText(
                                    strokeWidth: 2.0,
                                    strokeColor: Colors.black,
                                    child: const Text(
                                      'Pick your pup',
                                      style: TextStyle(
                                        fontFamily: 'GoodDog New',
                                        fontSize: 50,
                                        color: Color(0xffe99dbf),
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
                                  Text(
                                      style: TextStyle(
                                          fontFamily: "Roboto", fontSize: 12),
                                      'Choose the album with all the pictures of your dog')
                                ],
                              )),
                        ],
                        ...snapshot.data!
                            .sublist(
                                pageNumber * albumsOnPage,
                                math.min(
                                    (pageNumber * albumsOnPage) + albumsOnPage,
                                    snapshot.data!.length))
                            .map((e) => GestureDetector(
                                  onTap: () {
                                    setAlbum(e.album.id);
                                  },
                                  child: e.album.id == selectedAlbum
                                      ? Container(
                                          decoration: BoxDecoration(
                                              color: const Color(0xffb7c245),
                                              border: Border.all(
                                                  color: Colors.black)),
                                          width: 150,
                                          height: 170,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(7.0),
                                                child: Text(e.album.name),
                                              ),
                                              Container(
                                                  width: 110,
                                                  height: 110,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.black)),
                                                  child: AssetEntityImage(
                                                    e.firstPhoto,
                                                    fit: BoxFit.cover,
                                                  )),
                                            ],
                                          ),
                                        )
                                      : SizedBox(
                                          width: 150,
                                          height: 170,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(7.0),
                                                child: Text(e.album.name),
                                              ),
                                              Container(
                                                width: 110,
                                                height: 110,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.black)),
                                                child: AssetEntityImage(
                                                    e.firstPhoto,
                                                    fit: BoxFit.cover),
                                              ),
                                            ],
                                          ),
                                        ),
                                ))
                            .toList(),
                        Container(
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                pageNumber > 0
                                    // pageNumber < 1
                                    ? IconButton(
                                        onPressed: () {
                                          setState(() {
                                            pageNumber = pageNumber - 1;
                                          });
                                        },
                                        icon: const Icon(Icons.arrow_back_ios))
                                    : const SizedBox(
                                        height: 0,
                                        width: 0,
                                      ),
                                pageNumber + 1 <
                                        (snapshot.data!.length / albumsOnPage)
                                            .ceil()
                                    // pageNumber < 1
                                    ? IconButton(
                                        onPressed: () {
                                          setState(() {
                                            pageNumber = pageNumber + 1;
                                          });
                                        },
                                        icon: const Icon(
                                            Icons.arrow_forward_ios_outlined))
                                    : const SizedBox(
                                        height: 0,
                                        width: 0,
                                      ),
                              ],
                            ))
                      ]),
                );
              } else {
                return const Text(
                    "Looks like you don't have any albums, go ahead and make one!");
              }
            }
          }),
    ]);
  }
}





                // return Center(
                //   child: Container(
                //     height: 300,
                //     child: GridView.builder(
                //         // shrinkWrap: true,
                //         // physics: NeverScrollableScrollPhysics(),
                //         scrollDirection: Axis.horizontal,
                //         padding: EdgeInsets.all(10),
                //         gridDelegate:
                //             const SliverGridDelegateWithFixedCrossAxisCount(
                //           crossAxisCount: 2,
                //           crossAxisSpacing: 10,
                //         ),
                //         itemCount: snapshot.data?.length,
                //         itemBuilder: (context, index) {
                //           String albumName = snapshot.data![index].name;
                //           return Container(
                //               height: 30,
                //               color: Colors.purple,
                //               child: Center(child: Text(albumName)));
                //         }),
                //   ),
                // );