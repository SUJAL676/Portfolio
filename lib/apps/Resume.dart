import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class ResumeApp extends StatefulWidget {
  final VoidCallback onClose;

  const ResumeApp({Key? key, required this.onClose}) : super(key: key);

  @override
  State<ResumeApp> createState() => _ResumeAppState();
}

class _ResumeAppState extends State<ResumeApp> {
  late PdfControllerPinch _pdfController;

  @override
  void initState() {
    super.initState();

    _pdfController = PdfControllerPinch(
      document: PdfDocument.openAsset('assets/resume/Sujal Resume SD.pdf'),
    );
  }

  @override
  void dispose() {
    _pdfController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      // iOS-style AppBar
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 18),
          onPressed: widget.onClose,
        ),
        title: const Text(
          "Resume",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),

      // FULL SCREEN PDF
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SizedBox(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              child: PdfViewPinch(
                controller: _pdfController,

                // 👇 Important flags
                padding: 0,
                backgroundDecoration: const BoxDecoration(color: Colors.black),
              ),
            );
          },
        ),
      ),
    );
  }
}
