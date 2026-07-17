import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

void main() => runApp(const BremaAI());

class BremaAI extends StatelessWidget {
  const BremaAI({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true).copyWith(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan, brightness: Brightness.dark),
      ),
      home: const ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();
  
  // IMPORTANT: Ensure there are no spaces inside the quotes
  static const _apiKey = 'PUT_YOUR_KEY_HERE'; 
  
  late final GenerativeModel _model;
  late final ChatSession _chat;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    // CHANGED TO GEMINI-2.0-FLASH FOR 2026 STABILITY
    _model = GenerativeModel(
      model: 'gemini-2.5-flash-lite', 
      apiKey: _apiKey,
    );
    _chat = _model.startChat();
  }

  void _send() async {
    if (_controller.text.isEmpty) return;
    final text = _controller.text;
    _controller.clear();
    setState(() => _loading = true);

    try {
      // Multi-turn memory enabled here
      await _chat.sendMessage(Content.text(text));
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), duration: const Duration(seconds: 5))
        );
      }
    } finally {
      if (mounted) {
        setState(() => _loading = false);
        _scroll();
      }
    }
  }

  void _scroll() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Brema AI'), centerTitle: true),
      body: Column(
        children: [
          Expanded(
           child: SelectionArea(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _chat.history.length,
              itemBuilder: (context, i) {
                final msg = _chat.history.toList()[i];
                final text = msg.parts.whereType<TextPart>().map((e) => e.text).join();
                
                return Container(
                  padding: const EdgeInsets.all(16),
                  color: msg.role == 'user' ? Colors.blueGrey.withOpacity(0.2) : Colors.transparent,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(msg.role == 'user' ? Icons.person : Icons.auto_awesome, 
                           color: msg.role == 'user' ? Colors.blue : Colors.cyan),
                      const SizedBox(width: 12),
                      Expanded(
                        child: MarkdownBody(
                          data: text,
                          // FONT SIZE 18 AS REQUESTED
                          styleSheet: MarkdownStyleSheet(
                            // 1. MAIN TEXT SIZE (Size 18 as you liked)
                            p: const TextStyle(fontSize: 18),
                            // 2. CODE BLOCK STYLE (The beauty part)
                            codeblockDecoration: BoxDecoration(
                              color: const Color(0xFF1E1E1E), // Professional VS Code grey
                              borderRadius: BorderRadius.circular(12), // Smooth rounded corners
                              border: Border.all(color: Colors.white10), // Subtle border
                            ),
                            // 3. CODE FONT SIZE & COLOR
                            code: const TextStyle(
                              fontSize: 17, 
                              fontFamily: 'monospace', // Makes code look like code
                              color: Colors.cyanAccent, // Professional code color
                              backgroundColor: Colors.transparent, // Fixes double background issue
                            ),
                            // 4. SPACING AROUND CODE
                            codeblockPadding: const EdgeInsets.all(16),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
           ),
          ),
          if (_loading) const LinearProgressIndicator(),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    style: const TextStyle(fontSize: 18),
                    onSubmitted: (_) => _send(),
                    decoration: const InputDecoration(
                      hintText: 'Ask Brema AI...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: _send,
                  icon: const Icon(Icons.send, color: Colors.cyan),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
