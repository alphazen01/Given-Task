import 'dart:convert';

import 'package:sm_task/model.dart';

List<List<AndroidVersion>> parseJson(String jsonString) {
  List<List<AndroidVersion>> versions = [];
  List<dynamic> parsedList = json.decode(jsonString);
  for (var item in parsedList) {
    List<AndroidVersion> row = [];
    if (item is Map<String, dynamic>) {
      var maxKey = item.keys
          .map((key) => int.parse(key))
          .reduce((a, b) => a > b ? a : b);
      for (var i = 0; i <= maxKey; i++) {
        if (item.containsKey(i.toString())) {
          var versionData = item[i.toString()];
          row.add(AndroidVersion(
            id: versionData['id'],
            title: versionData['title'],
          ));
        } else {
          row.add(AndroidVersion(id: -1, title: ''));
        }
      }
    } else if (item is List) {
      item.forEach((element) {
        row.add(AndroidVersion(
          id: element['id'],
          title: element['title'],
        ));
      });
    }
    versions.add(row);
  }
  return versions;
}
