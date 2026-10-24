import 'package:flutter/material.dart';

import '../models/chat_message.dart';
import '../theme/app_colors.dart';
import 'chat_bubble.dart';

class ChatArea extends StatelessWidget {
  final List<ChatMessage> messages;

  const ChatArea({
    super.key,
    required this.messages,
  });

  @override
  Widget build(BuildContext context) {
    if (messages.isEmpty) {
      return const _WelcomeScreen();
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 8,
      ),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        return ChatBubble(
          key: ValueKey(
            '${messages[index].isUser}-$index',
          ),
          message: messages[index],
        );
      },
    );
  }
}

class _WelcomeScreen extends StatelessWidget {
  const _WelcomeScreen();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 620),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 76,
                height: 76,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.25),
                  ),
                ),
                child: const Icon(
                  Icons.auto_awesome_rounded,
                  size: 38,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Welcome to BremaAI',
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.8,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Your AI assistant for ideas, learning, coding, '
                'and everyday questions.',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge?.copyWith(
                  height: 1.6,
                  color: colors.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 28),
              const Wrap(
                alignment: WrapAlignment.center,
                spacing: 10,
                runSpacing: 10,
                children: [
                  _SuggestionChip(
                    icon: Icons.code_rounded,
                    label: 'Help me write code',
                  ),
                  _SuggestionChip(
                    icon: Icons.lightbulb_outline_rounded,
                    label: 'Explain a concept',
                  ),
                  _SuggestionChip(
                    icon: Icons.edit_note_rounded,
                    label: 'Improve my writing',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SuggestionChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _SuggestionChip({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 11,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: theme.dividerColor.withValues(alpha: 0.5),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 17,
            color: AppColors.primary,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: theme.textTheme.labelMedium,
          ),
        ],
      ),
    );
  }
}

