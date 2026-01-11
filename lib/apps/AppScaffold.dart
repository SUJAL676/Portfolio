import 'package:flutter/material.dart';

class IOSAppScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final VoidCallback onClose;

  const IOSAppScaffold({
    super.key,
    required this.title,
    required this.body,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // iOS-style top bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: onClose,
                    child: const Icon(Icons.chevron_left),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),

            Expanded(child: body),
          ],
        ),
      ),
    );
  }
}
