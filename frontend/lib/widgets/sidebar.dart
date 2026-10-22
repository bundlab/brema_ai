import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      color: const Color(0xFF1B1C1F),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                  label: const Text("New Chat"),
                ),
              ),
            ),

            const Divider(height: 1),

            const Padding(
              padding: EdgeInsets.fromLTRB(16, 20, 16, 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Recent Chats",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white70,
                  ),
                ),
              ),
            ),

            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: const [
                  ListTile(
                    leading: Icon(
                      Icons.chat_bubble_outline,
                      color: Colors.cyan,
                    ),
                    title: Text("Welcome"),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.chat_bubble_outline,
                      color: Colors.cyan,
                    ),
                    title: Text("AI Assistant"),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.chat_bubble_outline,
                      color: Colors.cyan,
                    ),
                    title: Text("New Conversation"),
                  ),
                ],
              ),
            ),

            const Divider(height: 1),

            const ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings"),
            ),
          ],
        ),
      ),
    );
  }
}