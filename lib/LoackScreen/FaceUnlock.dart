// import 'package:flutter/material.dart';

// class DynamicIslandFaceID extends StatefulWidget {
//   final VoidCallback onUnlocked;
//   const DynamicIslandFaceID({super.key, required this.onUnlocked});

//   @override
//   State<DynamicIslandFaceID> createState() => _DynamicIslandFaceIDState();
// }

// class _DynamicIslandFaceIDState extends State<DynamicIslandFaceID> {
//   bool success = false;
//   bool unlocked = false;

//   @override
//   void initState() {
//     super.initState();

//     Future.delayed(const Duration(milliseconds: 1600), () {
//       if (!mounted) return;
//       setState(() => success = true);
//     });

//     Future.delayed(const Duration(milliseconds: 2600), () {
//       if (!mounted || unlocked) return;
//       unlocked = true;
//       widget.onUnlocked();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 80, // IMPORTANT constraint
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 450),
//         curve: Curves.easeOutCubic,
//         width: success ? 72 : 160,
//         height: success ? 72 : 36,
//         decoration: BoxDecoration(
//           color: Colors.black.withOpacity(0.75),
//           borderRadius: BorderRadius.circular(success ? 18 : 20),
//           boxShadow: [
//             BoxShadow(color: Colors.black.withOpacity(0.55), blurRadius: 18),
//           ],
//         ),
//         child: Center(
//           child: AnimatedSwitcher(
//             duration: const Duration(milliseconds: 250),
//             child: success
//                 ? Image.asset(
//                     "assets/icons/smileIphone.png",
//                     key: const ValueKey('success'),
//                     color: Colors.green,
//                     height: 36,
//                   )
//                 : Row(
//                     key: const ValueKey('scan'),
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Image.asset(
//                         "assets/icons/lock.png",
//                         height: 18,
//                         color: Colors.white,
//                       ),
//                       const SizedBox(width: 8),
//                       TweenAnimationBuilder<double>(
//                         tween: Tween(begin: 0.85, end: 1.1),
//                         duration: const Duration(milliseconds: 700),
//                         curve: Curves.easeInOut,
//                         builder: (_, scale, child) =>
//                             Transform.scale(scale: scale, child: child),
//                         child: Image.asset(
//                           "assets/icons/IphoneLockRightSide.png",
//                           height: 18,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ],
//                   ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class DynamicIslandFaceID extends StatefulWidget {
  final VoidCallback onUnlocked;
  const DynamicIslandFaceID({super.key, required this.onUnlocked});

  @override
  State<DynamicIslandFaceID> createState() => _DynamicIslandFaceIDState();
}

class _DynamicIslandFaceIDState extends State<DynamicIslandFaceID> {
  bool success = false;

  @override
  void initState() {
    super.initState();

    // Step 1: Face scanning delay
    Future.delayed(const Duration(milliseconds: 1600), () {
      if (!mounted) return;
      setState(() => success = true);
    });

    // Step 2: Auto unlock after check
    Future.delayed(const Duration(milliseconds: 2600), () {
      widget.onUnlocked();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 450),
      curve: Curves.easeOutCubic,

      width: success ? 72 : 160,
      height: success ? 72 : 36,

      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.75),
        borderRadius: BorderRadius.circular(success ? 18 : 20),

        // 🔥 Soft edge glow
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.55),
            blurRadius: 18,
            spreadRadius: 2,
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.05),
            blurRadius: 2,
            spreadRadius: 0,
          ),
        ],
      ),

      child: Center(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),

          child: success
              ? Container(
                  height: 40,
                  child: Image.asset(
                    "assets/icons/smileIphone.png",
                    color: Colors.green,
                  ),
                )
              : Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    key: const ValueKey('scan'),
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Lock icon
                      Container(
                        height: 18,
                        child: Image.asset(
                          "assets/icons/lock.png",
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Pulsing Face ID icon
                      TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0.3, end: 0.7),
                        duration: const Duration(milliseconds: 700),
                        curve: Curves.easeInOut,
                        builder: (context, scale, child) {
                          return Transform.scale(scale: scale, child: child);
                        },
                        child: Image.asset(
                          "assets/icons/IphoneLockRightSide.png",
                          color: Colors.white,
                          scale: 18,
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
