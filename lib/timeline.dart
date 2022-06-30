// ignore_for_file: constant_identifier_names

import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_app/homescreen_widgets/xd_cloud.dart';
import 'package:my_app/homescreen_widgets/xd_cloud2.dart';
import 'package:my_app/homescreen_widgets/xd_yellow_balloon2.dart';
import 'package:photo_manager/photo_manager.dart';
import 'dart:math' as math;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';

enum Status { loading, error, complete }

class Event {
  Offset anchor;
  AssetEntity photo;
  Event(this.anchor, this.photo);

  Future<Placemark>? getPlacemark() async {
    if (photo.latitude != null && photo.longitude != null) {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(photo.latitude!, photo.longitude!);
      return placemarks[0];
    }
    return Placemark();
  }
}

class Timeline extends StatefulWidget {
  const Timeline({Key? key}) : super(key: key);

  @override
  State<Timeline> createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  Status status = Status.loading;
  int currentEvent = 0;
  Widget? selectedEvent;
  List<Event> events = [];
  Size size = const Size(330, 480);
  List<Offset> points = [
    const Offset(165, 180),
    const Offset(165, 295),
    const Offset(255, 295),
    const Offset(255, 180),
    const Offset(255, 50),
    const Offset(350, 50),
    const Offset(350, 180),
    const Offset(350, 295),
    const Offset(440, 295),
    const Offset(440, 180),
    const Offset(535, 145),
    const Offset(535, 260),
    const Offset(625, 260),
    const Offset(625, 145),
  ];

  @override
  void initState() {
    super.initState();
    () async {
      final prefs = await SharedPreferences.getInstance();
      // get the album
      String? selectedAlbum = prefs.getString('album');

      // get all photos from the album
      if (selectedAlbum != null) {
        List<Event> es = [];
        try {
          AssetPathEntity album = await AssetPathEntity.fromId(selectedAlbum);
          final List<AssetEntity> photos =
              await album.getAssetListPaged(page: 0, size: points.length);
          // Sort photos in order of the time they were taken
          photos.sort((a, b) => a.createDateTime.compareTo(b.createDateTime));
          var step = (points.length / photos.length).round();
          for (var i = 0; i < photos.length; i++) {
            var photo = photos[i];
            // calculate the anchor point for this event
            var anchor = points[step * i];
            es.add(Event(anchor, photo));
          }
          setState(() {
            status = Status.complete;
            events = es;
          });
        } catch (e) {
          print('Problem loading the album');
          setState(() {
            status = Status.error;
          });
        }
      } else {
        setState(() {
          status = Status.error;
        });
      }
    }();
  }

  _displayDialog(BuildContext context) async {
    Placemark? placemark = await events[currentEvent].getPlacemark();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');

    selectedEvent = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              insetPadding: const EdgeInsets.only(
                  top: 30, bottom: 200, left: 50, right: 50),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.location_pin,
                            color: Color(0xffe99dbf),
                            size: 24.0,
                          ),
                          Text(
                              style: const TextStyle(fontSize: 12),
                              placemark!.subAdministrativeArea != null &&
                                      placemark.administrativeArea != null
                                  ? "${placemark.subAdministrativeArea!}, ${placemark.administrativeArea}"
                                  : ''),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.black)),
                    child: AssetEntityImage(events[currentEvent].photo,
                        fit: BoxFit.cover),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                            style: const TextStyle(fontSize: 12),
                            formatter.format(
                                events[currentEvent].photo.createDateTime))),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 5.0),
                    child: TextField(
                      cursorColor: Color(0xffb7c245),
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffb7c245)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffb7c245)),
                          ),
                          hintText: 'Add a description...',
                          hintStyle: TextStyle(color: Colors.black)),
                      style: TextStyle(fontSize: 12),
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                    ),
                  ),
                ]),
              ));
        });

    setState(() {
      selectedEvent = selectedEvent;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned(
          top: 0,
          left: 200,
          child: Transform.rotate(angle: math.pi / 5, child: const XDCloud())),
      const Positioned(top: 610, left: 5, child: XDCloud2()),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 100.0, horizontal: 30),
        child: Column(
          children: [
            BorderedText(
              strokeWidth: 2.0,
              strokeColor: Colors.black,
              child: const Text(
                'Life of Your Doggo',
                style: TextStyle(
                  fontFamily: 'GoodDog New',
                  fontSize: 40,
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
            const Text("Click on a balloon to see your pup's life event"),
            Expanded(
              child: Stack(children: [
                SvgPicture.string(
                  _svg_bas30j,
                  allowDrawingOutsideViewBox: true,
                  fit: BoxFit.scaleDown,
                ),
              ]),
            ),
            // ...events
          ],
        ),
      ),
      events.isNotEmpty
          ? AnimatedPositioned(
              top: events[currentEvent].anchor.dx,
              left: events[currentEvent].anchor.dy,
              duration: const Duration(milliseconds: 500),
              child: GestureDetector(
                onTap: () {
                  _displayDialog(context);
                },
                onDoubleTap: () {
                  setState(() {
                    if (currentEvent < (events.length - 1)) {
                      currentEvent = currentEvent + 1;
                    } else {
                      currentEvent = 0;
                    }
                  });
                },
                child: const XDYellowBalloon2(),
              ),
            )
          : const SizedBox(
              width: 0,
              height: 0,
            ),
    ]);
  }
}

