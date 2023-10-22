import 'package:flutter/material.dart';
import 'package:jvec_assessment_frontend/src/config/internt_connection.dart';
import 'package:jvec_assessment_frontend/src/config/router_config.dart';
import 'package:jvec_assessment_frontend/src/constants/routes_path.dart';
import 'package:jvec_assessment_frontend/src/data/remote_datasource.dart';
import 'package:jvec_assessment_frontend/src/reusables/dialogs.dart';

import '../data/shared_preferences.dart';

class SignUpController with ChangeNotifier {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  final ConnectionModel connModel = ConnectionModel()
  ..addListener(() {
  });

  Future<void> signUp() async {
    if(emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty && firstNameController.text.isNotEmpty && phoneNumberController.text.isNotEmpty
    ){
      String firstName = firstNameController.text.trim();
      String lastName = lastNameController.text.trim();
      String email = emailController.text.trim();
      String phoneNumber = phoneNumberController.text.trim();
      String password = passwordController.text.trim();

      print(' $firstName $lastName');

      isLoading = true;

      if (!isValidEmail(email)) {
        CustomDialog().showCustomToast("Invalid email format", Colors.red);
        return;
      }

      if (connModel.hasConnection) {
        try {
          final response = await DataSource.signUp(firstName, lastName, phoneNumber, email, password);
          if (response['message'] == 'User registered successfully') {
            print(response);
            isLoading = false;
            firstNameController.clear();
            lastNameController.clear();
            emailController.clear();
            phoneNumberController.clear();
            passwordController.clear();
            CustomDialog().showCustomToast("Sign up Successful", Colors.green);

            final loginResponse = await DataSource.login(email, password);
            String token = loginResponse["token"];
            SharedPreferencesManager.saveToken(token);

            routerConfig.pushReplacement(RoutesPath.homeScreen);
          } else {
            print(response);
            CustomDialog().showCustomToast("failed", Colors.grey);
            print(response);
            isLoading = false;
          }
        } on FormatException catch (e) {
          CustomDialog().showCustomToast("Unexpected response format from the server", Colors.red);
          print(e);
          isLoading = false;
        }
        on Exception catch (e) {
          CustomDialog().showCustomToast("sign up Failed: $e", Colors.red);
          print(e);
          isLoading = false;
        }
      }
      else{
        CustomDialog().showCustomToast("No internet connection", Colors.red);
        isLoading = false;
      }
    }
    notifyListeners();
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(
        r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)*(\.[a-z]{2,4})$');
    return emailRegex.hasMatch(email);
  }
}

