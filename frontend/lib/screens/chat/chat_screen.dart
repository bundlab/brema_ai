
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
  final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();

  final TextEditingController _controller =
      TextEditingController();

  final ScrollController _chatScrollController =
      ScrollController();

  final ApiService _api = ApiService();

  final ConversationStorageService _storage =
      ConversationStorageService();

  final List<Conversation> _conversations = [];

  String? _selectedConversationId;
  String _searchQuery = '';

  bool _loading = false;
  bool _historyLoading = true;
  bool _sidebarCollapsed = false;

  static const double _mobileBreakpoint = 700;
  static const double _expandedSidebarWidth = 280;
  static const double _collapsedSidebarWidth = 72;

  List<ChatMessage> get messages {
    return _selectedConversation?.messages ?? const [];
  }

  Conversation? get _selectedConversation {
    for (final conversation in _conversations) {
      if (conversation.id == _selectedConversationId) {
        return conversation;
      }
    }

    return null;
  }

  List<Conversation> get _filteredConversations {
    final query = _searchQuery.trim().toLowerCase();

    if (query.isEmpty) {
      return _conversations;
    }

    return _conversations.where((conversation) {
      final titleMatches =
          conversation.title.toLowerCase().contains(query);

      final messageMatches = conversation.messages.any(
        (message) => message.message.toLowerCase().contains(query),
      );

      return titleMatches || messageMatches;
    }).toList();
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

        _selectedConversationId =
            saved.isNotEmpty ? saved.first.id : null;

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
    final singleLine =
        message.replaceAll(RegExp(r'\s+'), ' ').trim();

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

    final conversation = _selectedConversation ??
        Conversation(
          id: _createConversationId(),
          title: _titleFromMessage(text),
          messages: [],
          updatedAt: DateTime.now(),
        );
        
    // Preserve the previous messages before adding the new prompt.
    final history = List<ChatMessage>.from(
      conversation.messages,
    );

    setState(() {
      if (!_conversations.any(
        (item) => item.id == conversation.id,
      )) {
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
      final response = await _api.sendMessage(
        text,
        history: history,
      );

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
      _showMessage(
        'Please wait until the current operation finishes.',
      );
      return;
    }

    setState(() {
      _selectedConversationId = null;
      _controller.clear();
      _searchQuery = '';
    });

    _closeDrawer();
  }

  void _selectConversation(String id) {
    if (_loading) {
      _showMessage(
        'Please wait for the current response to finish.',
      );
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

  void _searchConversations(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  Future<void> _renameConversation(
    Conversation conversation,
  ) async {
    if (_loading) {
      _showMessage(
        'Please wait for the current response to finish.',
      );
      return;
    }

    final controller = TextEditingController(
      text: conversation.title,
    );

    try {
      final newTitle = await showDialog<String>(
        context: context,
        builder: (dialogContext) {
          return AlertDialog(
            title: const Text('Rename conversation'),
            content: TextField(
              controller: controller,
              autofocus: true,
              maxLength: 60,
              decoration: const InputDecoration(
                labelText: 'Conversation name',
                hintText: 'Enter a new name',
              ),
              onSubmitted: (value) {
                Navigator.pop(dialogContext, value.trim());
              },
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(dialogContext);
                },
                child: const Text('Cancel'),
              ),
              FilledButton(
                onPressed: () {
                  Navigator.pop(
                    dialogContext,
                    controller.text.trim(),
                  );
                },
                child: const Text('Save'),
              ),
            ],
          );
        },
      );

      if (!mounted || newTitle == null) return;

      if (newTitle.isEmpty) {
        _showMessage('Conversation name cannot be empty.');
        return;
      }

      setState(() {
        conversation.title = newTitle;
        conversation.updatedAt = DateTime.now();
        _sortConversations();
      });

      await _saveHistory();

      if (mounted) {
        _showMessage('Conversation renamed successfully.');
      }
    } finally {
      controller.dispose();
    }
  }

  Future<void> _deleteConversation(
    Conversation conversation,
  ) async {
    if (_loading) {
      _showMessage(
        'Please wait for the current response to finish.',
      );
      return;
    }

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Delete conversation?'),
          content: Text(
            'Are you sure you want to delete '
            '"${conversation.title}"? This action cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: const Text('Cancel'),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (!mounted || confirmed != true) return;

    setState(() {
      final wasSelected =
          _selectedConversationId == conversation.id;

      _conversations.removeWhere(
        (item) => item.id == conversation.id,
      );

      if (wasSelected) {
        _selectedConversationId =
            _conversations.isNotEmpty
                ? _conversations.first.id
                : null;
      }
    });

    await _saveHistory();

    if (mounted) {
      _showMessage('Conversation deleted.');
    }
  }

  void _closeDrawer() {
    _scaffoldKey.currentState?.closeDrawer();
  }

  void _openSettings() {
    _closeDrawer();
    _showMessage('Settings are coming soon.');
  }

  Widget _buildSidebar({required bool collapsed}) {
    return Sidebar(
      collapsed: collapsed,
      conversations: _filteredConversations,
      selectedConversationId: _selectedConversationId,
      searchQuery: _searchQuery,
      onNewChat: _newChat,
      onSettings: _openSettings,
      onNavigate: _closeDrawer,
      onSearchChanged: _searchConversations,
      onSelectConversation: _selectConversation,
      onRenameConversation: _renameConversation,
      onDeleteConversation: _deleteConversation,
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
        final isMobile =
            constraints.maxWidth < _mobileBreakpoint;

        return Scaffold(
          key: _scaffoldKey,
          drawer: isMobile
              ? Drawer(
                  width: _expandedSidebarWidth,
                  child: _buildSidebar(collapsed: false),
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
                  child: _buildSidebar(
                    collapsed: _sidebarCollapsed,
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
                              scrollController:
                                  _chatScrollController,
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
