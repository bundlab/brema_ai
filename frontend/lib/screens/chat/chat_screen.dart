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

  final ScrollController _chatScrollController = ScrollController();

  final ApiService _api = ApiService();

  final List<ChatMessage> messages = [];

  bool _loading = false;
  bool _sidebarCollapsed = false;

  static const double _mobileBreakpoint = 700;
  static const double _expandedSidebarWidth = 280;
  static const double _collapsedSidebarWidth = 72;

  Future<void> _send() async {
    final text = _controller.text.trim();

    if (text.isEmpty || _loading) {
      return;
    }

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

    _scrollToLatestMessage();

    try {
      // ApiService.sendMessage returns the assistant response text.
      final String response = await _api.sendMessage(text);

      if (!mounted) return;

      setState(() {
        messages.add(
          ChatMessage(
            message: response,
            isUser: false,
          ),
        );
      });

      _scrollToLatestMessage();
    } catch (error) {
      if (!mounted) return;

      setState(() {
        messages.add(
          const ChatMessage(
            message: 'Sorry, I could not connect to BremaAI. '
                'Please check that the backend is running '
                'and try again.',
            isUser: false,
          ),
        );
      });

      _scrollToLatestMessage();
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });

        _scrollToLatestMessage();
      }
    }
  }

  void _scrollToLatestMessage() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_chatScrollController.hasClients) {
        return;
      }

      _chatScrollController.animateTo(
        _chatScrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
      );
    });
  }

  void _newChat() {
    if (_loading) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please wait for the current response to finish.',
          ),
        ),
      );
      return;
    }

    setState(() {
      messages.clear();
      _controller.clear();
    });

    _closeDrawer();
  }

  void _closeDrawer() {
    _scaffoldKey.currentState?.closeDrawer();
  }

  void _openSettings() {
    _closeDrawer();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Settings are coming soon.'),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _chatScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = constraints.maxWidth < _mobileBreakpoint;

        return Scaffold(
          key: _scaffoldKey,
          drawer: isMobile
              ? Drawer(
                  width: _expandedSidebarWidth,
                  child: SafeArea(
                    child: Sidebar(
                      collapsed: false,
                      onNewChat: _newChat,
                      onSettings: _openSettings,
                      onNavigate: _closeDrawer,
                    ),
                  ),
                )
              : null,
          appBar: AppBar(
            leading: isMobile
                ? IconButton(
                    tooltip: 'Open navigation',
                    icon: const Icon(Icons.menu_rounded),
                    onPressed: () {
                      _scaffoldKey.currentState?.openDrawer();
                    },
                  )
                : IconButton(
                    tooltip: _sidebarCollapsed
                        ? 'Expand sidebar'
                        : 'Collapse sidebar',
                    icon: Icon(
                      _sidebarCollapsed
                          ? Icons.menu_open_rounded
                          : Icons.menu_rounded,
                    ),
                    onPressed: () {
                      setState(() {
                        _sidebarCollapsed = !_sidebarCollapsed;
                      });
                    },
                  ),
            title: const Text(
              'BremaAI',
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
            centerTitle: false,
          ),
          body: Row(
            children: [
              if (!isMobile)
                SizedBox(
                  width: _sidebarCollapsed
                      ? _collapsedSidebarWidth
                      : _expandedSidebarWidth,
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
                      child: ChatArea(
                        messages: messages,
                        scrollController: _chatScrollController,
                        isLoading: _loading,
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
