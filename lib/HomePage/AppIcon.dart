import 'dart:math';

import 'package:flutter/material.dart';
import 'package:portfolio/HomePage/HomeScreen.dart';
import 'package:portfolio/Widgets/ResumeDownload.dart';
import 'package:url_launcher/url_launcher.dart';

class AppIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final String Image;
  final AppType? type;
  final void Function(AppType)? onOpen;

  const AppIcon({
    super.key,
    required this.icon,
    required this.label,
    required this.Image,
    this.type,
    this.onOpen,
  });

  Future<void> _openLink(String? url) async {
    if (url == null) return;
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final scale = (MediaQuery.of(context).size.width / 1440).clamp(0.8, 1.25);

    return GestureDetector(
      onTap: () {
        if (type != null && onOpen != null && type != AppType.resume) {
          onOpen!(type!);
        }
        if (type == AppType.resume) {
          _openLink(
            "https://drive.google.com/file/d/1SokLNZqwL0_7qDY4XB7ZjjIBU8Ub5hSl/view?usp=sharing",
          );
        }
      },
      child: Column(
        children: [
          Container(
            height: 70 * scale,
            width: 70 * scale,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.25),
              borderRadius: BorderRadius.circular(18 * scale),
              image: DecorationImage(
                image: AssetImage("assets/icons/$Image"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(height: 6 * scale),
          Text(
            label,
            style: TextStyle(
              fontSize: 9 * scale,
              color: Colors.white,
              letterSpacing: 0.4,
            ),
          ),
        ],
      ),
    );
  }
}

class AppIconBounce extends StatefulWidget {
  final Widget child;
  final int index;

  const AppIconBounce({super.key, required this.child, required this.index});

  @override
  State<AppIconBounce> createState() => _AppIconBounceState();
}

class _AppIconBounceState extends State<AppIconBounce>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    // ✅ Staggered start (SAFE)
    Future.delayed(Duration(milliseconds: 80 * widget.index), () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: widget.child,
      builder: (context, child) {
        // ✅ iOS-style soft bounce using sine curve
        final t = _controller.value;
        final scale = 1 + (0.08 * (1 - t) * (t * 3.14));
        final offsetY = (1 - t) * 14;

        return Transform.translate(
          offset: Offset(0, offsetY),
          child: Transform.scale(scale: scale, child: child),
        );
      },
    );
  }
}
