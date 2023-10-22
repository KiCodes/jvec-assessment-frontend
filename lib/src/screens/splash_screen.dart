import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jvec_assessment_frontend/src/config/router_config.dart';
import 'package:jvec_assessment_frontend/src/constants/color.dart';
import 'package:jvec_assessment_frontend/src/constants/routes_path.dart';
import 'package:jvec_assessment_frontend/src/data/shared_preferences.dart';
import 'package:jvec_assessment_frontend/src/reusables/custom_text.dart';
import 'package:jvec_assessment_frontend/src/reusables/dimension.dart';

import '../reusables/loading_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      startImageSwitchTimer();
    });
  }

  Future<void> startImageSwitchTimer() async {
    String? token;
    token = await SharedPreferencesManager.loadToken();
    print(token);

    if(token == null){
      routerConfig.push(RoutesPath.loginScreen);
    } else{
      Timer.periodic(const Duration(seconds: 3), (timer) {
        routerConfig.pushReplacement(RoutesPath.homeScreen);
        timer.cancel();
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.bgColor,
      body: Container(
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const LoadingWidget(),
            20.verticalSpace,
            Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: 3.0,
                  left: 0.0,
                  child: CustomText(
                    requiredText: 'CONTACT BOOK',
                    color: MyColor.textColor.withOpacity(0.6),
                    fontSize: MyDimension.dim22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const CustomText(
                  requiredText: 'CONTACT BOOK',
                  color: MyColor.appColor,
                  fontSize: MyDimension.dim22,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
            20.verticalSpace,
          ],
        ),
      ),
    );
  }
}
