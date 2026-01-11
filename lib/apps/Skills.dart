import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/HomePage/IOSStatusBar.dart';

class SkillsApp extends StatefulWidget {
  final VoidCallback onClose;
  const SkillsApp({super.key, required this.onClose});

  @override
  State<SkillsApp> createState() => _SkillsAppState();
}

class _SkillsAppState extends State<SkillsApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final height = constraints.maxHeight;

          /// 🔥 Image size scales with width
          final imageSize = (width * 0.6).clamp(140.0, 260.0);

          return Stack(
            children: [
              /// Status Bar Overlay
              Container(color: Colors.black38, child: const IOSStatusBar()),

              /// Background
              Positioned.fill(
                child: Padding(
                  padding: EdgeInsets.only(top: height * 0.05),
                  child: Image.asset(
                    "assets/background/paperbg.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              /// Skill Cards (Responsive & Aligned)
              _alignedSkill(
                alignment: const Alignment(-1.0, -0.85),
                size: imageSize,
                asset: "assets/graphics/skill1.png",
              ),

              _alignedSkill(
                alignment: const Alignment(1.5, -0.45),
                size: imageSize + 20,
                asset: "assets/graphics/skill2.png",
              ),

              _alignedSkill(
                alignment: const Alignment(-1.3, 0.01),
                size: imageSize + 20,
                asset: "assets/graphics/skill3.png",
              ),

              _alignedSkill(
                alignment: const Alignment(1.5, 0.4),
                size: imageSize + 20,
                asset: "assets/graphics/skill4.png",
              ),

              _alignedSkill(
                alignment: const Alignment(-1.1, 0.75),
                size: imageSize,
                asset: "assets/graphics/skill5.png",
              ),

              /// Back Button (Sticky bottom)
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: SizedBox(
                    width: width * 0.9,
                    height: 56,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      onPressed: widget.onClose,
                      child: Text(
                        "Back",
                        style: GoogleFonts.lato(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  /// 🔁 Reusable Responsive Skill Image
  Widget _alignedSkill({
    required Alignment alignment,
    required double size,
    required String asset,
  }) {
    return Align(
      alignment: alignment,
      child: AnimatedSize(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        child: Image.asset(asset, height: size, fit: BoxFit.contain),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:portfolio/HomePage/IOSStatusBar.dart';

// class SkillsApp extends StatefulWidget {
//   final VoidCallback onClose;
//   const SkillsApp({super.key, required this.onClose});

//   @override
//   State<SkillsApp> createState() => _SkillsAppState();
// }

// class _SkillsAppState extends State<SkillsApp> {
//   @override
//   Widget build(BuildContext context) {
//     var height = MediaQuery.of(context).size.height;
//     var width = MediaQuery.of(context).size.width;

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Stack(
//         children: [
//           Container(color: Colors.black38, child: IOSStatusBar()),

//           Center(
//             child: Container(
//               margin: EdgeInsets.only(top: height * 0.05),
//               height: height * 0.9,
//               width: width,
//               // color: Colors.amber,
//               child: Image.asset(
//                 "assets/background/paperbg.png",
//                 fit: BoxFit.fill,
//               ),
//             ),
//           ),

//           /// Skill Card 1 (Top Left)
//           Positioned(
//             top: height * 0.037,
//             right: height * 0.17,
//             child: Image.asset("assets/graphics/skill1.png", height: 240),
//           ),

//           /// Skill Card 3 (Middle Left)
//           Positioned(
//             top: height * 0.36,
//             right: height * 0.2,
//             child: Image.asset("assets/graphics/skill3.png", height: 220),
//           ),

//           /// Skill Card 2 (Top Right)
//           Positioned(
//             top: height * 0.23,
//             left: width * 0.09,
//             child: Image.asset("assets/graphics/skill2.png", height: 270),
//           ),

//           /// Skill Card 5 (Middle Left)
//           Positioned(
//             top: height * 0.6,
//             right: width * 0.1,
//             child: Image.asset("assets/graphics/skill5.png", height: 220),
//           ),

//           //Skill Card 4 (Middle Right)
//           Positioned(
//             top: height * 0.53,
//             left: width * 0.12,
//             child: Image.asset("assets/graphics/skill4.png", height: 240),
//           ),

//           Align(
//             alignment: Alignment.bottomCenter,
//             child: GestureDetector(
//               onTap: () {
//                 widget.onClose();
//               },
//               child: Container(
//                 width: width,
//                 height: height * 0.07,
//                 margin: EdgeInsets.only(
//                   bottom: height * 0.01,
//                   left: width * 0.01,
//                   right: width * 0.01,
//                 ),
//                 decoration: BoxDecoration(
//                   color: Colors.black,
//                   borderRadius: BorderRadius.all(Radius.circular(20)),
//                 ),

//                 child: Center(
//                   child: Text(
//                     "Back",
//                     style: GoogleFonts.lato(
//                       color: Colors.white,
//                       fontSize: 18,
//                       fontWeight: FontWeight.w800,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

