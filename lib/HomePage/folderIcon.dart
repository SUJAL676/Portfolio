import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:portfolio/HomePage/HomeScreen.dart';

class FolderAppIcon extends StatelessWidget {
  final String title;
  final AppType? type;
  final void Function(AppType)? onOpen;
  final List<Widget> apps;

  const FolderAppIcon({
    super.key,
    required this.title,
    required this.apps,
    required this.onOpen,
    this.type,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () => FolderOverlay.show(context, title, apps),
      onTap: () {
        if (type != null && onOpen != null) {
          onOpen!(type!);
        }
      },
      child: Column(
        children: [
          Container(
            height: 58,
            width: 58,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.25),
              borderRadius: BorderRadius.circular(16),
            ),
            child: GridView.count(
              crossAxisCount: 2,
              physics: const NeverScrollableScrollPhysics(),
              children: apps.take(4).toList(),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: const TextStyle(fontSize: 10, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class FolderOverlayWidget extends StatefulWidget {
  final String title;
  final VoidCallback onClose;
  final void Function(AppType)? onOpen;

  const FolderOverlayWidget({
    required this.title,
    required this.onClose,
    required this.onOpen,
  });

  @override
  State<FolderOverlayWidget> createState() => _FolderOverlayWidgetState();
}

class _FolderOverlayWidgetState extends State<FolderOverlayWidget>
    with SingleTickerProviderStateMixin {
  bool opened = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 10), () {
      setState(() => opened = true);
    });
  }

  void close() {
    setState(() => opened = false);
    Future.delayed(const Duration(milliseconds: 200), widget.onClose);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: close,
      child: Stack(
        children: [
          // 🌫 Background blur
          AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: opened ? 1 : 0,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
              child: Container(color: Colors.black.withOpacity(0.25)),
            ),
          ),

          // 📂 Folder panel
          Center(
            child: AnimatedScale(
              scale: opened ? 1 : 0.8,
              duration: const Duration(milliseconds: 260),
              curve: Curves.easeOutCubic,
              child: AnimatedOpacity(
                opacity: opened ? 1 : 0,
                duration: const Duration(milliseconds: 180),
                child: GestureDetector(
                  onTap: () {}, // prevent closing
                  child: Container(
                    width: 260,
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.85),
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 14),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: [
                            ProjectApps(
                              logo: "GPS iconnect app.png",
                              title: 'GPS iConnect',
                              type: AppType.gps,
                              onOpen: widget.onOpen,
                            ),
                            ProjectApps(
                              logo: "anekant.png",
                              title: 'Anekant Tec...',
                              type: AppType.anekant,
                              onOpen: widget.onOpen,
                            ),
                          ],
                        ),

                        const SizedBox(height: 14),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: [
                            ProjectApps(
                              logo: "insta.png",
                              title: 'Insta Clone',
                              type: AppType.insta,
                              onOpen: widget.onOpen,
                            ),
                            ProjectApps(
                              logo: "portfolio.png",
                              title: 'Portfolio',
                              type: AppType.portfolio,
                              onOpen: widget.onOpen,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProjectApps extends StatefulWidget {
  final String logo;
  final String title;
  final void Function(AppType)? onOpen;
  final AppType? type;
  const ProjectApps({
    super.key,
    required this.logo,
    required this.title,
    required this.onOpen,
    required this.type,
  });

  @override
  State<ProjectApps> createState() => _ProjectAppsState();
}

class _ProjectAppsState extends State<ProjectApps> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.type != null && widget.onOpen != null) {
          print("hello");
          widget.onOpen!(widget.type!);
        } else {
          print(widget.type);
          // print(widget.onOpen);
          print("object");
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.all(1),
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              image: DecorationImage(
                image: AssetImage("assets/projects/${widget.logo}"),
              ),
            ),
          ),

          Text(widget.title),
        ],
      ),
    );
  }
}
