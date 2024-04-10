import 'package:flutter/material.dart';

class FilterDialog extends StatefulWidget {
  final List<String> filterOptions;
  final Map<String, List<String>> filterValues;
  final Map<String, String?> selectedFilterValues;
  final Function(String, String?) onFilterValueChanged;

  FilterDialog({
    required this.filterOptions,
    required this.filterValues,
    required this.selectedFilterValues,
    required this.onFilterValueChanged,
  });

  @override
  _FilterDialogState createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  Map<String?, String?> _selectedValues = {};

  @override
  void initState() {
    super.initState();
    _selectedValues = Map.from(widget.selectedFilterValues);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Filters"),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widget.filterOptions.map((filter) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(filter),
                DropdownButton<String?>(
                  value: _selectedValues[filter],
                  items: widget.filterValues[filter]?.map((value) {
                    return DropdownMenuItem<String?>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedValues[filter] = newValue;
                      widget.onFilterValueChanged(filter, newValue);
                    });
                  },
                ),
                Divider(),
              ],
            );
          }).toList(),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Close'),
        ),
      ],
    );
  }
}