const String _svg_bas30j =
    '<svg version="1.1" id="Layer_2_00000065044862349437905970000010966398252406518933_" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 510.97 743.53" style="enable-background:new 0 0 510.97 743.53;" xml:space="preserve"> <g id="Layer_1-2"> <path style="fill:#6D6E71;stroke:#231F20;stroke-width:2;stroke-miterlimit:10;" d="M446.13,284.01v-0.02h-382v-0.13 c-20.08-1.83-35.96-25.22-35.96-53.84s15.89-52.01,35.96-53.84v-0.13h382.98c35.02-0.21,63.36-39.42,63.36-87.78 s-28.1-87.22-62.91-87.76H218.18C208.64,0.5,200.9,8.07,200.9,17.4s7.73,16.91,17.28,16.91h228.66v0.13 c20.08,1.83,35.96,25.22,35.96,53.84s-15.89,52.01-35.96,53.84v0.13H64.13C28.99,142.24,0.5,181.54,0.5,230.02 s27.96,87.04,62.65,87.76v0.02h381.8v0.13c20.08,1.83,35.96,25.22,35.96,53.84s-15.89,52.01-35.96,53.84v0.13H193.62 c-35.14,0-63.63,39.3-63.63,87.78s28.49,87.78,63.63,87.78h179.57v0.13c20.08,1.83,35.96,25.22,35.96,53.84 s-15.89,52.01-35.96,53.84v0.13H190.43c-9.54,0-17.28,7.57-17.28,16.91s7.73,16.91,17.28,16.91h182.75 c35.14,0,63.63-39.3,63.63-87.78s-26.78-85.38-60.45-87.67v-0.11H193.62v-0.13c-20.08-1.83-35.96-25.22-35.96-53.84 s15.89-52.01,35.96-53.84v-0.13h253.11v-0.04c34.32-1.3,61.84-40.09,61.84-87.74s-27.85-86.88-62.44-87.76L446.13,284.01z"/> <line style="fill:none;stroke:#FFFFFF;stroke-width:2;stroke-miterlimit:10;" x1="222.7" y1="17.41" x2="236.22" y2="17.41"/> <line style="fill:none;stroke:#FFFFFF;stroke-width:2;stroke-miterlimit:10;" x1="252.92" y1="17.41" x2="266.44" y2="17.41"/> <line style="fill:none;stroke:#FFFFFF;stroke-width:2;stroke-miterlimit:10;" x1="284.6" y1="17.41" x2="298.12" y2="17.41"/> <line style="fill:none;stroke:#FFFFFF;stroke-width:2;stroke-miterlimit:10;" x1="314.82" y1="17.41" x2="328.34" y2="17.41"/> <line style="fill:none;stroke:#FFFFFF;stroke-width:2;stroke-miterlimit:10;" x1="344.31" y1="17.41" x2="357.83" y2="17.41"/> <line style="fill:none;stroke:#FFFFFF;stroke-width:2;stroke-miterlimit:10;" x1="374.53" y1="17.41" x2="388.04" y2="17.41"/> <line style="fill:none;stroke:#FFFFFF;stroke-width:2;stroke-miterlimit:10;" x1="93.95" y1="160.03" x2="107.47" y2="160.03"/> <line style="fill:none;stroke:#FFFFFF;stroke-width:2;stroke-miterlimit:10;" x1="124.17" y1="160.03" x2="137.69" y2="160.03"/> <line style="fill:none;stroke:#FFFFFF;stroke-width:2;stroke-miterlimit:10;" x1="155.85" y1="160.03" x2="169.37" y2="160.03"/> <line style="fill:none;stroke:#FFFFFF;stroke-width:2;stroke-miterlimit:10;" x1="186.07" y1="160.03" x2="199.59" y2="160.03"/> <line style="fill:none;stroke:#FFFFFF;stroke-width:2;stroke-miterlimit:10;" x1="215.56" y1="160.03" x2="229.08" y2="160.03"/> <line style="fill:none;stroke:#FFFFFF;stroke-width:2;stroke-miterlimit:10;" x1="245.77" y1="160.03" x2="259.29" y2="160.03"/> <line style="fill:none;stroke:#FFFFFF;stroke-width:2;stroke-miterlimit:10;" x1="278.55" y1="160.03" x2="292.07" y2="160.03"/> <line style="fill:none;stroke:#FFFFFF;stroke-width:2;stroke-miterlimit:10;" x1="308.77" y1="160.03" x2="322.29" y2="160.03"/> <line style="fill:none;stroke:#FFFFFF;stroke-width:2;stroke-miterlimit:10;" x1="340.46" y1="160.03" x2="353.98" y2="160.03"/> <line style="fill:none;stroke:#FFFFFF;stroke-width:2;stroke-miterlimit:10;" x1="370.67" y1="160.03" x2="384.19" y2="160.03"/> <line style="fill:none;stroke:#FFFFFF;stroke-width:2;stroke-miterlimit:10;" x1="400.16" y1="160.03" x2="413.68" y2="160.03"/> <line style="fill:none;stroke:#FFFFFF;stroke-width:2;stroke-miterlimit:10;" x1="430.38" y1="160.03" x2="443.9" y2="160.03"/> <line style="fill:none;stroke:#FFFFFF;stroke-width:2;stroke-miterlimit:10;" x1="71.51" y1="300.95" x2="85.03" y2="300.95"/> <line style="fill:none;stroke:#FFFFFF;stroke-width:2;stroke-miterlimit:10;" x1="101.73" y1="300.95" x2="115.25" y2="300.95"/> <line style="fill:none;stroke:#FFFFFF;stroke-width:2;stroke-miterlimit:10;" x1="133.41" y1="300.95" x2="146.93" y2="300.95"/> <line style="fill:none;stroke:#FFFFFF;stroke-width:2;stroke-miterlimit:10;" x1="163.63" y1="300.95" x2="177.15" y2="300.95"/> <line style="fill:none;stroke:#FFFFFF;stroke-width:2;stroke-miterlimit:10;" x1="193.12" y1="300.95" x2="206.64" y2="300.95"/> <line style="fill:none;stroke:#FFFFFF;stroke-width:2;stroke-miterlimit:10;" x1="223.33" y1="300.95" x2="236.85" y2="300.95"/> <line style="fill:none;stroke:#FFFFFF;stroke-width:2;stroke-miterlimit:10;" x1="256.11" y1="300.95" x2="269.63" y2="300.95"/> <line style="fill:none;stroke:#FFFFFF;stroke-width:2;stroke-miterlimit:10;" x1="286.33" y1="300.95" x2="299.85" y2="300.95"/> <line style="fill:none;stroke:#FFFFFF;stroke-width:2;stroke-miterlimit:10;" x1="318.02" y1="300.95" x2="331.54" y2="300.95"/> <line style="fill:none;stroke:#FFFFFF;stroke-width:2;stroke-miterlimit:10;" x1="348.23" y1="300.95" x2="361.75" y2="300.95"/> <line style="fill:none;stroke:#FFFFFF;stroke-width:2;stroke-miterlimit:10;" x1="377.72" y1="300.95" x2="391.24" y2="300.95"/> <line style="fill:none;stroke:#FFFFFF;stroke-width:2;stroke-miterlimit:10;" x1="407.94" y1="300.95" x2="421.46" y2="300.95"/> <line style="fill:none;stroke:#FFFFFF;stroke-width:2;stroke-miterlimit:10;" x1="265.11" y1="442.93" x2="278.63" y2="442.93"/> <line style="fill:none;stroke:#FFFFFF;stroke-width:2;stroke-miterlimit:10;" x1="295.33" y1="442.93" x2="308.85" y2="442.93"/> <line style="fill:none;stroke:#FFFFFF;stroke-width:2;stroke-miterlimit:10;" x1="327.02" y1="442.93" x2="340.54" y2="442.93"/> <line style="fill:none;stroke:#FFFFFF;stroke-width:2;stroke-miterlimit:10;" x1="357.23" y1="442.93" x2="370.75" y2="442.93"/> <line style="fill:none;stroke:#FFFFFF;stroke-width:2;stroke-miterlimit:10;" x1="389.72" y1="442.93" x2="403.24" y2="442.93"/> <line style="fill:none;stroke:#FFFFFF;stroke-width:2;stroke-miterlimit:10;" x1="425.94" y1="442.93" x2="439.46" y2="442.93"/> <line style="fill:none;stroke:#FFFFFF;stroke-width:2;stroke-miterlimit:10;" x1="201.27" y1="584.92" x2="214.79" y2="584.92"/> <line style="fill:none;stroke:#FFFFFF;stroke-width:2;stroke-miterlimit:10;" x1="233.49" y1="584.92" x2="247.01" y2="584.92"/> <line style="fill:none;stroke:#FFFFFF;stroke-width:2;stroke-miterlimit:10;" x1="269.17" y1="584.92" x2="282.69" y2="584.92"/> <line style="fill:none;stroke:#FFFFFF;stroke-width:2;stroke-miterlimit:10;" x1="299.39" y1="584.92" x2="312.91" y2="584.92"/> <line style="fill:none;stroke:#FFFFFF;stroke-width:2;stroke-miterlimit:10;" x1="328.88" y1="584.92" x2="342.4" y2="584.92"/> <line style="fill:none;stroke:#FFFFFF;stroke-width:2;stroke-miterlimit:10;" x1="359.09" y1="584.92" x2="372.61" y2="584.92"/> <line style="fill:none;stroke:#FFFFFF;stroke-width:2;stroke-miterlimit:10;" x1="202.96" y1="726.9" x2="216.48" y2="726.9"/> <line style="fill:none;stroke:#FFFFFF;stroke-width:2;stroke-miterlimit:10;" x1="233.18" y1="726.9" x2="246.7" y2="726.9"/> <line style="fill:none;stroke:#FFFFFF;stroke-width:2;stroke-miterlimit:10;" x1="264.86" y1="726.9" x2="278.38" y2="726.9"/> <line style="fill:none;stroke:#FFFFFF;stroke-width:2;stroke-miterlimit:10;" x1="295.08" y1="726.9" x2="308.6" y2="726.9"/> <line style="fill:none;stroke:#FFFFFF;stroke-width:2;stroke-miterlimit:10;" x1="324.57" y1="726.9" x2="338.09" y2="726.9"/> <line style="fill:none;stroke:#FFFFFF;stroke-width:2;stroke-miterlimit:10;" x1="354.79" y1="726.9" x2="368.31" y2="726.9"/> <line style="fill:none;stroke:#FFFFFF;stroke-width:2;stroke-miterlimit:10;" x1="406.86" y1="17.41" x2="420.38" y2="17.41"/> <line style="fill:none;stroke:#FFFFFF;stroke-width:2;stroke-miterlimit:10;" x1="439.97" y1="17.41" x2="453.49" y2="17.41"/> <line style="fill:none;stroke:#FFFFFF;stroke-width:2;stroke-miterlimit:10;" x1="497.22" y1="81.39" x2="497.22" y2="94.91"/> <line style="fill:none;stroke:#FFFFFF;stroke-width:2;stroke-miterlimit:10;" x1="469.44" y1="23.09" x2="477.98" y2="33.57"/> <line style="fill:none;stroke:#FFFFFF;stroke-width:2;stroke-miterlimit:10;" x1="489.57" y1="48.42" x2="494.08" y2="61.17"/> <line style="fill:none;stroke:#FFFFFF;stroke-width:2;stroke-miterlimit:10;" x1="494.18" y1="114.05" x2="489.47" y2="126.72"/> <line style="fill:none;stroke:#FFFFFF;stroke-width:2;stroke-miterlimit:10;" x1="463.35" y1="156.42" x2="474.43" y2="148.67"/> <line style="fill:none;stroke:#FFFFFF;stroke-width:2;stroke-miterlimit:10;" x1="493.65" y1="364.01" x2="493.65" y2="377.53"/> <line style="fill:none;stroke:#FFFFFF;stroke-width:2;stroke-miterlimit:10;" x1="465.86" y1="305.7" x2="474.4" y2="316.18"/> <line style="fill:none;stroke:#FFFFFF;stroke-width:2;stroke-miterlimit:10;" x1="485.99" y1="331.03" x2="490.5" y2="343.78"/> <line style="fill:none;stroke:#FFFFFF;stroke-width:2;stroke-miterlimit:10;" x1="490.6" y1="396.66" x2="485.89" y2="409.34"/> <line style="fill:none;stroke:#FFFFFF;stroke-width:2;stroke-miterlimit:10;" x1="459.77" y1="439.03" x2="470.85" y2="431.29"/> <line style="fill:none;stroke:#FFFFFF;stroke-width:2;stroke-miterlimit:10;" x1="423.86" y1="647.9" x2="423.86" y2="661.42"/> <line style="fill:none;stroke:#FFFFFF;stroke-width:2;stroke-miterlimit:10;" x1="396.07" y1="589.6" x2="404.61" y2="600.07"/> <line style="fill:none;stroke:#FFFFFF;stroke-width:2;stroke-miterlimit:10;" x1="416.2" y1="614.93" x2="420.71" y2="627.67"/> <line style="fill:none;stroke:#FFFFFF;stroke-width:2;stroke-miterlimit:10;" x1="420.81" y1="680.56" x2="416.1" y2="693.23"/> <line style="fill:none;stroke:#FFFFFF;stroke-width:2;stroke-miterlimit:10;" x1="389.98" y1="722.93" x2="401.06" y2="715.18"/> <line style="fill:none;stroke:#FFFFFF;stroke-width:2;stroke-miterlimit:10;" x1="195.45" y1="442.93" x2="208.97" y2="442.93"/> <line style="fill:none;stroke:#FFFFFF;stroke-width:2;stroke-miterlimit:10;" x1="227.67" y1="442.93" x2="241.19" y2="442.93"/> <line style="fill:none;stroke:#FFFFFF;stroke-width:2;stroke-miterlimit:10;" x1="14.9" y1="225.16" x2="14.9" y2="238.68"/> <line style="fill:none;stroke:#FFFFFF;stroke-width:2;stroke-miterlimit:10;" x1="42.69" y1="166.86" x2="34.15" y2="177.33"/> <line style="fill:none;stroke:#FFFFFF;stroke-width:2;stroke-miterlimit:10;" x1="22.56" y1="192.19" x2="18.05" y2="204.94"/> <line style="fill:none;stroke:#FFFFFF;stroke-width:2;stroke-miterlimit:10;" x1="17.95" y1="257.82" x2="22.66" y2="270.49"/> <line style="fill:none;stroke:#FFFFFF;stroke-width:2;stroke-miterlimit:10;" x1="48.78" y1="300.19" x2="37.7" y2="292.44"/> <line style="fill:none;stroke:#FFFFFF;stroke-width:2;stroke-miterlimit:10;" x1="436.29" y1="301.62" x2="449.81" y2="301.62"/> <line style="fill:none;stroke:#FFFFFF;stroke-width:2;stroke-miterlimit:10;" x1="59.6" y1="161.34" x2="73.12" y2="161.34"/> <line style="fill:none;stroke:#FFFFFF;stroke-width:2;stroke-miterlimit:10;" x1="143.56" y1="507.49" x2="143.56" y2="521.01"/> <line style="fill:none;stroke:#FFFFFF;stroke-width:2;stroke-miterlimit:10;" x1="171.35" y1="449.19" x2="162.8" y2="459.67"/> <line style="fill:none;stroke:#FFFFFF;stroke-width:2;stroke-miterlimit:10;" x1="151.21" y1="474.52" x2="146.7" y2="487.27"/> <line style="fill:none;stroke:#FFFFFF;stroke-width:2;stroke-miterlimit:10;" x1="146.6" y1="540.15" x2="151.32" y2="552.82"/> <line style="fill:none;stroke:#FFFFFF;stroke-width:2;stroke-miterlimit:10;" x1="177.43" y1="582.52" x2="166.35" y2="574.77"/> </g> </svg>';
