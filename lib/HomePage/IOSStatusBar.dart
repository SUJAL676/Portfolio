import 'dart:async';
import 'package:flutter/material.dart';

class IOSStatusBar extends StatefulWidget {
  const IOSStatusBar({super.key});

  @override
  State<IOSStatusBar> createState() => _IOSStatusBarState();
}

class _IOSStatusBarState extends State<IOSStatusBar> {
  late Timer _timeTimer;
  late Timer _batteryTimer;

  String time = "";
  double batteryLevel = 40;
  bool charging = true;

  @override
  void initState() {
    super.initState();
    _updateTime();

    /// ⏰ TIME UPDATE TIMER
    _timeTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      _updateTime();
    });

    /// 🔋 BATTERY ANIMATION TIMER
    _batteryTimer = Timer.periodic(const Duration(milliseconds: 150), (_) {
      if (!mounted) return;

      setState(() {
        if (charging) {
          batteryLevel += 2;
          if (batteryLevel >= 100) charging = false;
        } else {
          batteryLevel -= 2;
          if (batteryLevel <= 20) charging = true;
        }
      });
    });
  }

  void _updateTime() {
    final now = DateTime.now();
    setState(() {
      time = "${_two(now.hour)}:${_two(now.minute)}";
    });
  }

  String _two(int n) => n.toString().padLeft(2, "0");

  @override
  void dispose() {
    _timeTimer.cancel();
    _batteryTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44, // iOS status bar height
      child: Stack(
        alignment: Alignment.center,
        children: [
          /// 🔲 BASE ROW
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                /// ⏰ TIME
                Text(
                  time,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),

                const Spacer(),

                /// 📡 RIGHT ICONS
                Row(
                  children: [
                    Icon(
                      Icons.signal_cellular_alt,
                      size: 18,
                      color: Colors.white.withOpacity(0.9),
                    ),
                    const SizedBox(width: 10),
                    Icon(
                      Icons.wifi,
                      size: 18,
                      color: Colors.white.withOpacity(0.9),
                    ),
                    const SizedBox(width: 10),
                    _Battery(batteryLevel: batteryLevel),
                  ],
                ),
              ],
            ),
          ),

          /// 🕳️ IPHONE 15 DYNAMIC ISLAND
          const _IPhone15Notch(),
        ],
      ),
    );
  }
}

/// 🔋 BATTERY WIDGET
class _Battery extends StatelessWidget {
  final double batteryLevel;
  const _Battery({required this.batteryLevel});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          alignment: Alignment.centerLeft,
          children: [
            Container(
              height: 16,
              width: 28,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 1.3),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: 12,
              width: (batteryLevel / 100) * 26,
              margin: const EdgeInsets.only(left: 1.5),
              decoration: BoxDecoration(
                color: batteryLevel < 20
                    ? Colors.redAccent
                    : Colors.greenAccent,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ],
        ),
        const SizedBox(width: 2),
        Container(
          height: 7,
          width: 3,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }
}

/// 🕳️ IPHONE 15 NOTCH / DYNAMIC ISLAND
class _IPhone15Notch extends StatelessWidget {
  const _IPhone15Notch();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      width: 110,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}

// import 'dart:async';
// import 'package:flutter/material.dart';

// class IOSStatusBar extends StatefulWidget {
//   const IOSStatusBar({super.key});

//   @override
//   State<IOSStatusBar> createState() => _IOSStatusBarState();
// }

// class _IOSStatusBarState extends State<IOSStatusBar> {
//   late Timer timer;
//   String time = "";
//   double batteryLevel = 40;
//   bool charging = true;

//   @override
//   void initState() {
//     super.initState();
//     _updateTime();

//     timer = Timer.periodic(const Duration(seconds: 1), (_) => _updateTime());

//     Timer.periodic(const Duration(milliseconds: 150), (_) {
//       setState(() {
//         if (charging) {
//           batteryLevel += 2;
//           if (batteryLevel >= 100) charging = false;
//         } else {
//           batteryLevel -= 2;
//           if (batteryLevel <= 20) charging = true;
//         }
//       });
//     });
//   }

//   void _updateTime() {
//     final now = DateTime.now();
//     setState(() {
//       time = "${_two(now.hour)}:${_two(now.minute)}";
//     });
//   }

//   String _two(int n) => n.toString().padLeft(2, "0");

//   @override
//   void dispose() {
//     timer.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 44, // iOS status bar height
//       child: Stack(
//         alignment: Alignment.center,
//         children: [
//           /// 🔲 BASE ROW
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: Row(
//               children: [
//                 /// ⏰ TIME
//                 Text(
//                   time,
//                   style: const TextStyle(
//                     fontSize: 15,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.white,
//                   ),
//                 ),

//                 const Spacer(),

//                 /// 📡 RIGHT ICONS
//                 Row(
//                   children: [
//                     Icon(
//                       Icons.signal_cellular_alt,
//                       size: 18,
//                       color: Colors.white.withOpacity(0.9),
//                     ),
//                     const SizedBox(width: 10),
//                     Icon(
//                       Icons.wifi,
//                       size: 18,
//                       color: Colors.white.withOpacity(0.9),
//                     ),
//                     const SizedBox(width: 10),
//                     _Battery(batteryLevel: batteryLevel),
//                   ],
//                 ),
//               ],
//             ),
//           ),

//           /// 🕳️ IPHONE 15 DYNAMIC ISLAND
//           const _IPhone15Notch(),
//         ],
//       ),
//     );
//   }
// }

// /// 🔋 BATTERY WIDGET
// class _Battery extends StatelessWidget {
//   final double batteryLevel;
//   const _Battery({required this.batteryLevel});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Stack(
//           alignment: Alignment.centerLeft,
//           children: [
//             Container(
//               height: 16,
//               width: 28,
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.white, width: 1.3),
//                 borderRadius: BorderRadius.circular(4),
//               ),
//             ),
//             AnimatedContainer(
//               duration: const Duration(milliseconds: 300),
//               height: 12,
//               width: (batteryLevel / 100) * 26,
//               margin: const EdgeInsets.only(left: 1.5),
//               decoration: BoxDecoration(
//                 color: batteryLevel < 20
//                     ? Colors.redAccent
//                     : Colors.greenAccent,
//                 borderRadius: BorderRadius.circular(3),
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(width: 2),
//         Container(
//           height: 7,
//           width: 3,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(2),
//           ),
//         ),
//       ],
//     );
//   }
// }

// /// 🕳️ IPHONE 15 NOTCH / DYNAMIC ISLAND
// class _IPhone15Notch extends StatelessWidget {
//   const _IPhone15Notch();

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 32,
//       width: 110,
//       decoration: BoxDecoration(
//         color: Colors.black,
//         borderRadius: BorderRadius.circular(20),
//       ),
//     );
//   }
// }
