import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sm_task/first_page.dart';
import 'package:sm_task/model.dart';
import 'package:sm_task/second_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String jsonString1 = '''
  [{"0":{"id":1,"title":"Gingerbread"},"1":{"id":2,"title":"Jellybean"},"3":{"id":3,"title":"KitKat"}},[{"id":4,"title":"Lollipop"},{"id":5,"title":"Pie"},{"id":6,"title":"Oreo"},{"id":7,"title":"Nougat"}]]
  ''';

  final String jsonString2 = '''
  [
  {
  "0":{"id":1,"title":"Gingerbread"},
  "1":{"id":2,"title":"Jellybean"},
  "3":{"id":3,"title":"KitKat"}
  },
  {"0":{"id":8,"title":"Froyo"},
  "1":{"id":9,"title":"Éclair"},
  "2":{"id":10,"title":"Donut"}},
  [{"id":4,"title":"Lollipop"},
  {"id":5,"title":"Pie"},
  {"id":6,"title":"Oreo"},
  {"id":7,"title":"Nougat"}]]
  ''';

  List<List<AndroidVersion>> parseJson(String jsonString) {
    List<List<AndroidVersion>> versions = [];
    List<dynamic> parsedList = json.decode(jsonString);
    for (var item in parsedList) {
      List<AndroidVersion> row = [];
      if (item is Map<String, dynamic>) {
        // Get the keys and fill in missing keys with null values
        var maxKey = item.keys
            .map((key) => int.parse(key))
            .reduce((a, b) => a > b ? a : b);
        for (var i = 0; i <= maxKey; i++) {
          if (item.containsKey(i.toString())) {
            var versionData = item[i.toString()];
            row.add(AndroidVersion(
                id: versionData['id'], title: versionData['title']));
          } else {
            row.add(AndroidVersion(
                id: -1,
                title: '')); // Add empty AndroidVersion for missing keys
          }
        }
      } else if (item is List) {
        // Handle list of items
        item.forEach((element) {
          row.add(AndroidVersion(id: element['id'], title: element['title']));
        });
      }
      versions.add(row);
    }
    return versions;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          'JSON Parser Example',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                List<List<AndroidVersion>> versions = parseJson(jsonString1);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => FirstPage(versions: versions),
                  ),
                );
              },
              child: Text('Parse and Show JSON 1'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                List<List<AndroidVersion>> versions = parseJson(jsonString2);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SecondPage(
                      versions: versions,
                    ),
                  ),
                );
              },
              child: Text('Parse and Show JSON 2'),
            ),
          ],
        ),
      ),
    );
  }
}
