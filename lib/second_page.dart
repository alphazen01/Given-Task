import 'package:flutter/material.dart';
import 'package:sm_task/model.dart';

class SecondPage extends StatelessWidget {
  final List<List<AndroidVersion>> versions;

  SecondPage({required this.versions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          'JSON Parser Example 2',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Parsed JSON 2:'),
            SizedBox(height: 20),
            showParsedJson(context, versions),
          ],
        ),
      ),
    );
  }

  Widget showParsedJson(
      BuildContext context, List<List<AndroidVersion>> versions) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: versions.map((versionRow) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: _buildVersionRow(versionRow),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildVersionRow(List<AndroidVersion> versions) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: versions.map((version) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              version.title!,
              style: TextStyle(fontSize: 18),
            ),
          );
        }).toList(),
      ),
    );
  }
}
