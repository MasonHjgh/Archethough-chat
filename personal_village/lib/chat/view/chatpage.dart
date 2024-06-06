import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:personal_village/models/common/user.dart';
import 'package:personal_village/utility/get_it_handler.dart';
import 'package:personal_village/values/constants.dart';
import 'package:personal_village/values/routes.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/web_socket_channel.dart';

class Room {
  final String id;
  final String name;
  final List<Map<String, String>> msg;

  Room({
    required this.id,
    required this.name,
    required this.msg,
  });
}

class ChatScreen extends StatefulWidget {
  final Room room;

  ChatScreen({required this.room});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with WidgetsBindingObserver {
  TextEditingController _messageController = TextEditingController();
  List<Map<String, String>> messages = [];
  late WebSocketChannel channel;
  bool _isChannelInitialized = false;
  late String roomKey;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    startRoom();
    messages = widget.room.msg;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    if (_isChannelInitialized) {
      channel.sink.close();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentUserId = pvSettingsLogic.currentUserInfo.value.id;
    final currentUserHandle = pvSettingsLogic.currentUserInfo.value.userhandle;

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
            child: StreamBuilder(
              stream: _isChannelInitialized ? channel.stream : null,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  final message = jsonDecode(snapshot.data.toString());
                  messages.add({
                    "sender_id": message["sender_id"],
                    "body": message["body"],
                    "handle": message["handle"]
                  });
                }
                return ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final isCurrentUser = message["sender_id"] == currentUserId;

                    return Align(
                      alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                        children: [
                          Text(message["handle"] ?? 'Unknown', style: TextStyle(fontWeight: FontWeight.bold)),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: isCurrentUser ? Colors.blue : Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(message["body"] ?? ''),
                          ),
                        ],
                      ),
                    );
                  },
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
    if (message.isNotEmpty && _isChannelInitialized) {
      // Create the JSON message
      final messageJson = jsonEncode({
        "sender_id": pvSettingsLogic.currentUserInfo.value.id,
        "handle": pvSettingsLogic.currentUserInfo.value.userhandle,
        "room_key": roomKey,
        "room_id": widget.room.id,
        "body": message
      });

      // Send the JSON message to the WebSocket server
      channel.sink.add(messageJson);

      setState(() {
        messages.add({
          "sender_id": pvSettingsLogic.currentUserInfo.value.id,
          "handle": pvSettingsLogic.currentUserInfo.value.userhandle,
          "body": message
        });
      });
      _messageController.clear();
    }
  }

  Future<void> startRoom() async {
    String htUrl = apiUrl + "/ws/start_websocket/" + widget.room.id;
    final response = await http.post(
      Uri.parse(htUrl),
      headers: {
        'Authorization': 'Bearer ${pvSettingsLogic.currentUserInfo.value.accesstoken}',
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final url = Uri.parse('$wsUrl/ws/room/${jsonResponse['room_id']}');
      channel = WebSocketChannel.connect(url);
      roomKey = jsonResponse['room_key']; // Save the room key

      // Add the conversation messages to the messages list
      for (var message in jsonResponse['conversation']) {
        final msgResponse = json.decode(message);
        messages.add({
          "sender_id": msgResponse["user_id"],
          "handle": msgResponse["user_handle"],
          "body": msgResponse["message"]
        });
      }

      await channel.ready;
      setState(() {
        _isChannelInitialized = true; // Set the state to update the UI
      });
    } else {
      print("error");
    }
  }
}
