import 'package:flutter/material.dart';
import 'dart:math' as math;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Stack(
      children: [
        Center(
          child: Container(
              padding: EdgeInsets.all(15.0),
              width: 400,
              height: 400,
              child: CustomPaint(painter: EarthPainter())),
        ),
        Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 40.0, vertical: 100.0),
            child: Transform.rotate(
                angle: -math.pi / 8,
                child: Text('Doggo Travels',
                    style: TextStyle(
                      fontFamily: 'Galada',
                      fontSize: 100,
                      height: .8,
                      letterSpacing: -5,
                      shadows: const [
                        // Shadow(
                        //   color: Colors.purpleAccent,
                        //   offset: Offset(6.0, 9.0),
                        //   blurRadius: 0.0,
                        // ),
                        Shadow(
                          color: Colors.blueAccent,
                          offset: Offset(3.0, 6.0),
                          blurRadius: 0.0,
                        ),
                      ],
                      color: Colors.orange.withOpacity(1.0),
                    )))),
      ],
    )));
  }
}

class EarthPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    Path path = Path();

    // Draw the background of the earth
    final radius = math.min(size.width - 70, size.height - 70) / 2;
    final center = Offset(size.width / 2, size.height / 2);
    final circlePaint = Paint()..color = Colors.blueAccent;
    canvas.drawCircle(center, radius, circlePaint);

    // final landPaint = Paint()
    //   ..color = Colors.lightGreen
    //   ..style = PaintingStyle.fill
    //   ..strokeWidth = 3.0;

    // Path number 1

    paint.color = Colors.lightGreen;
    path = Path();
    path.moveTo(size.width * 0.47, size.height * 0.1);
    path.cubicTo(size.width * 0.32, size.height * 0.14, size.width * 0.29,
        size.height * 0.16, size.width * 0.24, size.height / 5);
    path.cubicTo(size.width * 0.22, size.height * 0.22, size.width / 5,
        size.height * 0.24, size.width * 0.17, size.height * 0.27);
    path.cubicTo(size.width * 0.15, size.height * 0.3, size.width * 0.13,
        size.height * 0.34, size.width * 0.13, size.height * 0.36);
    path.cubicTo(size.width * 0.14, size.height * 0.38, size.width * 0.15,
        size.height * 0.39, size.width * 0.15, size.height * 0.4);
    path.cubicTo(size.width * 0.15, size.height * 0.42, size.width * 0.15,
        size.height * 0.43, size.width * 0.13, size.height * 0.46);
    path.cubicTo(size.width * 0.11, size.height * 0.52, size.width * 0.11,
        size.height * 0.52, size.width * 0.15, size.height * 0.58);
    path.cubicTo(size.width * 0.17, size.height * 0.61, size.width * 0.18,
        size.height * 0.63, size.width * 0.18, size.height * 0.66);
    path.cubicTo(size.width * 0.18, size.height * 0.68, size.width * 0.18,
        size.height * 0.69, size.width * 0.17, size.height * 0.7);
    path.cubicTo(size.width * 0.23, size.height * 0.77, size.width * 0.24,
        size.height * 0.78, size.width * 0.24, size.height * 0.78);
    path.cubicTo(size.width * 0.3, size.height * 0.68, size.width * 0.32,
        size.height * 0.67, size.width * 0.34, size.height * 0.66);
    path.cubicTo(size.width * 0.39, size.height * 0.63, size.width * 0.41,
        size.height * 0.59, size.width * 0.4, size.height * 0.54);
    path.cubicTo(size.width * 0.4, size.height * 0.49, size.width * 0.38,
        size.height * 0.47, size.width * 0.3, size.height * 0.44);
    path.cubicTo(size.width * 0.24, size.height * 0.43, size.width * 0.22,
        size.height * 0.41, size.width / 5, size.height * 0.36);
    path.cubicTo(size.width / 5, size.height * 0.31, size.width / 5,
        size.height * 0.3, size.width * 0.27, size.height * 0.29);
    path.cubicTo(size.width / 3, size.height * 0.28, size.width * 0.35,
        size.height * 0.27, size.width * 0.37, size.height / 4);
    path.cubicTo(size.width * 0.38, size.height * 0.23, size.width * 0.39,
        size.height * 0.22, size.width * 0.39, size.height * 0.19);
    path.cubicTo(size.width * 0.39, size.height * 0.16, size.width * 0.4,
        size.height * 0.15, size.width * 0.41, size.height * 0.15);
    path.cubicTo(size.width * 0.42, size.height * 0.14, size.width * 0.43,
        size.height * 0.15, size.width * 0.44, size.height * 0.16);
    path.cubicTo(size.width * 0.45, size.height * 0.17, size.width * 0.46,
        size.height * 0.18, size.width * 0.46, size.height * 0.18);
    path.cubicTo(size.width * 0.49, size.height * 0.19, size.width * 0.51,
        size.height * 0.16, size.width * 0.51, size.height * 0.12);
    path.cubicTo(size.width * 0.51, size.height * 0.11, size.width * 0.52,
        size.height * 0.11, size.width * 0.52, size.height * 0.11);

    canvas.drawPath(path, paint);

    path = Path();
    path.moveTo(size.width * 0.66, size.height * 0.15);
    // path.cubicTo(size.width * 0.66, size.height * 0.15, size.width * 0.65,
    //     size.height * 0.15, size.width * 0.64, size.height * 0.15);
    path.cubicTo(size.width * 0.56, size.height * 0.18, size.width * 0.49,
        size.height / 4, size.width * 0.51, size.height * 0.32);
    path.cubicTo(size.width * 0.51, size.height * 0.36, size.width * 0.53,
        size.height * 0.39, size.width * 0.57, size.height * 0.42);
    path.cubicTo(size.width * 0.6, size.height * 0.44, size.width * 0.62,
        size.height * 0.46, size.width * 0.63, size.height * 0.47);
    path.cubicTo(size.width * 0.69, size.height * 0.52, size.width * 0.69,
        size.height * 0.53, size.width * 0.67, size.height * 0.6);
    path.cubicTo(size.width * 0.66, size.height * 0.67, size.width * 0.66,
        size.height * 0.69, size.width * 0.66, size.height * 0.71);
    path.cubicTo(size.width * 0.67, size.height * 0.76, size.width * 0.72,
        size.height * 0.74, size.width * 0.79, size.height * 0.68);
    path.cubicTo(size.width * 0.83, size.height * 0.64, size.width * 0.84,
        size.height * 0.61, size.width * 0.87, size.height * 0.52);
    // path.cubicTo(size.width * 0.88, size.height / 2, size.width * 0.88,
    //     size.height * 0.48, size.width * 0.89, size.height * 0.48);
    // path.cubicTo(size.width * 0.89, size.height * 0.47, size.width * 0.89,
    //     size.height * 0.45, size.width * 0.88, size.height * 0.42);
    path.cubicTo(size.width * 0.87, size.height * 0.37, size.width * 0.85,
        size.height * 0.31, size.width * 0.82, size.height * 0.27);
    // path.cubicTo(size.width * 0.8, size.height * 0.24, size.width * 0.78,
    //     size.height * 0.22, size.width * 0.77, size.height / 5);
    path.cubicTo(size.width * 0.73, size.height * 0.18, size.width * 0.7,
        size.height * 0.16, size.width * 0.68, size.height * 0.15);
    // path.cubicTo(size.width * 0.67, size.height * 0.14, size.width * 0.67,
    //     size.height * 0.14, size.width * 0.66, size.height * 0.15);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

  
  
