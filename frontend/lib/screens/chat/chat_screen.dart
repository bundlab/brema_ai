import 'package:flutter/material.dart';

import '../../models/chat_message.dart';
import '../../models/conversation.dart';
import '../../services/api_service.dart';
import '../../services/conversation_storage_service.dart';
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
  final ConversationStorageService _storage = ConversationStorageService();

  final List<Conversation> _conversations = [];

  String? _selectedConversationId;
  bool _loading = false;
  bool _historyLoading = true;
  bool _sidebarCollapsed = false;

  static const double _mobileBreakpoint = 700;
  static const double _expandedSidebarWidth = 280;
  static const double _collapsedSidebarWidth = 72;

  List<ChatMessage> get messages {
    for (final conversation in _conversations) {
      if (conversation.id == _selectedConversationId) {
        return conversation.messages;
      }
    }

    return const [];
  }

  Conversation? get _selectedConversation {
    for (final conversation in _conversations) {
      if (conversation.id == _selectedConversationId) {
        return conversation;
      }
    }

    return null;
  }

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    try {
      final saved = await _storage.loadConversations();

      if (!mounted) return;

      setState(() {
        _conversations
          ..clear()
          ..addAll(saved);

        _selectedConversationId = saved.isNotEmpty ? saved.first.id : null;

        _historyLoading = false;
      });
    } catch (error) {
      if (!mounted) return;

      setState(() {
        _historyLoading = false;
      });

      _showMessage('Could not load saved conversation history.');
    }
  }

  Future<void> _saveHistory() async {
    try {
      await _storage.saveConversations(_conversations);
    } catch (error) {
      if (!mounted) return;

      _showMessage(
        'Your conversation is visible, but could not be saved locally.',
      );
    }
  }

  void _showMessage(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  String _createConversationId() {
    return DateTime.now().microsecondsSinceEpoch.toString();
  }

  String _titleFromMessage(String message) {
    final singleLine = message.replaceAll(RegExp(r'\s+'), ' ').trim();

    if (singleLine.length <= 32) {
      return singleLine.isEmpty ? 'New Chat' : singleLine;
    }

    return '${singleLine.substring(0, 32)}…';
  }

  Future<void> _send() async {
    final text = _controller.text.trim();

    if (text.isEmpty || _loading || _historyLoading) {
      return;
    }

    _controller.clear();

    // Create or retrieve the conversation before setState.
    final conversation = _selectedConversation ??
        Conversation(
          id: _createConversationId(),
          title: _titleFromMessage(text),
          messages: [],
          updatedAt: DateTime.now(),
        );

    setState(() {
      if (!_conversations.any((item) => item.id == conversation.id)) {
        _conversations.insert(0, conversation);
      }

      _selectedConversationId = conversation.id;

      conversation.messages.add(
        ChatMessage(
          message: text,
          isUser: true,
        ),
      );

      conversation.updatedAt = DateTime.now();
      _sortConversations();
      _loading = true;
    });

    _scrollToLatestMessage();
    await _saveHistory();

    try {
      final response = await _api.sendMessage(text);

      if (!mounted) return;

      setState(() {
        conversation.messages.add(
          ChatMessage(
            message: response,
            isUser: false,
          ),
        );

        conversation.updatedAt = DateTime.now();
        _sortConversations();
      });

      await _saveHistory();
      _scrollToLatestMessage();
    } catch (error) {
      if (!mounted) return;

      setState(() {
        conversation.messages.add(
          const ChatMessage(
            message: 'Sorry, I could not connect to BremaAI. '
                'Please check that the backend is running '
                'and try again.',
            isUser: false,
          ),
        );

        conversation.updatedAt = DateTime.now();
        _sortConversations();
      });

      await _saveHistory();
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

  void _sortConversations() {
    _conversations.sort(
      (a, b) => b.updatedAt.compareTo(a.updatedAt),
    );
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
    if (_loading || _historyLoading) {
      _showMessage('Please wait until the current operation finishes.');
      return;
    }

    setState(() {
      _selectedConversationId = null;
      _controller.clear();
    });

    _closeDrawer();
  }

  void _selectConversation(String id) {
    if (_loading) {
      _showMessage('Please wait for the current response to finish.');
      return;
    }

    final exists = _conversations.any(
      (conversation) => conversation.id == id,
    );

    if (!exists) return;

    setState(() {
      _selectedConversationId = id;
      _controller.clear();
    });

    _scrollToLatestMessage();
  }

  void _closeDrawer() {
    _scaffoldKey.currentState?.closeDrawer();
  }

  void _openSettings() {
    _closeDrawer();
    _showMessage('Settings are coming soon.');
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
        final isMobile = constraints.maxWidth < _mobileBreakpoint;

        return Scaffold(
          key: _scaffoldKey,
          drawer: isMobile
              ? Drawer(
                  width: _expandedSidebarWidth,
                  child: SafeArea(
                    child: Sidebar(
                      collapsed: false,
                      conversations: _conversations,
                      selectedConversationId: _selectedConversationId,
                      onNewChat: _newChat,
                      onSettings: _openSettings,
                      onNavigate: _closeDrawer,
                      onSelectConversation: _selectConversation,
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
              style: TextStyle(fontWeight: FontWeight.w700),
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
                    conversations: _conversations,
                    selectedConversationId: _selectedConversationId,
                    onNewChat: _newChat,
                    onSettings: _openSettings,
                    onSelectConversation: _selectConversation,
                  ),
                ),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: _historyLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : ChatArea(
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
