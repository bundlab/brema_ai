import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/conversation.dart';

class ConversationStorageService {
  static const String _storageKey = 'brema_ai_conversations_v1';

  Future<List<Conversation>> loadConversations() async {
    final preferences = await SharedPreferences.getInstance();
    final storedData = preferences.getString(_storageKey);

    if (storedData == null || storedData.isEmpty) {
      return [];
    }

    try {
      final decoded = jsonDecode(storedData) as List<dynamic>;

      final conversations = decoded.map((item) {
        return Conversation.fromJson(
          Map<String, dynamic>.from(item as Map),
        );
      }).toList();

      conversations.sort(
        (a, b) => b.updatedAt.compareTo(a.updatedAt),
      );

      return conversations;
    } on FormatException {
      return [];
    } on TypeError {
      return [];
    } on StateError {
      return [];
    }
  }

  Future<void> saveConversations(
    List<Conversation> conversations,
  ) async {
    final preferences = await SharedPreferences.getInstance();

    final encoded = jsonEncode(
      conversations.map((conversation) => conversation.toJson()).toList(),
    );

    final saved = await preferences.setString(_storageKey, encoded);

    if (!saved) {
      throw Exception('Could not save BremaAI conversation history.');
    }
  }
}
