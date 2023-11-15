import 'package:flutter/material.dart';

class KnowledgeBaseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.yellow[50],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 20.0),
            Center(
              child: Text(
                'Knowledge Base Library',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            _buildSearchBar(context),
            SizedBox(height: 20.0),
            Expanded(
              child: _buildKnowledgeList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search...',
          contentPadding: EdgeInsets.symmetric(horizontal: 5.0),
          border: InputBorder.none,
          suffixIcon: Icon(Icons.search),
        ),
        onChanged: (text) {
          // Perform search operation
        },
        style: TextStyle(color: Theme.of(context).primaryColor),
      ),
    );
  }

  Widget _buildKnowledgeList() {
    // Replace this with your actual knowledge items
    List<String> knowledgeItems = [
      'Caregivers',
      'services',
      'pharmacy',
      'Nurse',
    ];

    return ListView.builder(
      itemCount: knowledgeItems.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 2.0,
          margin: EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            title: Text(knowledgeItems[index]),
            onTap: () {
              // Navigate or display the selected knowledge item
            },
          ),
        );
      },
    );
  }
}
