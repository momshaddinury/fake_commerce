import 'dart:convert';

List<String> categoryModelFromJson(List<dynamic> item) =>
    List<String>.from(item.map((x) => x));

String categoryModelToJson(List<String> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x)));
