import 'package:flutter/material.dart';
import 'package:jvec_assessment_frontend/src/config/internt_connection.dart';
import 'package:jvec_assessment_frontend/src/config/router_config.dart';
import 'package:jvec_assessment_frontend/src/constants/routes_path.dart';
import 'package:jvec_assessment_frontend/src/data/remote_datasource.dart';
import 'package:jvec_assessment_frontend/src/data/shared_preferences.dart';
import 'package:jvec_assessment_frontend/src/reusables/dialogs.dart';

class LoginController with ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  final ConnectionModel connModel = ConnectionModel()
  ..addListener(() {
  });

  Future<void> login() async {
    if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty){
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      isLoading = true;
      await Future.delayed(const Duration(seconds: 2));
      if (connModel.hasConnection) {
        try {
          final response = await DataSource.login(email, password);
          if (response.containsKey("token")) {
            String token = response["token"];
            SharedPreferencesManager.saveToken(token);
            print(response);
            isLoading = false;
            emailController.clear();
            passwordController.clear();
            CustomDialog().showCustomToast("Login Successful", Colors.green);
            routerConfig.pushReplacement(RoutesPath.homeScreen);
          } else if (response.containsKey("message")) {

            String errorMessage = response["message"];
            CustomDialog().showCustomToast(errorMessage, Colors.grey);
            print(response);
            isLoading = false;
          }
        } on Exception catch (e) {
          CustomDialog().showCustomToast("Login Failed: $e", Colors.red);
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
}

