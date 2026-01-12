import 'package:flutter/material.dart';
import 'package:portfolio/HomePage/AppIcon.dart';
import 'package:portfolio/HomePage/AppOverlay.dart';
import 'package:portfolio/HomePage/IOSStatusBar.dart';
import 'package:portfolio/HomePage/InfoWidget.dart';
import 'package:portfolio/HomePage/WeatherWidget.dart';
import 'package:portfolio/HomePage/folderIcon.dart';

enum AppType {
  about,
  projects,
  skills,
  resume,
  contact,
  socials,
  timeline,
  gps,
  gps_img,
  anekant,
  anekant_img,
  insta,
  insta_img,
  portfolio,
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AppType? openedApp;

  void openApp(AppType type) => setState(() => openedApp = type);
  void closeApp() => setState(() => openedApp = null);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final scale = (width / 1440).clamp(0.8, 1.25);

    return Stack(
      children: [
        /// BACKGROUND
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/background/IphoneBack10.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 15 * scale),
              IOSStatusBar(),
              SizedBox(height: 15 * scale),

              /// INFO ROW 1
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18 * scale),
                child: Row(
                  children: const [
                    Expanded(
                      child: InfoSquareWidget(
                        icon: Icons.person,
                        title: "About Me",
                        subtitle: "Flutter Dev",
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: InfoSquareWidget(
                        icon: Icons.code,
                        title: "Experience",
                        subtitle: "2+ Years",
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 12 * scale),

              /// INFO ROW 2
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18 * scale),
                child: Row(
                  children: const [
                    Expanded(
                      child: InfoSquareWidget(
                        icon: Icons.work,
                        title: "Projects",
                        subtitle: "15+ Completed",
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(child: WeatherSquareWidget()),
                  ],
                ),
              ),

              SizedBox(height: 12 * scale),

              /// APP GRID
              Expanded(
                child: GridView.count(
                  crossAxisCount: 4,
                  padding: EdgeInsets.symmetric(
                    horizontal: 18 * scale,
                    vertical: 12 * scale,
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio: 0.78,
                  children: [
                    AppIconBounce(
                      index: 0,
                      child: AppIcon(
                        icon: Icons.person,
                        label: "About",
                        type: AppType.about,
                        onOpen: openApp,
                        Image: 'AboutIcon.png',
                      ),
                    ),
                    FolderAppIcon(
                      title: "Projects",
                      apps: const [
                        SmallAppIcon(
                          logo: "GPS iconnect app.png",
                          label: "Travel",
                        ),
                        SmallAppIcon(logo: "anekant.png", label: "Health"),
                        SmallAppIcon(logo: "insta.png", label: "Chat"),
                        SmallAppIcon(logo: "portfolio.png", label: "Shop"),
                      ],
                      onOpen: openApp,
                      type: AppType.projects,
                    ),
                    AppIconBounce(
                      index: 2,
                      child: AppIcon(
                        icon: Icons.code,
                        label: "Skills",
                        type: AppType.skills,
                        onOpen: openApp,
                        Image: 'SkillIcon.png',
                      ),
                    ),
                    AppIconBounce(
                      index: 3,
                      child: AppIcon(
                        icon: Icons.mail,
                        label: "Contact",
                        type: AppType.contact,
                        onOpen: openApp,
                        Image: 'ContactIcon.png',
                      ),
                    ),
                    AppIconBounce(
                      index: 4,
                      child: AppIcon(
                        icon: Icons.description,
                        label: "Resume",
                        type: AppType.resume,
                        onOpen: openApp,
                        Image: 'ResumeIcon.png',
                      ),
                    ),
                    AppIconBounce(
                      index: 5,
                      child: AppIcon(
                        icon: Icons.share,
                        label: "Socials",
                        type: AppType.socials,
                        onOpen: openApp,
                        Image: 'SocialIcon.png',
                      ),
                    ),
                  ],
                ),
              ),

              /// DOCK
              Container(
                height: 80 * scale,
                margin: EdgeInsets.only(
                  bottom: 10 * scale,
                  left: 6 * scale,
                  right: 6 * scale,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(30 * scale),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    DockIcon(icon: Icons.call),
                    DockIcon(icon: Icons.email),
                    DockIcon(icon: Icons.link),
                    DockIcon(icon: Icons.settings),
                  ],
                ),
              ),
            ],
          ),
        ),

        /// APP OVERLAY
        if (openedApp != null)
          AppOverlay(app: openedApp!, onClose: closeApp, onOpen: openApp),
      ],
    );
  }
}

/// ✅ DOCK ICON
class DockIcon extends StatelessWidget {
  final IconData icon;

  const DockIcon({Key? key, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: 55,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.25),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Icon(icon, color: Colors.white, size: 26),
    );
  }
}

class SmallAppIcon extends StatelessWidget {
  final String logo;
  final String label;

  const SmallAppIcon({super.key, required this.logo, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(1),
      height: 20,
      width: 20,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        image: DecorationImage(image: AssetImage("assets/projects/${logo}")),
      ),
      // child: Icon(icon, color: Colors.black),
    );
  }
}
