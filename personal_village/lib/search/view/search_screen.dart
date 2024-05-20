import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:personal_village/utility/get_it_handler.dart';
import 'package:personal_village/values/constants.dart';
import 'create_room_dialog.dart'; // Importing the CreateRoomDialog
import 'filter_dialog.dart'; // Importing the FilterDialog

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _searchText = '';
  List<String> _selectedFilters = [];
  Map<String, String?> _selectedFilterValues = {};
  List<String> _filterOptions = ['Role', 'Branch', 'Community', 'Federation'];
  Map<String, List<String>> _filterValues = {
    'Role': ['Admin', 'User', 'Manager'],
    'Branch': ['Branch A', 'Branch B', 'Branch C'],
    'Community': ['Community X', 'Community Y', 'Community Z'],
    'Federation': ['Federation 1', 'Federation 2', 'Federation 3'],
  };
  List<Map<String, dynamic>> _items = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: (value) {
            setState(() {
              _searchText = value;
            });
          },
          decoration: InputDecoration(
            hintText: 'Search...',
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              _startSearch();
            },
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              _showFilterDialog(context);
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildTagSection(),
          Expanded(
            child: ListView.builder(
              itemCount: _items.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    _showCreateRoomDialog(context, _items[index]['id']);
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 223, 69, 69),
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(1),
                    ),
                    child: ListTile(
                      title: Text(
                        _items[index]['userFullName'],
                        style: TextStyle(color: Colors.white),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _items[index]['userEmail'],
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            _items[index]['userHandle'],
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTagSection() {
    return Wrap(
      spacing: 8,
      children: _selectedFilterValues.entries.map((entry) {
        return FilterChip(
          label: Text('${entry.key}: ${entry.value}'),
          onSelected: (_) {
            setState(() {
              _selectedFilterValues.remove(entry.key);
              _selectedFilters.remove(entry.key);
            });
          },
        );
      }).toList(),
    );
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return FilterDialog(
          filterOptions: _filterOptions,
          filterValues: _filterValues,
          selectedFilterValues: _selectedFilterValues,
          onFilterValueChanged: (filter, value) {
            setState(() {
              _selectedFilterValues[filter] = value;
              if (!_selectedFilters.contains(filter)) {
                _selectedFilters.add(filter);
              }
            });
          },
        );
      },
    );
  }

  void _startSearch() async {
    try {
      String loginurl = apiUrl + "/user/search/" + _searchText;
      final response = await http.get(
        Uri.parse(loginurl),
        headers: {
          'Authorization':
              'Bearer ${pvSettingsLogic.currentUserInfo.value.accesstoken}',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        setState(() {
          _items = List<Map<String, dynamic>>.from(responseData['data']);
        });
      } else {
        print('HTTP error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void _showCreateRoomDialog(BuildContext context, String itemId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CreateRoomDialog(itemId: itemId);
      },
    );
  }
}
