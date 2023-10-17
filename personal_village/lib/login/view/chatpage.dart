import 'package:flutter/material.dart';
import 'package:personal_village/utility/get_it_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:personal_village/login/bloc/login_bloc.dart';

import 'package:personal_village/values/constants.dart';
import 'package:personal_village/values/routes.dart';


void main() {
  runApp(MyApp());
}



class ChatScreen extends StatefulWidget {
  final String recipientName;

  ChatScreen({required this.recipientName});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _messageController = TextEditingController();
  List<String> messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                // Handle navigating back
              },
            ),

            CircleAvatar( // Left-aligned profile avatar
        child: Image.asset(
          Avatarlogo, // Change this to the path of your image asset

        ),
              // Specify the image or decoration for the avatar
              backgroundImage: AssetImage('path_to_avatar_image.png'),
            ),
            SizedBox(width: 10), // Add spacing between avatar and recipient name
            Text(widget.recipientName),
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Handle search functionality
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
            icon: Icon(Icons.settings), // Add the "settings" icon
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
                    // Send the message to the recipient, and update the UI
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

    setState(() {
      messages.add(message);
    });

    // Clear the input field
    _messageController.clear();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChatScreen(recipientName: 'John Doe'),
    );
  }
}
