import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../models/chat_message.dart';

class ChatBubble extends StatelessWidget {
  final ChatMessage message;

  const ChatBubble({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      color: message.isUser
          ? Colors.blueGrey.withValues(alpha: 0.20)
          : Colors.transparent,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            message.isUser
                ? Icons.person
                : Icons.auto_awesome,
            color: message.isUser
                ? Colors.blue
                : Colors.cyan,
          ),

          const SizedBox(width: 12),

          Expanded(
            child: MarkdownBody(
              data: message.message,
              styleSheet: MarkdownStyleSheet(
                p: const TextStyle(
                  fontSize: 18,
                ),

                codeblockDecoration: BoxDecoration(
                  color: const Color(0xff1E1E1E),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.white10,
                  ),
                ),

                code: const TextStyle(
                  fontSize: 17,
                  fontFamily: "monospace",
                  color: Colors.cyanAccent,
                  backgroundColor: Colors.transparent,
                ),

                codeblockPadding:
                    const EdgeInsets.all(16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}