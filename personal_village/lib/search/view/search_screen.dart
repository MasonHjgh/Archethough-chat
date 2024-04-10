import 'dart:convert'; // Importing this for JSON encoding
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'filter_dialog.dart'; // Importing the FilterDialog from filter_dialog.dart

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
                // Use _items[index] to access each item in the list
                return ListTile(
                  title: Text(_items[index][
                      'title']), // Assuming 'title' is the key for your item title
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
    // Constructing your search query
    Map<String, dynamic> searchData = {
      'keyword': _searchText,
      'filters': _selectedFilterValues,
    };

    // Sending HTTP POST request with search data
    try {
      final response = await http.post(
        Uri.parse('YOUR_API_ENDPOINT_HERE'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(searchData),
      );

      // Handle response here
      if (response.statusCode == 200) {
        // Successfully received data, handle it here
        final responseData = jsonDecode(response.body);
        setState(() {
          // Update your item list with the data received from the response
          _items = responseData[
              'items']; // Assuming 'items' is the key for your item list
        });
      } else {
        // Error occurred, handle it here
        print('HTTP error: ${response.statusCode}');
      }
    } catch (e) {
      // Error occurred, handle it here
      print('Error: $e');
    }
  }
}
