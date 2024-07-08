import 'package:flutter/material.dart';
import 'package:sm_task/model.dart';

class FirstPage extends StatelessWidget {
  final List<List<AndroidVersion>> versions;

  FirstPage({required this.versions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          'JSON Parser Example 1',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Parsed JSON 1:'),
            SizedBox(height: 20),
            showParsedJson(context),
          ],
        ),
      ),
    );
  }

  Widget showParsedJson(BuildContext context) {
    // Calculate maximum number of columns
    int maxColumns =
        versions.map((row) => row.length).fold(0, (p, e) => p > e ? p : e);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: versions.map((versionRow) {
          // Pad versionRow to ensure all rows have the same number of columns
          while (versionRow.length < maxColumns) {
            versionRow.add(AndroidVersion(id: -1, title: ''));
          }

          return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: _buildVersionRow(versionRow),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildVersionRow(List<AndroidVersion> versions) {
    return Row(
      children: versions.map((version) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            version.title ?? '', // Display title or empty string if null
            textAlign: TextAlign.center, // Center align text
            style: TextStyle(fontSize: 18),
          ),
        );
      }).toList(),
    );
  }
}
