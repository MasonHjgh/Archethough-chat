
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:personal_village/chat/view/chatpage.dart';
import 'package:personal_village/search/view/search_screen.dart';
import 'package:personal_village/utility/get_it_handler.dart';
import 'package:personal_village/values/constants.dart';

class Conversation {
  final String id;
  final String roomName;
  final String description;
  final List<String> conversation;
  final List<String> participants;
  final String ownerId;
  final String authorId;

  Conversation({
    required this.id,
    required this.roomName,
    required this.description,
    required this.conversation,
    required this.participants,
    required this.ownerId,
    required this.authorId,
  });

  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      id: json['id'],
      roomName: json['roomName'],
      description: json['description'],
      conversation: List<String>.from(json['conversation']),
      participants: List<String>.from(json['participants']),
      ownerId: json['owner_id'],
      authorId: json['author_id'],
    );
  }
}

class ConversationsScreen extends StatefulWidget {
  @override
  _ConversationsScreenState createState() => _ConversationsScreenState();
}

class _ConversationsScreenState extends State<ConversationsScreen> {
  List<Conversation> conversations = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Replace 'your_search_string' and 'your_token' with the actual search term and token
    _fetchConversations();
  }

  Future<void> _fetchConversations() async {
    String loginurl=apiUrl+"/room/search/"+ pvSettingsLogic.currentUserInfo.value.id;
    final response = await http.get(
      Uri.parse(loginurl),
      headers: {
        'Authorization': 'Bearer ${pvSettingsLogic.currentUserInfo.value.accesstoken}',
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final List<dynamic> data = jsonResponse['data'];

      setState(() {
        conversations = data.map((item) => Conversation.fromJson(item)).toList();
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
        // Handle error by showing a message or similar
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Conversations'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: conversations.length,
              itemBuilder: (context, index) {
                final conversation = conversations[index];
                return ListTile(
                  leading: CircleAvatar(
                    child: Text(conversation.roomName[0]),
                  ),
                  title: Text(conversation.roomName),
                  subtitle: Text(conversation.description),
                  onTap: () {
                    // Navigate to the ChatScreen when the item is tapped
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(room: Room(id: conversation.id, name: conversation.roomName, msg:[], ),),
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
