import 'package:flutter/material.dart';
import 'package:personal_village/models/common/user.dart';
import 'package:personal_village/utility/get_it_handler.dart';
import 'package:personal_village/values/constants.dart';
import 'package:personal_village/values/routes.dart';

// Define a Room class to represent the room object
class Room {
  final String id;
  final String name;
  final List<String> msg;
  // final List<String> participants;

  Room({
    required this.id,
    required this.name,
    required this.msg,
    // required this.participants,
  });
}

class ChatScreen extends StatefulWidget {
  final Room room;

  ChatScreen({required this.room});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _messageController = TextEditingController();
  List<String> messages = [];

  @override
  void initState() {
    super.initState();
    messages = widget.room.msg; // Initialize messages with existing messages
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            CircleAvatar(
              child: Image.asset(
                Avatarlogo,
              ),
              backgroundImage: AssetImage('assets/images/avatar.png'),
            ),
            SizedBox(width: 10),
            Text(widget.room.name),
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              pvNavService.pushNamed(
                searchScreenRoute,
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.call),
            color: Colors.orange,
            onPressed: () {
              // Handle call functionality
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            color: Colors.indigo,
            onPressed: () {
              // Handle settings functionality
            },
          ),
        ],
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(messages[index]),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.attach_file),
                  onPressed: () {
                    // Handle file attachment
                  },
                ),
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                      fillColor: Colors.grey,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    // Send the message to the room, and update the UI
                    String message = _messageController.text;
                    sendMessage(message);
                  },
                  color: Colors.blueAccent,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void sendMessage(String message) {
    // In a real application, you would send the message to the recipient
    // and update the chat history, either by using a database or a real-time messaging service.

    // Here, you would send the message to the recipient using the appropriate method

    // For example:
    // chatService.sendMessage(widget.room.id, message);

    // Instead of directly adding the message to the room's message history
    setState(() {
      messages.add(message);
    });

    // Clear the input field
    _messageController.clear();
  }
}
