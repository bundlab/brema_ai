import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../models/chat_message.dart';
import '../theme/app_colors.dart';

class ChatBubble extends StatelessWidget {
  final ChatMessage message;

  const ChatBubble({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final isUser = message.isUser;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 12,
      ),
      child: Align(
        alignment: isUser
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.sizeOf(context).width * 0.78,
          ),
          child: Column(
            crossAxisAlignment: isUser
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 15,
                    backgroundColor: isUser
                        ? colorScheme.secondaryContainer
                        : AppColors.primary.withValues(alpha: 0.15),
                    child: Icon(
                      isUser
                          ? Icons.person_outline
                          : Icons.auto_awesome,
                      size: 18,
                      color: isUser
                          ? colorScheme.onSecondaryContainer
                          : AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: 9),
                  Text(
                    isUser ? 'You' : 'BremaAI',
                    style: theme.textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 9),
              Container(
                width: isUser ? null : double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 13,
                ),
                decoration: BoxDecoration(
                  color: isUser
                      ? AppColors.primary.withValues(alpha: 0.13)
                      : theme.colorScheme.surfaceContainerLow,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(18),
                    topRight: const Radius.circular(18),
                    bottomLeft: Radius.circular(isUser ? 18 : 5),
                    bottomRight: Radius.circular(isUser ? 5 : 18),
                  ),
                  border: Border.all(
                    color: isUser
                        ? AppColors.primary.withValues(alpha: 0.20)
                        : theme.dividerColor.withValues(alpha: 0.35),
                  ),
                ),
                child: isUser
                    ? SelectableText(
                        message.message,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          height: 1.55,
                          color: theme.colorScheme.onSurface,
                        ),
                      )
                    : MarkdownBody(
                        data: message.message,
                        selectable: true,
                        softLineBreak: true,
                        styleSheet: MarkdownStyleSheet(
                          p: theme.textTheme.bodyLarge?.copyWith(
                            height: 1.65,
                            color: theme.colorScheme.onSurface,
                          ),
                          h1: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          h2: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          h3: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          strong: const TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                          em: const TextStyle(
                            fontStyle: FontStyle.italic,
                          ),
                          listBullet: const TextStyle(
                            color: AppColors.primary,
                            fontSize: 16,
                          ),
                          a: const TextStyle(
                            color: AppColors.primary,
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.primary,
                          ),
                          blockquote: TextStyle(
                            color: theme.colorScheme.onSurfaceVariant,
                            height: 1.5,
                          ),
                          blockquoteDecoration: const BoxDecoration(
                            border: Border(
                              left: BorderSide(
                                color: AppColors.primary,
                                width: 3,
                              ),
                            ),
                          ),
                          blockquotePadding: const EdgeInsets.only(
                            left: 12,
                            top: 4,
                            bottom: 4,
                          ),
                          code: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 13,
                            color: AppColors.primary,
                            backgroundColor: theme
                                .colorScheme
                                .surfaceContainerHighest,
                          ),
                          codeblockDecoration: BoxDecoration(
                            color: const Color(0xFF101820),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: AppColors.border,
                            ),
                          ),
                          codeblockPadding: const EdgeInsets.all(14),
                          horizontalRuleDecoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                color: theme.dividerColor,
                              ),
                            ),
                          ),
                          tableHead: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          tableBorder: TableBorder.all(
                            color: theme.dividerColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          tableCellsPadding: const EdgeInsets.all(8),
                          tableColumnWidth: const FlexColumnWidth(),
                        ),
                      ),
              ),
              if (!isUser)
                Padding(
                  padding: const EdgeInsets.only(top: 5, left: 4),
                  child: IconButton(
                    tooltip: 'Copy response',
                    visualDensity: VisualDensity.compact,
                    iconSize: 17,
                    onPressed: () async {
                      await Clipboard.setData(
                        ClipboardData(text: message.message),
                      );
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Response copied'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.copy_rounded,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

