import 'dart:async';

import 'package:flutter/material.dart';
import 'package:portfolio/LoackScreen/FaceUnlock.dart';

class LockScreen extends StatefulWidget {
  final VoidCallback onUnlock;
  const LockScreen({Key? key, required this.onUnlock}) : super(key: key);

  @override
  State<LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  String _time = '';
  String _date = '';
  Timer? _timeTimer;

  @override
  void initState() {
    super.initState();
    _updateTime();
    _timeTimer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => _updateTime(),
    );
  }

  void _updateTime() {
    final now = DateTime.now();
    setState(() {
      _time = '${_two(now.hour)}:${_two(now.minute)}';
      _date = '${_weekday(now.weekday)}, ${now.day} ${_month(now.month)}';
    });
  }

  String _two(int n) => n.toString().padLeft(2, '0');
  String _weekday(int w) =>
      ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][w - 1];
  String _month(int m) => [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ][m - 1];

  @override
  void dispose() {
    _timeTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Wallpaper
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background/IPhoneBack3.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
        ),

        Container(color: Colors.black.withOpacity(0.35)),

        // Dynamic Island
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(top: 18),
            child: DynamicIslandFaceID(onUnlocked: widget.onUnlock),
          ),
        ),

        // Time + Date
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _time,
                style: const TextStyle(
                  fontSize: 64,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                _date,
                style: const TextStyle(color: Colors.white70, fontSize: 16),
              ),
            ],
          ),
        ),

        // Bottom icons
        Positioned(
          bottom: 25,
          left: 26,
          child: _lockButton(Icons.flashlight_on),
        ),
        Positioned(bottom: 25, right: 26, child: _lockButton(Icons.camera_alt)),
      ],
    );
  }

  Widget _lockButton(IconData icon) {
    return Container(
      height: 54,
      width: 54,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black.withOpacity(0.35),
        border: Border.all(color: Colors.white.withOpacity(0.25)),
      ),
      child: Icon(icon, color: Colors.white),
    );
  }
}

// import 'dart:async';
// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:portfolio/LoackScreen/FaceUnlock.dart';

// class LockScreen extends StatefulWidget {
//   final VoidCallback onUnlock;

//   const LockScreen({Key? key, required this.onUnlock}) : super(key: key);

//   @override
//   State<LockScreen> createState() => _LockScreenState();
// }

// class _LockScreenState extends State<LockScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _faceController;
//   late Animation<double> _pulse;
//   String _time = '';
//   String _date = '';
//   bool _faceSuccess = false;
//   Timer? _timeTimer;
//   Timer? _unlockTimer;

//   @override
//   void initState() {
//     super.initState();

//     _updateTime();
//     _timeTimer = Timer.periodic(
//       const Duration(seconds: 1),
//       (_) => _updateTime(),
//     );

//     _faceController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 900),
//     )..repeat(reverse: true);

//     _pulse = Tween<double>(begin: 0.9, end: 1.05).animate(
//       CurvedAnimation(parent: _faceController, curve: Curves.easeInOut),
//     );

//     // Simulate Face ID scanning then success
//     Future.delayed(const Duration(seconds: 2), () {
//       if (!mounted) return;
//       setState(() {
//         _faceSuccess = true;
//       });
//       _faceController.stop();

//       // After small delay, auto unlock
//       _unlockTimer = Timer(const Duration(milliseconds: 700), () {
//         if (!mounted) return;
//         widget.onUnlock();
//       });
//     });
//   }

//   void _updateTime() {
//     final now = DateTime.now();
//     setState(() {
//       _time =
//           '${_two(now.hour)}:${_two(now.minute)}'; // 24h; change if you want 12h
//       _date = '${_weekday(now.weekday)}, ${now.day} ${_month(now.month)}';
//     });
//   }

//   String _two(int n) => n.toString().padLeft(2, '0');

//   String _weekday(int w) {
//     const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
//     return days[w - 1];
//   }

//   String _month(int m) {
//     const months = [
//       'Jan',
//       'Feb',
//       'Mar',
//       'Apr',
//       'May',
//       'Jun',
//       'Jul',
//       'Aug',
//       'Sep',
//       'Oct',
//       'Nov',
//       'Dec',
//     ];
//     return months[m - 1];
//   }

//   @override
//   void dispose() {
//     _faceController.dispose();
//     _timeTimer?.cancel();
//     _unlockTimer?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         // Wallpaper
//         Container(
//           decoration: const BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage('assets/background/IPhoneBack2.jpg'),
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//         // Lock screen dim overlay
//         Container(color: Colors.black.withOpacity(0.35)),

//         // Dynamic Island with Face ID
//         Align(
//           alignment: Alignment.topCenter,
//           child: Padding(
//             padding: const EdgeInsets.only(top: 18),
//             child: DynamicIslandFaceID(onUnlocked: widget.onUnlock),
//           ),
//         ),

//         // Time + Date (center)
//         Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 _time,
//                 style: const TextStyle(
//                   fontSize: 64,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.white,
//                 ),
//               ),
//               const SizedBox(height: 6),
//               Text(
//                 _date,
//                 style: const TextStyle(fontSize: 16, color: Colors.white70),
//               ),
//             ],
//           ),
//         ),

//         // Small hint at bottom
//         Positioned(
//           bottom: 80,
//           left: 0,
//           right: 0,
//           child: AnimatedOpacity(
//             opacity: _faceSuccess ? 0.0 : 1.0,
//             duration: const Duration(milliseconds: 300),
//             child: const Text(
//               'Looking for Face ID…',
//               textAlign: TextAlign.center,
//               style: TextStyle(fontSize: 13, color: Colors.white70),
//             ),
//           ),
//         ),

//         // 🔦 Torch & 📷 Camera
//         Positioned(
//           bottom: 25,
//           left: 26,
//           child: lockActionButton(Icons.flashlight_on),
//         ),
//         Positioned(
//           bottom: 25,
//           right: 26,
//           child: lockActionButton(Icons.camera_alt),
//         ),
//       ],
//     );
//   }

//   Widget lockActionButton(IconData icon) {
//     return Container(
//       height: 54,
//       width: 54,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         color: Colors.black.withOpacity(0.35),
//         border: Border.all(color: Colors.white.withOpacity(0.25)),
//         boxShadow: [
//           BoxShadow(color: Colors.black.withOpacity(0.4), blurRadius: 12),
//         ],
//       ),
//       child: Icon(icon, color: Colors.white, size: 22),
//     );
//   }
// }
