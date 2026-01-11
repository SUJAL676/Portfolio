import 'package:flutter/material.dart';
import 'package:portfolio/HomePage/IOSStatusBar.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactStoryScreen extends StatefulWidget {
  final VoidCallback onClose;
  const ContactStoryScreen({super.key, required this.onClose});

  @override
  State<ContactStoryScreen> createState() => _ContactStoryScreenState();
}

class _ContactStoryScreenState extends State<ContactStoryScreen> {
  final PageController _pageController = PageController();
  int currentIndex = 0;

  final List<Map<String, String>> screens = [
    {
      "title": "Let's connect\nvia Email\nfor meaningful conversations.",
      "subtitle": "Fast replies. Professional communication.",
      "button": "Send Email →",
      "action": "mailto:sujalkanojia@example.com",
    },
    {
      "title": "Build professional\nconnections on\nLinkedIn.",
      "subtitle": "Careers • Networking • Growth",
      "button": "View LinkedIn →",
      "action": "https://www.linkedin.com/in/sujal-kanojia-2bb137233/",
    },
    {
      "title": "Explore my\ncode repositories\non GitHub.",
      "subtitle": "Clean code. Scalable apps.",
      "button": "View Projects →",
      "action": "https://github.com/SUJAL676",
    },
    {
      "title": "Based in\nIndia 🇮🇳\nOpen to global opportunities.",
      "subtitle": "Remote • Hybrid • On-site",
      "button": "View Location →",
      "action": "https://maps.google.com/?q=India",
    },
  ];

  Future<void> _openLink(String? url) async {
    if (url == null) return;
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  void nextPage() {
    if (currentIndex < screens.length - 1) {
      setState(() => currentIndex++);
      _pageController.animateToPage(
        currentIndex,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOut,
      );
    }
  }

  void previousPage() {
    if (currentIndex > 0) {
      setState(() => currentIndex--);
      _pageController.animateToPage(
        currentIndex,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final scale = (width / 1440).clamp(0.8, 1.25);

    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTapDown: (details) {
          final dx = details.globalPosition.dx;
          if (dx < width * 0.6) {
            previousPage();
          } else {
            nextPage();
          }
        },
        child: Stack(
          children: [
            /// PAGE CONTENT
            PageView.builder(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: screens.length,
              itemBuilder: (context, index) {
                final data = screens[index];
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 28 * scale),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFFB89B6A), Color(0xFFD7BE8A)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        data["title"]!,
                        style: TextStyle(
                          fontSize: 36 * scale,
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                          height: 1.2,
                        ),
                      ),
                      if (data["subtitle"]!.isNotEmpty) ...[
                        SizedBox(height: 20 * scale),
                        Text(
                          data["subtitle"]!,
                          style: TextStyle(
                            fontSize: 16 * scale,
                            color: Colors.white.withOpacity(0.85),
                          ),
                        ),
                      ],
                      SizedBox(height: 40 * scale),
                      ActionButton(
                        title: data["button"]!,
                        scale: scale,
                        onTap: () => _openLink(data["action"]),
                      ),
                    ],
                  ),
                );
              },
            ),

            Container(color: Colors.black38, child: const IOSStatusBar()),

            customTopBar(onBack: widget.onClose, scale: scale),

            /// TOP STORY INDICATOR
            Positioned(
              top: MediaQuery.of(context).padding.top + 50 * scale,
              left: 16 * scale,
              right: 16 * scale,
              child: Row(
                children: List.generate(
                  screens.length,
                  (index) => Expanded(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: EdgeInsets.symmetric(horizontal: 4 * scale),
                      height: 4 * scale,
                      decoration: BoxDecoration(
                        color: index <= currentIndex
                            ? Colors.white
                            : Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(8 * scale),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// TOP BAR
  Widget customTopBar({required VoidCallback onBack, required double scale}) {
    return Container(
      margin: EdgeInsets.only(top: 60 * scale),
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

/// ACTION BUTTON (SCALED ONLY)
class ActionButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final double scale;

  const ActionButton({required this.title, required this.scale, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 54 * scale,
        width: 220 * scale,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.35),
          borderRadius: BorderRadius.circular(30 * scale),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.lock_outline, color: Colors.white, size: 20 * scale),
            SizedBox(width: 12 * scale),
            Text(
              title,
              style: TextStyle(color: Colors.white, fontSize: 15 * scale),
            ),
          ],
        ),
      ),
    );
  }
}
