// COMMON TOP BAR USED BY ALL APPS
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/HomePage/IOSStatusBar.dart';

class _AppTopBar extends StatelessWidget {
  final String title;
  final VoidCallback onClose;

  const _AppTopBar({Key? key, required this.title, required this.onClose})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.black),
            onPressed: onClose,
          ),
          Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class AboutApp extends StatefulWidget {
  final VoidCallback onClose;
  const AboutApp({super.key, required this.onClose});

  @override
  State<AboutApp> createState() => _AboutAppState();
}

class _AboutAppState extends State<AboutApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final w = constraints.maxWidth;
          final h = constraints.maxHeight;

          /// 📐 Design reference width (desktop)
          const designWidth = 1200.0;

          /// 🔥 Scale ONLY when screen is smaller
          final scale = (w / designWidth).clamp(0.6, 1.0);

          /// 🎯 Base sizes (used on large screens)
          final headingSize = 76.0 * scale;
          final bodyTextSize = 26.0 * scale;
          final illustrationWidth = 820.0 * scale;
          final buttonWidth = 200.0 * scale;
          const buttonHeight = 76.0;

          final width = MediaQuery.of(context).size.width;

          return Stack(
            children: [
              /// Status bar
              Container(color: Colors.black38, child: const IOSStatusBar()),

              /// Background
              Positioned.fill(
                child: Padding(
                  padding: EdgeInsets.only(top: h * 0.06),
                  child: Image.asset(
                    "assets/background/sqaurebg.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              /// Header
              Positioned(
                top: h * 0.08,
                left: w * 0.06,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            print(MediaQuery.of(context).size.width);
                          },
                          child: Text(
                            "Hello",
                            style: GoogleFonts.lato(
                              fontSize: headingSize,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16 * scale,
                            vertical: 6 * scale,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Text(
                            width >= 1128
                                ? "https://linkedin.com/in/sujal"
                                : "linkedin.com/sujal",
                            style: GoogleFonts.lato(
                              fontSize: 20 * scale,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Everyone.",
                      style: GoogleFonts.lato(
                        fontSize: headingSize,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),

              /// Illustration (CENTER)
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/graphics/AboutMe1.png",
                  width: illustrationWidth,
                  fit: BoxFit.contain,
                ),
              ),

              /// Bottom content
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: w * 0.06,
                    vertical: h * 0.04,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // SizedBox(height: width >= 1007 ? 20 : 0),
                      Text(
                        width >= 1128
                            ? "I'm Sujal Kanojia, a Flutter developer focused on "
                                  "building scalable, high-performance mobile and web "
                                  "applications. I enjoy turning complex ideas into clean, "
                                  "user-friendly digital experiences."
                            : "I'm Sujal Kanojia, a Flutter developer focused on "
                                  "building scalable, high-performance mobile and web "
                                  "applications.",
                        style: GoogleFonts.lato(
                          fontSize: width >= 1128
                              ? bodyTextSize
                              : width >= 1007
                              ? 17
                              : 13,
                          fontWeight: FontWeight.w800,
                        ),
                        textAlign: TextAlign.justify,
                      ),

                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _outlineButton(
                            label: "Back",
                            width: width >= 1128 ? 150 : buttonWidth,
                            height: width >= 1128 ? 80 : buttonHeight,
                            scale: scale,
                            onTap: widget.onClose,
                          ),
                          _filledButton(
                            label: "Resume",
                            width: width >= 1128 ? 150 : buttonWidth,
                            height: width >= 1128 ? 80 : buttonHeight,
                            scale: scale,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _outlineButton({
    required String label,
    required double width,
    required double height,
    required double scale,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height * scale,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            label,
            style: GoogleFonts.lato(
              fontSize: 25 * scale,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }

  Widget _filledButton({
    required String label,
    required double width,
    required double height,
    required double scale,
  }) {
    return Container(
      width: width,
      height: height * scale,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          label,
          style: GoogleFonts.lato(
            fontSize: 25 * scale,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

// class AboutApp extends StatefulWidget {
//   final VoidCallback onClose;
//   const AboutApp({super.key, required this.onClose});

//   @override
//   State<AboutApp> createState() => _AboutAppState();
// }

// class _AboutAppState extends State<AboutApp> {
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
//               margin: EdgeInsets.only(top: height * 0.06),
//               height: height * 0.86,
//               width: width,
//               // color: Colors.amber,
//               child: Image.asset(
//                 "assets/background/sqaurebg.png",
//                 fit: BoxFit.fill,
//               ),
//             ),
//           ),

//           Container(
//             margin: EdgeInsets.only(top: height * 0.05),
//             height: height * 0.2,
//             width: width,

//             padding: EdgeInsets.only(left: width * 0.02, top: height * 0.03),

//             // color: Colors.amber,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.start,

//               children: [
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   mainAxisAlignment: MainAxisAlignment.start,

//                   children: [
//                     Text(
//                       "Hello",
//                       style: GoogleFonts.lato(
//                         color: Colors.black,
//                         fontSize: 45,
//                         fontWeight: FontWeight.w900,
//                       ),
//                     ),

//                     SizedBox(width: width * 0.01),

//                     Container(
//                       width: width * 0.13,
//                       height: height * 0.035,

//                       decoration: BoxDecoration(
//                         color: Colors.black,
//                         borderRadius: BorderRadius.all(Radius.circular(18)),
//                       ),

//                       child: Center(
//                         child: Text(
//                           "https://linkedin.com/in/sujal",
//                           style: GoogleFonts.lato(
//                             color: Colors.white,
//                             fontSize: 12,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Text(
//                   "Everyone .",
//                   style: GoogleFonts.lato(
//                     color: Colors.black,
//                     fontSize: 45,
//                     fontWeight: FontWeight.w900,
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           Center(
//             child: Container(
//               // color: Colors.black,
//               margin: EdgeInsets.only(bottom: height * 0.1),
//               // height: height * 0.4,
//               // width: width,
//               child: Image.asset(
//                 "assets/graphics/AboutMe1.png",

//                 fit: BoxFit.fill,
//               ),
//             ),
//           ),

//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Container(
//               // color: Colors.amber,
//               height: height * 0.32,
//               padding: EdgeInsets.only(left: width * 0.02, top: height * 0.03),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.start,

//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(right: 30),
//                     child: Text(
//                       "I'm Sujal Kanojia, a Flutter developer focused on building scalable, high-performance mobile and web applications. I enjoy turning complex ideas into clean, user-friendly digital experiences.",
//                       style: GoogleFonts.lato(
//                         fontSize: 16,
//                         color: Colors.black,
//                         fontWeight: FontWeight.w800,
//                       ),
//                       textAlign: TextAlign.justify,
//                     ),
//                   ),

//                   Spacer(),

//                   Padding(
//                     padding: EdgeInsetsGeometry.only(right: 30),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,

//                       children: [
//                         GestureDetector(
//                           onTap: () {
//                             widget.onClose();
//                           },
//                           child: Container(
//                             width: width * 0.1,
//                             height: height * 0.065,

//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               border: Border.all(color: Colors.black),
//                               borderRadius: BorderRadius.all(
//                                 Radius.circular(20),
//                               ),
//                             ),

//                             child: Center(
//                               child: Text(
//                                 "Back",
//                                 style: GoogleFonts.lato(
//                                   fontSize: 15,
//                                   fontWeight: FontWeight.w700,
//                                   color: Colors.black,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),

//                         Container(
//                           width: width * 0.1,
//                           height: height * 0.065,

//                           decoration: BoxDecoration(
//                             color: Colors.black,
//                             borderRadius: BorderRadius.all(Radius.circular(20)),
//                           ),

//                           child: Center(
//                             child: Text(
//                               "Resume",
//                               style: GoogleFonts.lato(
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.w700,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),

//                   SizedBox(height: 20),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// ---------------- PROJECTS APP ----------------
class ProjectsApp extends StatelessWidget {
  final VoidCallback onClose;

  const ProjectsApp({Key? key, required this.onClose}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            _AppTopBar(title: "Projects", onClose: onClose),
            const Divider(color: Colors.white24, height: 1),
            const Expanded(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "GPS iConnect",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Business networking app with 1000+ downloads.",
                        style: TextStyle(color: Colors.white70, fontSize: 13),
                      ),
                      SizedBox(height: 16),

                      Text(
                        "HeyBuddy",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Platform to connect lawyers and under-trial prisoners.",
                        style: TextStyle(color: Colors.white70, fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
