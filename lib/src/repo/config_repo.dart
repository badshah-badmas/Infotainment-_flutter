import 'dart:convert';

import 'package:flutter/services.dart';

class ConfigRepo {
  static final instance = ConfigRepo();
  int index = 0;
  List<String> languages = [];
  Future<String> getLanguage() async {
    if (languages.isEmpty) {
      final response = await rootBundle.loadString('assets/json/config.json');
      final Map<String, dynamic> data = json.decode(response);
      languages = List<String>.from(data['languages']);
    }
    if (languages.isEmpty) return 'en';
    if (index >= languages.length) {
      index = 0;
    }
    final language = languages[index];
    index++;
    return language;
  }
}
