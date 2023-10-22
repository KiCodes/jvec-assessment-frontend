
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static SharedPreferences get prefs => _prefs;

  static Future<void> saveToken(String token) async {
    await _prefs.setString('token', token);
  }
  static Future<String?> loadToken() async {
    final String? token = _prefs.getString('token');
    return token;
  }

  static Future<void> removeToken() async {
    _prefs.remove('token');
  }

  static Future<void> saveContacts(List<Map<String, dynamic>> contacts) async {
    final encodedContacts = contacts.map((contact) {
      return contact;
    }).toList();
    final contactsJson = jsonEncode(encodedContacts);
    await _prefs.setString('contacts', contactsJson);
  }

  static Future<List<Map<String, dynamic>>> loadContacts() async {
    final contactsJson = _prefs.getString('contacts');
    if (contactsJson != null) {
      final decodedContacts = json.decode(contactsJson) as List<dynamic>;
      final contacts = decodedContacts
          .map((contact) => contact as Map<String, dynamic>)
          .toList();
      return contacts;
    }
    return [];
  }

}
