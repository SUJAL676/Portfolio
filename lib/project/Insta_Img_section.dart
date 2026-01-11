import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/HomePage/HomeScreen.dart';
import 'package:portfolio/HomePage/IOSStatusBar.dart';

class InstaImgSection extends StatefulWidget {
  final void Function(AppType)? onOpen;
  final VoidCallback onClose;
  const InstaImgSection({
    super.key,
    required this.onOpen,
    required this.onClose,
  });

  @override
  State<InstaImgSection> createState() => _InstaImgSectionState();
}

class _InstaImgSectionState extends State<InstaImgSection> {
  int currentNumber = 1;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final scale = (width / 1440).clamp(0.8, 1.25);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(color: Colors.black38, child: const IOSStatusBar()),

          customTopBar(
            onBack: () => widget.onOpen!(AppType.insta),
            scale: scale,
          ),

          /// IMAGE PREVIEW
          Center(
            child: Container(
              height: 520 * scale,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12 * scale),
                border: Border.all(color: Colors.white, width: 2 * scale),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 12 * scale,
                    offset: Offset(0, 6 * scale),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12 * scale),
                child: Image.asset(
                  "assets/projects/insta${currentNumber}.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          bottom(context: context, scale: scale, height: height),
        ],
      ),
    );
  }

  /// BOTTOM PAGINATION
  Widget bottom({
    required BuildContext context,
    required double scale,
    required double height,
  }) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: EdgeInsets.only(bottom: 20 * scale),
        height: height * 0.05 * scale,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            number(number: 1, scale: scale),
            dot(scale),
            number(number: 2, scale: scale),
            dot(scale),
            number(number: 3, scale: scale),
          ],
        ),
      ),
    );
  }

  Widget dot(double scale) {
    return Text(".", style: GoogleFonts.lato(fontSize: 16 * scale));
  }

  Widget number({required int number, required double scale}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          currentNumber = number;
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20 * scale),
        child: Text(
          "$number",
          style: GoogleFonts.lato(
            fontSize: 18 * scale,
            fontWeight: currentNumber == number
                ? FontWeight.w800
                : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  /// TOP BAR
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
            icon: Icons.arrow_back_ios_new,
            size: 18,
            scale: scale,
            onTap: onBack,
          ),
          topButton(icon: Icons.share_outlined, size: 20, scale: scale),
        ],
      ),
    );
  }

  Widget topButton({
    required IconData icon,
    required double size,
    required double scale,
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
        child: Icon(icon, size: size * scale, color: Colors.black),
      ),
    );
  }
}
