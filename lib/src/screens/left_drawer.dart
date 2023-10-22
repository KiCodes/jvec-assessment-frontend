import 'package:flutter/material.dart';
import 'package:jvec_assessment_frontend/src/config/router_config.dart';
import 'package:jvec_assessment_frontend/src/constants/color.dart';
import 'package:jvec_assessment_frontend/src/constants/routes_path.dart';
import 'package:jvec_assessment_frontend/src/controller/home_controller.dart';
import 'package:jvec_assessment_frontend/src/data/remote_datasource.dart';
import 'package:jvec_assessment_frontend/src/data/shared_preferences.dart';
import 'package:jvec_assessment_frontend/src/reusables/custom_text.dart';
import 'package:jvec_assessment_frontend/src/reusables/dialogs.dart';
import 'package:jvec_assessment_frontend/src/screens/login_screen.dart';
import 'package:provider/provider.dart';

class LeftDrawerWidget extends StatefulWidget {
  const LeftDrawerWidget({super.key});

  @override
  State<LeftDrawerWidget> createState() => _LeftDrawerWidgetState();
}

class _LeftDrawerWidgetState extends State<LeftDrawerWidget> {

  @override
  void initState() {
    super.initState();
    context.read<HomeController>().loadUser(context);
  }

  @override
  Widget build(BuildContext context) {
    final homeController = context.watch<HomeController>();
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: CustomText(requiredText: homeController.userDetails['name'] ?? ''),
            accountEmail: CustomText(requiredText: homeController.userDetails['email'] ?? ''),
            decoration: const BoxDecoration(
              color: MyColor.appColor
            ),
          ),
          if(homeController.userDetails.isEmpty) ListTile(
            leading: const Icon(Icons.person_add),
            title: const Text('Register'),
            onTap: () {
              // Handle the Register action here
            },
          ),
          if(homeController.userDetails.isEmpty) ListTile(
            leading: const Icon(Icons.login),
            title: const Text('Login'),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return const LoginScreen();
                },
              );
            },
          ),
          if(homeController.userDetails.isNotEmpty) ListTile(
            leading: const Icon(Icons.login),
            title: const Text('Logout'),
            onTap: () {
              String? token = HomeController().token;
              if(token == null){
                routerConfig.pushReplacement(RoutesPath.loginScreen);
                CustomDialog().showCustomToast("Signed out", Colors.green);
              }else{
                DataSource.logout(token!);
                CustomDialog().showCustomToast("Signed out", Colors.green);
                SharedPreferencesManager.removeToken();
                routerConfig.pushReplacement(RoutesPath.loginScreen);
              }
            },
          ),
        ],
      ),
    );
  }
}
