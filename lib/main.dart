import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jvec_assessment_frontend/src/config/internt_connection.dart';
import 'package:jvec_assessment_frontend/src/config/router_config.dart';
import 'package:jvec_assessment_frontend/src/controller/add_contact_controller.dart';
import 'package:jvec_assessment_frontend/src/controller/contact_details_controller.dart';
import 'package:jvec_assessment_frontend/src/controller/home_controller.dart';
import 'package:jvec_assessment_frontend/src/controller/login_controller.dart';
import 'package:jvec_assessment_frontend/src/controller/signup_controller.dart';
import 'package:jvec_assessment_frontend/src/data/shared_preferences.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesManager.init();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeController()),
        ChangeNotifierProvider(create: (_) => LoginController()),
        ChangeNotifierProvider(create: (_) => SignUpController()),
        ChangeNotifierProvider(create: (_) => ConnectionModel()),
        ChangeNotifierProvider(create: (_) => AddContactController()),
        ChangeNotifierProvider(create: (_) => ContactDetailsController()),
      ],
      child: const ContactBook(),
    ),
  );
}

class ContactBook extends StatelessWidget {
  const ContactBook({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(411.4, 868.6),
        minTextAdapt: true,
        builder: (context, child) {
          return MaterialApp.router(
            routerConfig: routerConfig,
            debugShowCheckedModeBanner: false,
            title: 'Contact Book',
          );
        });
  }
}