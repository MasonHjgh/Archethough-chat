import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:personal_village/chat/view/chatpage.dart';
import 'package:personal_village/utility/get_it_handler.dart';
import 'package:personal_village/values/constants.dart';

class CreateRoomDialog extends StatefulWidget {
  final String itemId;
  
  CreateRoomDialog({required this.itemId});

  @override
  _CreateRoomDialogState createState() => _CreateRoomDialogState();
}

class _CreateRoomDialogState extends State<CreateRoomDialog> {
  final TextEditingController _roomNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  void _createRoom() async {
    String itemUrl = apiUrl + "/room";

    Map<String, dynamic> requestBody = {
      "author_id": pvSettingsLogic.currentUserInfo.value.id,
      "conversation": [
        widget.itemId,
        pvSettingsLogic.currentUserInfo.value.id
      ],
      "description": _descriptionController.text,
      "owner_id": pvSettingsLogic.currentUserInfo.value.id,
      "participants": [
        widget.itemId,
        pvSettingsLogic.currentUserInfo.value.id
      ],
      "roomName": _roomNameController.text
    };

    try {
      final response = await http.post(
        Uri.parse(itemUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${pvSettingsLogic.currentUserInfo.value.accesstoken}',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        // Extract data from the response
        final data = responseData['data'];
        // Navigate to ChatScreen with extracted data
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(
              room: Room(
                id: data['_id'],
                name: data['roomName'],
                msg: [],
                // participants: data['participants'], // Adjust this based on the actual data structure
              ),
            ),
          ),
        );
      } else {
        print('HTTP error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Create Room'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            controller: _roomNameController,
            decoration: InputDecoration(hintText: 'Room Name'),
          ),
          TextField(
            controller: _descriptionController,
            decoration: InputDecoration(hintText: 'Description'),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Close'),
        ),
        TextButton(
          onPressed: _createRoom,
          child: Text('Create Room'),
        ),
      ],
    );
  }
}
