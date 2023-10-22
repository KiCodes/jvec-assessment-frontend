import 'package:flutter/material.dart';
import 'package:jvec_assessment_frontend/src/config/internt_connection.dart';
import 'package:jvec_assessment_frontend/src/config/router_config.dart';
import 'package:jvec_assessment_frontend/src/constants/color.dart';
import 'package:jvec_assessment_frontend/src/constants/routes_path.dart';
import 'package:jvec_assessment_frontend/src/data/remote_datasource.dart';
import 'package:jvec_assessment_frontend/src/data/shared_preferences.dart';
import 'package:jvec_assessment_frontend/src/reusables/custom_text.dart';
import 'package:jvec_assessment_frontend/src/reusables/dialogs.dart';

class ContactDetailsController with ChangeNotifier {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  bool isEditMode = false;
  bool isLoadingSave= false;
  bool isLoadingDelete = false;
  final Map <String, dynamic> contact = {};
  String contactID = '';

  String? token;
  final ConnectionModel connModel = ConnectionModel()
    ..addListener(() {});

  Future<void> updateContact(context, String id,) async {
    token = await SharedPreferencesManager.loadToken();
    // Check if a token is available
    if (token == null) {
      CustomDialog().showCustomToast("Login to continue", Colors.grey);
      routerConfig.pushReplacement(RoutesPath.loginScreen);
    }
    isLoadingSave = true;
    if (connModel.hasConnection) {
      if(firstNameController.text.isEmpty || lastNameController.text.isEmpty || phoneController.text.isEmpty){
        CustomDialog().showCustomToast("Fields cannot be empty!", Colors.grey);
        isLoadingSave = false;
        notifyListeners();
        return;
      }
      try {
        // Fetch contact data
        Map<String, dynamic> response =
        await DataSource.updateContact(token!, contactID.trim(), contact);
        print(response);

        String errorMessage = response.toString();
        if (errorMessage.contains('error updating contact')) {
          CustomDialog().showCustomToast("could not update contact", Colors.grey);
          isLoadingSave = false;
          isEditMode = false;
          notifyListeners();
          return;
        }
        else{
          CustomDialog().showCustomToast("Contact Updated!", Colors.green);
          firstNameController.clear();
          lastNameController.clear();
          isLoadingSave = false;
          isEditMode = false;
          routerConfig.pushReplacement(RoutesPath.homeScreen);
          notifyListeners();
        }
      } catch (error) {
        print("Error updating contact: $error");
        CustomDialog().showCustomToast("Error updating contact", Colors.grey);
        isLoadingSave = true;
        isEditMode = false;
        notifyListeners();
      }
    }
  }

  Future<void> confirmContactDeletion(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const CustomText(requiredText: "Confirm Deletion", color: MyColor.appColor, fontWeight: FontWeight.bold,),
          content: CustomText(requiredText: "Are you sure you want to delete this contact?",
          color: MyColor.appColor.withOpacity(0.7),),
          actions: <Widget>[
            TextButton(
              child: const CustomText(requiredText: 'Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const CustomText(requiredText: 'Delete', color: Colors.redAccent,),
              onPressed: () {
                deleteContact(context);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  Future<void> deleteContact(context) async {
    await confirmContactDeletion(context);
    token = await SharedPreferencesManager.loadToken();
    // Check if a token is available
    if (token == null) {
      CustomDialog().showCustomToast("Login to continue", Colors.grey);
      routerConfig.pushReplacement(RoutesPath.loginScreen);
    }
    if (connModel.hasConnection) {
      try {
        Map<String, dynamic> response =
        await DataSource.deleteContact(token!, contactID.trim());
        print(response);
        CustomDialog().showCustomToast("Contact Deleted!", Colors.green);
        firstNameController.clear();
        lastNameController.clear();
        isLoadingDelete = false;
        isEditMode = false;
        routerConfig.pushReplacement(RoutesPath.homeScreen);
        notifyListeners();
      } catch (error) {
        print("Error deleting contacts: $error");
        CustomDialog().showCustomToast("Error loading contacts", Colors.grey);
        notifyListeners();
      }
    }
  }

  void toggleEditMode() {
    isEditMode = !isEditMode;
    notifyListeners();
  }

  void updateContactData() {
    contact['firstName'] = firstNameController.text;
    contact['lastName'] = lastNameController.text;
    contact['phone'] = phoneController.text;
    notifyListeners();
  }
}

