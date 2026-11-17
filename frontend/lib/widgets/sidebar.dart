
import 'package:flutter/material.dart';

import '../models/conversation.dart';

class Sidebar extends StatelessWidget {
  final bool collapsed;
  final List<Conversation> conversations;
  final String? selectedConversationId;
  final String searchQuery;

  final VoidCallback? onNewChat;
  final VoidCallback? onSettings;
  final VoidCallback? onNavigate;

  final ValueChanged<String>? onSearchChanged;
  final ValueChanged<String>? onSelectConversation;
  final ValueChanged<Conversation>? onRenameConversation;
  final ValueChanged<Conversation>? onDeleteConversation;

  const Sidebar({
    super.key,
    this.collapsed = false,
    this.conversations = const [],
    this.selectedConversationId,
    this.searchQuery = '',
    this.onNewChat,
    this.onSettings,
    this.onNavigate,
    this.onSearchChanged,
    this.onSelectConversation,
    this.onRenameConversation,
    this.onDeleteConversation,
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

            if (showLabels) ...[
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
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                child: TextField(
                  onChanged: onSearchChanged,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Search conversations',
                    hintStyle: const TextStyle(
                      color: Colors.white54,
                      fontSize: 13,
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.white54,
                      size: 20,
                    ),
                    filled: true,
                    fillColor: const Color(0xFF292A2E),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ] else
              const SizedBox(height: 12),

            Expanded(
              child: conversations.isEmpty
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          searchQuery.isNotEmpty
                              ? 'No matching conversations.'
                              : 'Your conversations will appear here.',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white54,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: conversations.length,
                      itemBuilder: (context, index) {
                        final conversation = conversations[index];

                        return Row(
                          children: [
                            Expanded(
                              child: _SidebarItem(
                                icon: Icons.chat_bubble_outline,
                                label: conversation.title,
                                collapsed: collapsed,
                                selected: conversation.id ==
                                    selectedConversationId,
                                onTap: () {
                                  onSelectConversation?.call(
                                    conversation.id,
                                  );
                                  onNavigate?.call();
                                },
                              ),
                            ),

                            if (showLabels)
                              PopupMenuButton<String>(
                                tooltip: 'Conversation options',
                                icon: const Icon(
                                  Icons.more_horiz,
                                  color: Colors.white54,
                                  size: 20,
                                ),
                                color: const Color(0xFF292A2E),
                                onSelected: (value) {
                                  if (value == 'rename') {
                                    onRenameConversation?.call(
                                      conversation,
                                    );
                                  } else if (value == 'delete') {
                                    onDeleteConversation?.call(
                                      conversation,
                                    );
                                  }
                                },
                                itemBuilder: (context) => [
                                  const PopupMenuItem(
                                    value: 'rename',
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.edit_outlined,
                                          size: 18,
                                          color: Colors.white70,
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          'Rename',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const PopupMenuItem(
                                    value: 'delete',
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.delete_outline,
                                          size: 18,
                                          color: Colors.redAccent,
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          'Delete',
                                          style: TextStyle(
                                            color: Colors.redAccent,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                          ],
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
        color: selected
            ? _accent.withValues(alpha: 0.14)
            : Colors.transparent,
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
