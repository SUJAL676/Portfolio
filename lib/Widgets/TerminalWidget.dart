import 'dart:async';
import 'package:flutter/material.dart';

class TerminalCard extends StatefulWidget {
  const TerminalCard({super.key});

  @override
  State<TerminalCard> createState() => _TerminalCardState();
}

class _TerminalCardState extends State<TerminalCard> {
  final List<_TerminalLine> _lines = const [
    _TerminalLine(r'$ find / name "life.dart"', Colors.white),
    _TerminalLine('> Searching ...', Color(0xff9FE870)),
    _TerminalLine('> Error: No life is found!', Color(0xffFF6B6B)),
    _TerminalLine(
      '> Since you are a programmer, you have no life!',
      Color(0xffFF6B6B),
    ),
  ];

  int _currentLine = 0;
  int _currentChar = 0;
  bool _startTyping = false;

  Timer? _typingTimer;

  @override
  void initState() {
    super.initState();

    /// ⏳ Wait 30 seconds before starting animation
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      setState(() => _startTyping = true);
      _startTypingAnimation();
    });
  }

  void _startTypingAnimation() {
    _typingTimer = Timer.periodic(const Duration(milliseconds: 45), (timer) {
      if (!mounted) return;

      // All lines typed → stop
      if (_currentLine >= _lines.length) {
        timer.cancel();
        return;
      }

      final currentText = _lines[_currentLine].text;

      setState(() {
        if (_currentChar < currentText.length) {
          _currentChar++;
        } else {
          // Line finished → move to next
          _currentLine++;
          _currentChar = 0;
        }
      });
    });
  }

  @override
  void dispose() {
    _typingTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 420,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 25,
            offset: const Offset(0, 18),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // macOS dots
          Row(
            children: const [
              _Dot(color: Color(0xffFF5F56)),
              SizedBox(width: 6),
              _Dot(color: Color(0xffFFBD2E)),
              SizedBox(width: 6),
              _Dot(color: Color(0xff27C93F)),
            ],
          ),

          const SizedBox(height: 16),

          // 👇 Waiting text MUST stay until typing starts
          if (!_startTyping)
            _terminalText(
              'Waiting for user interaction...',
              const Color(0xff9FE870),
            ),

          // Typed lines
          for (int i = 0; i < _currentLine && i < _lines.length; i++)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: _terminalText(_lines[i].text, _lines[i].color),
            ),

          // Current typing line
          if (_startTyping && _currentLine < _lines.length)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: _terminalText(
                _lines[_currentLine].text.substring(
                  0,
                  _currentChar.clamp(0, _lines[_currentLine].text.length),
                ),
                _lines[_currentLine].color,
              ),
            ),
        ],
      ),
    );
  }

  Widget _terminalText(String text, Color color) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Courier',
        fontSize: 16,
        color: color,
        height: 1.4,
      ),
    );
  }
}

class _TerminalLine {
  final String text;
  final Color color;
  const _TerminalLine(this.text, this.color);
}

class _Dot extends StatelessWidget {
  final Color color;
  const _Dot({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 12,
      width: 12,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
