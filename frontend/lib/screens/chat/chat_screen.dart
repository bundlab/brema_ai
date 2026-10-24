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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _controller = TextEditingController();
  final List<ChatMessage> messages = [];
  final ApiService _api = ApiService();

  bool _loading = false;
  bool _sidebarCollapsed = false;

  static const double _mobileBreakpoint = 700;
  static const double _sidebarWidth = 280;
  static const double _collapsedSidebarWidth = 72;

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
        ChatMessage(message: text, isUser: true),
      );
      _loading = true;
    });

    try {
      final answer = await _api.sendMessage(text);

      if (!mounted) return;

      setState(() {
        messages.add(
          ChatMessage(message: answer, isUser: false),
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
        setState(() => _loading = false);
      }
    }
  }

  void _newChat() {
    setState(() {
      messages.clear();
      _loading = false;
      _controller.clear();
    });
  }

  void _openSettings() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Settings will be available soon.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < _mobileBreakpoint;

        return Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 70,
            elevation: 0,
            titleSpacing: 12,
            leading: isMobile
                ? IconButton(
                    tooltip: 'Open navigation',
                    icon: const Icon(Icons.menu),
                    onPressed: () {
                      _scaffoldKey.currentState?.openDrawer();
                    },
                  )
                : IconButton(
                    tooltip: _sidebarCollapsed
                        ? 'Expand sidebar'
                        : 'Collapse sidebar',
                    icon: Icon(
                      _sidebarCollapsed ? Icons.menu : Icons.menu_open,
                    ),
                    onPressed: () {
                      setState(() {
                        _sidebarCollapsed = !_sidebarCollapsed;
                      });
                    },
                  ),
            title: const Row(
              children: [
                Icon(
                  Icons.auto_awesome,
                  color: Color(0xFF19C5E6),
                ),
                SizedBox(width: 10),
                Flexible(
                  child: Text(
                    'BremaAI',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              IconButton(
                tooltip: 'Search',
                icon: const Icon(Icons.search),
                onPressed: () {},
              ),
              IconButton(
                tooltip: 'Settings',
                icon: const Icon(Icons.settings_outlined),
                onPressed: _openSettings,
              ),
              const Padding(
                padding: EdgeInsets.only(right: 12, left: 4),
                child: CircleAvatar(
                  radius: 18,
                  child: Icon(Icons.person),
                ),
              ),
            ],
          ),
          drawer: isMobile
              ? Drawer(
                  width: 280,
                  child: Sidebar(
                    collapsed: false,
                    onNewChat: _newChat,
                    onSettings: _openSettings,
                    onNavigate: () {
                      Navigator.of(context).pop();
                    },
                  ),
                )
              : null,
          body: Row(
            children: [
              if (!isMobile)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeInOut,
                  width: _sidebarCollapsed
                      ? _collapsedSidebarWidth
                      : _sidebarWidth,
                  child: Sidebar(
                    collapsed: _sidebarCollapsed,
                    onNewChat: _newChat,
                    onSettings: _openSettings,
                  ),
                ),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: ChatArea(messages: messages),
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
      },
    );
  }
}
