import 'package:flutter/material.dart';
import 'package:personal_village/chat/view/chatpage.dart';
import 'package:personal_village/search/view/search_screen.dart';

class Conversation {
  final String contactName;
  final String lastMessage;
  final DateTime timestamp;

  Conversation({
    required this.contactName,
    required this.lastMessage,
    required this.timestamp,
  });
}

class ConversationsScreen extends StatelessWidget {
  final List<Conversation> conversations = [
    // Conversation data...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Conversations'),
      ),
      body: ListView.builder(
        itemCount: conversations.length,
        itemBuilder: (context, index) {
          final conversation = conversations[index];
          return ListTile(
            leading: CircleAvatar(
              child: Text(conversation.contactName[0]),
            ),
            title: Text(conversation.contactName),
            subtitle: Text(conversation.lastMessage),
            trailing: Text(_formatTimestamp(conversation.timestamp)),
            onTap: () {
              // Navigate to the ChatScreen when the item is tapped
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(recipientName: conversation.contactName),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchScreen(),
                ),
              );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    // Format timestamp as needed
    return '${timestamp.hour}:${timestamp.minute}';
  }
}



