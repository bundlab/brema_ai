import 'chat_message.dart';

class Conversation {
  Conversation({
    required this.id,
    required this.title,
    required this.messages,
    required this.updatedAt,
  });

  final String id;
  String title;
  final List<ChatMessage> messages;
  DateTime updatedAt;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'messages': messages
          .map(
            (message) => {
              'message': message.message,
              'isUser': message.isUser,
            },
          )
          .toList(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory Conversation.fromJson(Map<String, dynamic> json) {
    final rawMessages = json['messages'] as List<dynamic>? ?? [];

    return Conversation(
      id: json['id'] as String,
      title: json['title'] as String? ?? 'New Chat',
      messages: rawMessages.map((item) {
        final message = Map<String, dynamic>.from(item as Map);

        return ChatMessage(
          message: message['message'] as String? ?? '',
          isUser: message['isUser'] as bool? ?? false,
        );
      }).toList(),
      updatedAt: DateTime.tryParse(
            json['updatedAt'] as String? ?? '',
          ) ??
          DateTime.now(),
    );
  }
}
