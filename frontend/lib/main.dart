import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/chat/chat_screen.dart';

void main() {
  runApp(const BremaAI());
}

class BremaAI extends StatelessWidget {
  const BremaAI({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BremaAI',
      theme: AppTheme.darkTheme,
      home: const ChatScreen(),
    );
  }
}
