
import 'package:flutter/material.dart';

import '../../models/chat_message.dart';
import '../../services/api_service.dart';
import '../../widgets/chat_area.dart';
import '../../widgets/message_input.dart';
import '../../widgets/sidebar.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<ChatMessage> messages = [];
  final ApiService _api = ApiService();

  bool _loading = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    final text = _controller.text.trim();

    if (text.isEmpty || _loading) return;

    _controller.clear();

    setState(() {
      messages.add(
        ChatMessage(
          message: text,
          isUser: true,
        ),
      );
      _loading = true;
    });

    try {
      final answer = await _api.sendMessage(text);

      if (!mounted) return;

      setState(() {
        messages.add(
          ChatMessage(
            message: answer,
            isUser: false,
          ),
        );
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        messages.add(
          ChatMessage(
            message: '⚠️ $e',
            isUser: false,
          ),
        );
      });
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 70,
        elevation: 0,
        titleSpacing: 20,
        title: const Row(
          children: [
            Icon(
              Icons.auto_awesome,
              color: Color(0xFF19C5E6),
            ),
            SizedBox(width: 12),
            Text(
              'BremaAI',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.5,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {},
          ),
          const Padding(
            padding: EdgeInsets.only(
              right: 20,
              left: 10,
            ),
            child: CircleAvatar(
              radius: 18,
              child: Icon(Icons.person),
            ),
          ),
        ],
      ),
      body: Row(
        children: [
          const Sidebar(),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: ChatArea(
                    messages: messages,
                  ),
                ),
                if (_loading)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text('BremaAI is thinking...'),
                      ],
                    ),
                  ),
                MessageInput(
                  controller: _controller,
                  onSend: _send,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
