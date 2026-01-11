import 'package:flutter/material.dart';

class InfoSquareWidget extends StatefulWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const InfoSquareWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  State<InfoSquareWidget> createState() => _InfoSquareWidgetState();
}

class _InfoSquareWidgetState extends State<InfoSquareWidget> {
  double tapScale = 1.0;
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    final scale = (MediaQuery.of(context).size.width / 1440).clamp(0.8, 1.25);

    return MouseRegion(
      onEnter: (_) => setState(() => isHovering = true),
      onExit: (_) => setState(() => isHovering = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => tapScale = 0.95),
        onTapUp: (_) => setState(() => tapScale = 1.0),
        onTapCancel: () => setState(() => tapScale = 1.0),
        child: AnimatedScale(
          scale: isHovering ? 1.03 : tapScale,
          duration: const Duration(milliseconds: 160),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            height: 120 * scale,
            padding: EdgeInsets.all(14 * scale),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.20),
              borderRadius: BorderRadius.circular(22 * scale),
              border: Border.all(
                color: Colors.white.withOpacity(isHovering ? 0.25 : 0.15),
                width: 1.2 * scale,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(widget.icon, color: Colors.white, size: 28 * scale),
                const Spacer(),
                Text(
                  widget.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15 * scale,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 3 * scale),
                Text(
                  widget.subtitle,
                  style: TextStyle(color: Colors.white70, fontSize: 11 * scale),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
