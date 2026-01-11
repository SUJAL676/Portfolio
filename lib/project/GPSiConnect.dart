import 'package:flutter/material.dart';
import 'package:portfolio/HomePage/HomeScreen.dart';
import 'package:portfolio/HomePage/IOSStatusBar.dart';

class GPSiConnect extends StatefulWidget {
  final VoidCallback onClose;
  final void Function(AppType)? onOpen;

  const GPSiConnect({super.key, required this.onClose, this.onOpen});

  @override
  State<GPSiConnect> createState() => _GPSiConnectState();
}

class _GPSiConnectState extends State<GPSiConnect> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final scale = (width / 1440).clamp(0.8, 1.25);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(color: Colors.black38, child: const IOSStatusBar()),

          customTopBar(onBack: widget.onClose, scale: scale),

          Container(
            margin: EdgeInsets.only(top: 90 * scale),
            padding: EdgeInsets.symmetric(horizontal: 20 * scale),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30 * scale),

                /// HEADER
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(22 * scale),
                      child: Image.asset(
                        'assets/projects/GPS iconnect app.png',
                        width: 100 * scale,
                        height: 100 * scale,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 16 * scale),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "GPS iConnect",
                            style: TextStyle(
                              fontSize: 22 * scale,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4 * scale),
                          Text(
                            "Tech Stack",
                            style: TextStyle(
                              fontSize: 14 * scale,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: 10 * scale),

                          SizedBox(
                            height: 36 * scale,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF007AFF),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    18 * scale,
                                  ),
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 24 * scale,
                                ),
                                elevation: 0,
                              ),
                              child: Text(
                                "Flutter | Dart",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15 * scale,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 24 * scale),

                /// STATS ROW (UNCHANGED STRUCTURE)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _StatItem(
                      scale,
                      title: "1500+",
                      subtitle: "Playstore",
                      subtitle1: "Downloads",
                    ),
                    stand(scale),
                    _StatItem(
                      scale,
                      title: "2000+",
                      subtitle: "Appstore",
                      subtitle1: "Downloads",
                    ),
                    stand(scale),
                    _StatItem(
                      scale,
                      title: "25+",
                      subtitle: "Used",
                      subtitle1: "Dependency",
                    ),
                  ],
                ),

                SizedBox(height: 28 * scale),

                Text(
                  "Features",
                  style: TextStyle(
                    fontSize: 20 * scale,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6 * scale),
                Text(
                  "Version 12.8.22 • 2 year till now",
                  style: TextStyle(color: Colors.grey, fontSize: 13 * scale),
                ),
                SizedBox(height: 10 * scale),

                featureText(
                  scale,
                  "- GPS iConnect is a smart business networking and digital contact management mobile application built to simplify professional connections.",
                ),
                featureText(
                  scale,
                  "- It enables users to create and share QR-based digital business cards, instantly scan and save contacts, and manage connections securely.",
                ),
                featureText(
                  scale,
                  "- The app supports biometric authentication, contact export to Excel, and event registration features.",
                ),

                SizedBox(height: 30 * scale),

                GestureDetector(
                  onTap: () {
                    widget.onOpen?.call(AppType.gps_img);
                  },
                  child: Container(
                    width: 120 * scale,
                    height: 40 * scale,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10 * scale),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "View Project",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14 * scale,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),

                // SizedBox(height: 40 * scale),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// HELPERS

  Widget featureText(double scale, String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10 * scale),
      child: Text(
        text,
        style: TextStyle(fontSize: 13 * scale),
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget stand(double scale) {
    return Container(width: 1, height: 60 * scale, color: Colors.black38);
  }

  Widget customTopBar({required VoidCallback onBack, required double scale}) {
    return Container(
      margin: EdgeInsets.only(top: 50 * scale),
      padding: EdgeInsets.symmetric(
        horizontal: 16 * scale,
        vertical: 10 * scale,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          topButton(
            scale,
            icon: Icons.arrow_back_ios_new,
            size: 18,
            onTap: onBack,
          ),
          topButton(scale, icon: Icons.share_outlined, size: 20),
        ],
      ),
    );
  }

  Widget topButton(
    double scale, {
    required IconData icon,
    required double size,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30 * scale),
      child: Container(
        padding: EdgeInsets.all(10 * scale),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8 * scale,
            ),
          ],
        ),
        child: Icon(icon, size: size * scale),
      ),
    );
  }
}

/// STAT ITEM (SCALED)
class _StatItem extends StatelessWidget {
  final double scale;
  final String title;
  final String subtitle;
  final String subtitle1;

  const _StatItem(
    this.scale, {
    required this.title,
    required this.subtitle,
    required this.subtitle1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 17 * scale, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 2 * scale),
        Text(
          subtitle,
          style: TextStyle(fontSize: 12 * scale, color: Colors.grey),
        ),
        Text(
          subtitle1,
          style: TextStyle(fontSize: 12 * scale, color: Colors.grey),
        ),
      ],
    );
  }
}
