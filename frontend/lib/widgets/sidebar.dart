import 'package:flutter/material.dart';

import '../models/conversation.dart';

class Sidebar extends StatelessWidget {
  final bool collapsed;
  final List<Conversation> conversations;
  final String? selectedConversationId;
  final VoidCallback? onNewChat;
  final VoidCallback? onSettings;
  final VoidCallback? onNavigate;
  final ValueChanged<String>? onSelectConversation;

  const Sidebar({
    super.key,
    this.collapsed = false,
    this.conversations = const [],
    this.selectedConversationId,
    this.onNewChat,
    this.onSettings,
    this.onNavigate,
    this.onSelectConversation,
  });

  static const Color _background = Color(0xFF1B1C1F);
  static const Color _accent = Color(0xFF19C5E6);

  @override
  Widget build(BuildContext context) {
    final showLabels = !collapsed;

    return ColoredBox(
      color: _background,
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(collapsed ? 8 : 16),
              child: SizedBox(
                width: double.infinity,
                height: 40,
                child: Tooltip(
                  message: 'New Chat',
                  child: FilledButton(
                    onPressed: onNewChat,
                    style: FilledButton.styleFrom(
                      padding: EdgeInsets.zero,
                      backgroundColor: _accent,
                      foregroundColor: Colors.black,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: showLabels
                        ? const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add, size: 20),
                              SizedBox(width: 8),
                              Flexible(
                                child: Text(
                                  'New Chat',
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          )
                        : const Icon(Icons.add),
                  ),
                ),
              ),
            ),
            const Divider(height: 1),
            if (showLabels)
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 20, 16, 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Recent Chats',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white70,
                    ),
                  ),
                ),
              )
            else
              const SizedBox(height: 12),
            Expanded(
              child: conversations.isEmpty
                  ? (showLabels
                      ? const Center(
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Text(
                              'Your conversations will appear here.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        )
                      : const SizedBox.shrink())
                  : ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: conversations.length,
                      itemBuilder: (context, index) {
                        final conversation = conversations[index];

                        return _SidebarItem(
                          icon: Icons.chat_bubble_outline,
                          label: conversation.title,
                          collapsed: collapsed,
                          selected: conversation.id == selectedConversationId,
                          onTap: () {
                            onSelectConversation?.call(conversation.id);
                            onNavigate?.call();
                          },
                        );
                      },
                    ),
            ),
            const Divider(height: 1),
            _SidebarItem(
              icon: Icons.settings,
              label: 'Settings',
              collapsed: collapsed,
              onTap: () {
                onSettings?.call();
                onNavigate?.call();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool collapsed;
  final bool selected;
  final VoidCallback? onTap;

  const _SidebarItem({
    required this.icon,
    required this.label,
    required this.collapsed,
    this.selected = false,
    this.onTap,
  });

  static const Color _accent = Color(0xFF19C5E6);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: collapsed ? label : '',
      child: Material(
        color: selected ? _accent.withValues(alpha: 0.14) : Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: SizedBox(
            height: 48,
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: collapsed ? 0 : 16,
              ),
              child: Row(
                mainAxisAlignment: collapsed
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.start,
                children: [
                  Icon(
                    icon,
                    size: 22,
                    color: selected ? _accent : Colors.white70,
                  ),
                  if (!collapsed) ...[
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: selected ? _accent : Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
