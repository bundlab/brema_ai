import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  final bool collapsed;
  final VoidCallback? onNewChat;
  final VoidCallback? onSettings;
  final VoidCallback? onNavigate;

  const Sidebar({
    super.key,
    this.collapsed = false,
    this.onNewChat,
    this.onSettings,
    this.onNavigate,
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
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _SidebarItem(
                    icon: Icons.chat_bubble_outline,
                    label: 'Welcome',
                    collapsed: collapsed,
                    onTap: onNavigate,
                  ),
                  _SidebarItem(
                    icon: Icons.chat_bubble_outline,
                    label: 'AI Assistant',
                    collapsed: collapsed,
                    onTap: onNavigate,
                  ),
                  _SidebarItem(
                    icon: Icons.chat_bubble_outline,
                    label: 'New Conversation',
                    collapsed: collapsed,
                    onTap: onNavigate,
                  ),
                ],
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
  final VoidCallback? onTap;

  const _SidebarItem({
    required this.icon,
    required this.label,
    required this.collapsed,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: collapsed ? label : '',
      child: Material(
        color: Colors.transparent,
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
                    color: _SidebarItemColor.accent,
                  ),
                  if (!collapsed) ...[
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
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

class _SidebarItemColor {
  static const Color accent = Color(0xFF19C5E6);
}
