import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:portfolio/HomePage/HomeScreen.dart';
import 'package:portfolio/LoackScreen/FaceUnlock.dart';
import 'package:portfolio/LoackScreen/LockScreen.dart';
import 'package:portfolio/Widgets/TerminalWidget.dart';
import 'package:portfolio/Widgets/backgroundVedio.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sujal Kanojia — Flutter Portfolio',
      theme: ThemeData(brightness: Brightness.light, fontFamily: 'Inter'),
      home: Scaffold(
        backgroundColor: Colors.white,
        // backgroundColor: Color.fromARGB(255, 232, 183, 125),
        // body: SafeArea(child: Center(child: DeviceShowcase())),
        body: Stack(
          children: [
            const BackgroundGif(
              assetPath: 'assets/animation/snow.json',
              opacity: 0.35,
            ),

            // Optional dark overlay (recommended)
            Container(color: Colors.black.withOpacity(0.15)),

            const SafeArea(child: Center(child: DeviceShowcase())),
          ],
        ),
      ),
    );
  }
}

class DeviceShowcase extends StatefulWidget {
  const DeviceShowcase({super.key});

  @override
  State<DeviceShowcase> createState() => _DeviceShowcaseState();
}

class _DeviceShowcaseState extends State<DeviceShowcase> {
  bool unlocked = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;

        /// 📱 PHONE SIZE
        final phoneWidth = (screenWidth * 0.35).clamp(300.0, 420.0);
        final phoneHeight = phoneWidth * 2.1;

        const gap = 20.0;
        const timelineWidth = 260.0;
        const terminalMinWidth = 260.0;
        const terminalMaxWidth = 420.0;

        /// 🔐 VERY SMALL SCREEN → PHONE ONLY
        if (screenWidth < 600) {
          return Center(
            child: FittedBox(
              child: _PhoneFrame(
                phoneWidth: phoneWidth,
                phoneHeight: phoneHeight,
                unlocked: unlocked,
                onUnlock: () => setState(() => unlocked = true),
              ),
            ),
          );
        }

        final remaining = screenWidth - phoneWidth - (gap * 2);
        final showTimeline = remaining > 520;
        final showTerminal = remaining > 300;

        final terminalWidth = showTerminal
            ? (remaining - (showTimeline ? timelineWidth : 0))
                  .clamp(terminalMinWidth, terminalMaxWidth)
                  .toDouble()
            : 0.0;

        return Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// 🟨 TIMELINE
                if (showTimeline) ...[
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      TimelineImage('assets/graphics/t1.png'),
                      SizedBox(height: 40),
                      Padding(
                        padding: EdgeInsets.only(left: 50),
                        child: TimelineImage('assets/graphics/t2_1.png'),
                      ),
                      SizedBox(height: 40),
                      TimelineImage('assets/graphics/t3.png'),
                    ],
                  ),
                  const SizedBox(width: gap),
                ],

                /// 📱 PHONE
                _PhoneFrame(
                  phoneWidth: phoneWidth,
                  phoneHeight: phoneHeight,
                  unlocked: unlocked,
                  onUnlock: () => setState(() => unlocked = true),
                ),

                /// 🧠 TERMINAL
                if (showTerminal) ...[
                  const SizedBox(width: gap),
                  SizedBox(width: terminalWidth, child: const TerminalCard()),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}

/// 📱 IPHONE FRAME WIDGET
class _PhoneFrame extends StatelessWidget {
  final double phoneWidth;
  final double phoneHeight;
  final bool unlocked;
  final VoidCallback onUnlock;

  const _PhoneFrame({
    required this.phoneWidth,
    required this.phoneHeight,
    required this.unlocked,
    required this.onUnlock,
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: SizedBox(
        width: phoneWidth + 40,
        height: phoneHeight + 40,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              'assets/iphone_frame.png',
              width: phoneWidth + 20,
              height: phoneHeight + 20,
              fit: BoxFit.contain,
            ),
            Positioned(
              top: phoneHeight * 0.073,
              bottom: phoneHeight * 0.073,
              left: phoneWidth * 0.11,
              right: phoneWidth * 0.11,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(46),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: unlocked
                      ? const HomeScreen(key: ValueKey('home'))
                      : LockScreen(
                          key: const ValueKey('lock'),
                          onUnlock: onUnlock,
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

/// 🖼️ TIMELINE IMAGE (ROW SAFE)
class TimelineImage extends StatelessWidget {
  final String asset;
  const TimelineImage(this.asset, {super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: height * 0.13,
      width: width * 0.36,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.asset(asset, fit: BoxFit.cover),
      ),
    );
  }
}
