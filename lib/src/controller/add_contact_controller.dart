import 'package:flutter/material.dart';
import 'package:jvec_assessment_frontend/src/config/internt_connection.dart';
import 'package:jvec_assessment_frontend/src/config/router_config.dart';
import 'package:jvec_assessment_frontend/src/constants/routes_path.dart';
import 'package:jvec_assessment_frontend/src/controller/home_controller.dart';
import 'package:jvec_assessment_frontend/src/data/remote_datasource.dart';
import 'package:jvec_assessment_frontend/src/data/shared_preferences.dart';
import 'package:jvec_assessment_frontend/src/reusables/dialogs.dart';

class AddContactController with ChangeNotifier {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  bool isLoading = false;
  String? token;
  final ConnectionModel connModel = ConnectionModel()
    ..addListener(() {
    });

  Future<void> addContact(context) async {
    token = await SharedPreferencesManager.loadToken();
    // Check if a token is available
    if (token == null) {
      CustomDialog().showCustomToast("Login to continue", Colors.grey);
      routerConfig.pushReplacement(RoutesPath.loginScreen);
    }

    if(firstNameController.text.isEmpty || phoneNumberController.text.isEmpty || lastNameController.text.isEmpty
    ){
      CustomDialog().showCustomToast("Fields cannot be empty!", Colors.grey);
        return;
      }

    isLoading = true;
    if (connModel.hasConnection) {
      try {
        // Fetch contact data
        Map<String, dynamic> response =
        await DataSource.addContact(token!, firstNameController.text.trim(), lastNameController.text.trim(),
            phoneNumberController.text.trim());
          CustomDialog().showCustomToast("Contact added!", Colors.green);
          firstNameController.clear();
          lastNameController.clear();
          HomeController().loadContacts(context);
          isLoading = false;
          routerConfig.pushReplacement(RoutesPath.homeScreen);
          notifyListeners();
      } catch (error) {
        if(error.toString() == 'Invalid Token'){
          routerConfig.pushReplacement(RoutesPath.loginScreen);
          isLoading = false;
          notifyListeners();
        }
        print("Error loading contacts: $error");
        CustomDialog().showCustomToast("Error loading contacts", Colors.grey);
        isLoading = false;
        notifyListeners();
      }
    }else{
      isLoading = false;
      notifyListeners();
    }
  }


}