//   void paint(Canvas canvas, Size size) {
//     // Draw the background of the earth
//     final radius = math.min(size.width, size.height) / 2;
//     final center = Offset(size.width / 2, size.height / 2);
//     final circlePaint = Paint()..color = Colors.blueAccent;
//     canvas.drawCircle(center, radius, circlePaint);

//     final landPaint = Paint()
//       ..color = Colors.lightGreen
//       ..style = PaintingStyle.fill
//       ..strokeWidth = 3.0;

//     // Generate first land mass

//     Path path = Path();
//     final point1 = findPoint(radius, center, 270.0, Offset.zero);
//     final point2 = findPoint(radius, center, 256.0, Offset(15, 20));
//     final point3 = findPoint(radius, center, 250.0, Offset(17, 40));
//     final point4 = findPoint(radius, center, 210.0, Offset(20, 30));
//     final point5 = findPoint(radius, center, 1600.0, Offset(60, -5));
//     final point6 = findPoint(radius, center, 90.0, Offset(0, -90));
//     final point7 = findPoint(radius, center, 100.0, Offset(10, -30));
//     final point8 = findPoint(radius, center, 90.0, Offset(0, 0));
//     final point9 = findPoint(radius, center, 180.0, Offset(0, 0));

//     final points = [point1, point2, point3, point4];
//     path.moveTo(
//       point1.dx,
//       point1.dy,
//     );
//     path.quadraticBezierTo(
//       center.dx,
//       center.dy - 130,
//       point2.dx,
//       point2.dy,
//     );
//     path.quadraticBezierTo(
//         center.dx - 50, center.dy - 175, point3.dx, point3.dy);
//     path.quadraticBezierTo(
//         center.dx - 30, center.dy - 60, point4.dx, point4.dy);
//     path.quadraticBezierTo(
//         center.dx - 180, center.dy + 50, point5.dx, point5.dy);
//     path.quadraticBezierTo(
//         center.dx - 20, center.dy + 30, point6.dx, point6.dy);
//     path.quadraticBezierTo(
//         center.dx + 10, center.dy + 120, point7.dx, point7.dy);
//     path.quadraticBezierTo(
//         center.dx - 40, center.dy + 170, point8.dx, point8.dy);
//     path.quadraticBezierTo(
//         center.dx - 165, center.dy + 165, point9.dx, point9.dy);
//     path.quadraticBezierTo(
//         center.dx - 180, center.dy - 180, point1.dx, point1.dy);
//     canvas.drawPath(path, landPaint);

//     // canvas.drawPoints(
//     //     PointMode.points,
//     //     points,
//     //     Paint()
//     //       ..color = Color.fromARGB(255, 170, 114, 99)
//     //       ..strokeWidth = 10);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return false;
//   }
// }

// // Formula to find point on circle,  r=radius, c=center and d=angle
// Offset findPoint(num r, Offset c, num t, Offset o) {
//   // Convert to radians
//   final tRad = t * (math.pi / 180);

//   final x = r * math.cos(tRad) + c.dx + o.dx;
//   final y = r * math.sin(tRad) + c.dy + o.dy;
//   return Offset(x.toDouble(), y.toDouble());
// }
