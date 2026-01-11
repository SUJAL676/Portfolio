import 'package:flutter/material.dart';
import 'package:portfolio/HomePage/HomeScreen.dart';
import 'package:portfolio/HomePage/folderIcon.dart';
import 'package:portfolio/apps/About.dart';
import 'package:portfolio/apps/Contact.dart';
import 'package:portfolio/apps/Resume.dart';
import 'package:portfolio/apps/Skills.dart';
import 'package:portfolio/apps/Social.dart';
import 'package:portfolio/apps/timeline.dart';
import 'package:portfolio/project/Anekant.dart';
import 'package:portfolio/project/Anekant_Img_section.dart';
import 'package:portfolio/project/GPSiConnect.dart';
import 'package:portfolio/project/Gps_Img_Section.dart';
import 'package:portfolio/project/Insta.dart';
import 'package:portfolio/project/Insta_Img_section.dart';
import 'package:portfolio/project/portfolio.dart';

// Overlay that shows the opened app with a small zoom-in animation
class AppOverlay extends StatelessWidget {
  final AppType app;
  final VoidCallback onClose;
  final void Function(AppType)? onOpen;

  const AppOverlay({
    Key? key,
    required this.app,
    required this.onClose,
    required this.onOpen,
  }) : super(key: key);

  Widget _buildApp() {
    switch (app) {
      case AppType.about:
        return AboutApp(onClose: onClose);
      case AppType.skills:
        return SkillsApp(onClose: onClose);
      case AppType.resume:
        return ResumeApp(onClose: onClose);
      case AppType.contact:
        return ContactFormScreen(onClose: onClose);
      case AppType.socials:
        return ContactStoryScreen(onClose: onClose);
      case AppType.timeline:
        return TimelineApp(onClose: onClose);
      case AppType.projects:
        return FolderOverlayWidget(
          title: "Project",
          onClose: onClose,
          onOpen: onOpen,
        );
      case AppType.gps:
        return GPSiConnect(onClose: onClose, onOpen: onOpen);
      case AppType.gps_img:
        return Gps_Image_Section(onOpen: onOpen, onClose: onClose);
      case AppType.anekant:
        return AnekantProject(onOpen: onOpen, onClose: onClose);
      case AppType.anekant_img:
        return Anekant_Img_Section(onOpen: onOpen, onClose: onClose);
      case AppType.insta:
        return InstaScreen(onClose: onClose, onOpen: onOpen);
      case AppType.insta_img:
        return InstaImgSection(onOpen: onOpen, onClose: onClose);
      case AppType.portfolio:
        return PortfolioProject(onClose: onClose, onOpen: onOpen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: 1.0,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
      child: _buildApp(),
    );
  }
}
