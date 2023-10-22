import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jvec_assessment_frontend/src/config/internt_connection.dart';
import 'package:jvec_assessment_frontend/src/config/router_config.dart';
import 'package:jvec_assessment_frontend/src/constants/routes_path.dart';
import 'package:jvec_assessment_frontend/src/data/remote_datasource.dart';
import 'package:jvec_assessment_frontend/src/data/shared_preferences.dart';
import 'package:jvec_assessment_frontend/src/screens/alphabet_list_view.dart';
import 'package:jvec_assessment_frontend/src/reusables/dialogs.dart';
import 'package:jvec_assessment_frontend/src/screens/login_screen.dart';

class HomeController with ChangeNotifier {
  final TextEditingController searchBarController = TextEditingController();
  bool hasLoaded = false;
  String? token;
  List<Map<String, dynamic>>contacts = [];
  Map<String, dynamic> userDetails = {};
  final ConnectionModel connModel = ConnectionModel()
    ..addListener(() {
    });

  Future<void> loadContacts(context) async {
    token = await SharedPreferencesManager.loadToken();
    // Check if a token is available
    if (token == null) {
      routerConfig.pushReplacement(RoutesPath.loginScreen);
    }

    if (connModel.hasConnection) {
      try {
        // Fetch contact data
        List<Map<String, dynamic>> loadedContacts = await DataSource.getAllContacts(token!);
        hasLoaded = true;
        loadedContacts.sort((a, b) => a['firstName'].toLowerCase().compareTo(b['firstName'].toLowerCase()));
        contacts = loadedContacts;
        SharedPreferencesManager.saveContacts(contacts);
        items = convertDynamicDataToContactList(context);
        notifyListeners();
      } catch (error) {
        if(error.toString() == 'Invalid Token'){
          showDialog(
            context: context,
            builder: (context) {
              return const LoginScreen();
            },
          );
        }
        print("Error loading contacts: $error");
        hasLoaded = true;
        notifyListeners();
      }
    }else{
      hasLoaded = true;
      notifyListeners();
    }
  }

  Future<void> loadUser(context) async {
    token = await SharedPreferencesManager.loadToken();
    // Check if a token is available
    if (token == null) {
      routerConfig.pushReplacement(RoutesPath.loginScreen);
    }

    if (connModel.hasConnection) {
      try {
        // Fetch contact data
        Map<String, dynamic> loadedUserDetails = await DataSource.getUserDetails(token!);
        hasLoaded = true;
        userDetails = loadedUserDetails;
        notifyListeners();
      } catch (error) {
        if (error is TimeoutException) {
          print(error);
          return;
        }
        if(error.toString() == 'Invalid Token'){
          routerConfig.pushReplacement(RoutesPath.loginScreen);
        }
        print("Error loading contacts: $error");
        CustomDialog().showCustomToast("Error loading contacts", Colors.grey);
        hasLoaded = true;
        notifyListeners();
      }
    }else{
      CustomDialog().showCustomToast("No internet connection", Colors.grey);
      hasLoaded = true;
      notifyListeners();
    }
  }

  List<ContactList> convertDynamicDataToContactList(context) {
    loadContacts(context);
    return contacts.map((contact) => ContactList(
      '${contact["firstName"]} ${contact["lastName"]}',
      contact["firstName"][0].toUpperCase(),
    )).toList();
  }

  List<ContactList> items = [];


}

