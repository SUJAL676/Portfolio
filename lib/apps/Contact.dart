import 'package:flutter/material.dart';
import 'package:portfolio/HomePage/IOSStatusBar.dart';
import 'package:portfolio/Widgets/Email.dart';

enum FormStatus { idle, loading, success, failure }

class ContactFormScreen extends StatefulWidget {
  final VoidCallback onClose;
  const ContactFormScreen({super.key, required this.onClose});

  @override
  State<ContactFormScreen> createState() => _ContactFormScreenState();
}

class _ContactFormScreenState extends State<ContactFormScreen>
    with TickerProviderStateMixin {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  FormStatus _status = FormStatus.idle;
  bool _hideForm = false;

  // ---------------- UI HELPERS ----------------

  Widget _label(String text, double scale) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4 * scale),
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14 * scale),
      ),
    );
  }

  Widget _input(
    String hint,
    TextEditingController controller,
    double scale, {
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: TextStyle(fontSize: 14 * scale),
      decoration: InputDecoration(
        hintText: hint,

        hintStyle: TextStyle(fontSize: 14 * scale),
        filled: true,
        fillColor: const Color(0xFFF9F9F9),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16 * scale,
          vertical: 14 * scale,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10 * scale),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10 * scale),
          borderSide: const BorderSide(color: Color(0xFFF4C35A)),
        ),
      ),
    );
  }

  // ---------------- SEND LOGIC ----------------

  Future<void> _onSendPressed() async {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        messageController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
      return;
    }

    setState(() {
      _status = FormStatus.loading;
      _hideForm = true;
    });

    final success = await EmailService.sendEmail(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      subject: "Portfolio",
      message: messageController.text.trim(),
    );

    await Future.delayed(const Duration(milliseconds: 300));

    setState(() {
      _status = success ? FormStatus.success : FormStatus.failure;
    });
  }

  // ---------------- BUTTON ----------------

  Widget _buildSendButton(double scale) {
    return SizedBox(
      width: double.infinity,
      height: 50 * scale,
      child: ElevatedButton(
        onPressed: _status == FormStatus.loading ? null : _onSendPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFF4C35A),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30 * scale),
          ),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: _status == FormStatus.loading
              ? SizedBox(
                  key: const ValueKey("loader"),
                  width: 22 * scale,
                  height: 22 * scale,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: Colors.black,
                  ),
                )
              : Text(
                  "Send Message",
                  key: const ValueKey("text"),
                  style: TextStyle(
                    fontSize: 16 * scale,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
        ),
      ),
    );
  }

  // ---------------- CARD CONTENT ----------------

  Widget _buildCardContent(double scale) {
    if (_status == FormStatus.success || _status == FormStatus.failure) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _status == FormStatus.success ? Icons.check_circle : Icons.error,
            size: 70 * scale,
            color: _status == FormStatus.success ? Colors.green : Colors.red,
          ),
          SizedBox(height: 16 * scale),
          Text(
            _status == FormStatus.success
                ? "Message Sent Successfully"
                : "Failed to Send Message 😕",
            style: TextStyle(fontSize: 18 * scale, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20 * scale),
          TextButton(
            onPressed: widget.onClose,
            child: Text("Back to Home", style: TextStyle(fontSize: 14 * scale)),
          ),
        ],
      );
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              "Send Message",
              style: TextStyle(
                fontSize: 22 * scale,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 8 * scale),
          Center(
            child: Text(
              "Open for opportunities",
              style: TextStyle(
                color: Colors.grey,
                letterSpacing: 1.2,
                fontSize: 12 * scale,
              ),
            ),
          ),
          SizedBox(height: 20 * scale),

          AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: _hideForm ? 0 : 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _label("Name", scale),
                _input("Your Name", nameController, scale),
                SizedBox(height: 14 * scale),

                _label("Email", scale),
                _input("Your Email", emailController, scale),
                SizedBox(height: 14 * scale),

                _label("Message", scale),
                _input(
                  "Write your message",
                  messageController,
                  scale,
                  maxLines: 4,
                ),
              ],
            ),
          ),

          SizedBox(height: 24 * scale),
          _buildSendButton(scale),
          SizedBox(height: 20 * scale),
          Center(
            child: TextButton(
              onPressed: widget.onClose,
              child: Text(
                "Back to Home",
                style: TextStyle(fontSize: 14 * scale),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- BUILD ----------------

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final scale = (screenWidth / 1440).clamp(0.8, 1.25);

    // 🔑 THIS FIXES INPUT RESIZING
    final cardWidth = (520 * scale).clamp(360, screenWidth * 0.9).toDouble();

    return Scaffold(
      backgroundColor: const Color(0xFFF7F4EC),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: 260 * scale,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFF4C35A),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(24 * scale),
                ),
              ),
            ),

            Container(color: Colors.black38, child: const IOSStatusBar()),

            Align(
              alignment: Alignment.center,
              child: AnimatedSize(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: cardWidth),
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 20 * scale,
                      vertical: 30 * scale,
                    ).copyWith(top: 60),
                    padding: EdgeInsets.all(20 * scale),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22 * scale),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 20 * scale,
                          offset: Offset(0, 10 * scale),
                        ),
                      ],
                    ),
                    child: _buildCardContent(scale),
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
