import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jvec_assessment_frontend/src/config/router_config.dart';
import 'package:jvec_assessment_frontend/src/constants/color.dart';
import 'package:jvec_assessment_frontend/src/constants/routes_path.dart';
import 'package:jvec_assessment_frontend/src/controller/login_controller.dart';
import 'package:jvec_assessment_frontend/src/reusables/button.dart';
import 'package:jvec_assessment_frontend/src/reusables/custom_text.dart';
import 'package:jvec_assessment_frontend/src/reusables/dimension.dart';
import 'package:jvec_assessment_frontend/src/reusables/textfield.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final loginController = context.watch<LoginController>();
    final loginControllerRead = context.read<LoginController>();

    return Scaffold(
      body: Center(
        child: Container(
          width: mediaQuery.width,
          padding: const EdgeInsets.symmetric(horizontal: 40),
          height: mediaQuery.height * 0.8,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
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
              50.verticalSpace,
              const Text(
                'LOGIN',
                style: TextStyle(fontSize: 24, color: MyColor.appColor, fontWeight: FontWeight.bold),
              ),
              CustomTextField(headerText: 'Email',
                controller: loginControllerRead.emailController, keyboardType: TextInputType.emailAddress),
              20.verticalSpace,
              CustomTextField(headerText: 'Password',
              controller: loginControllerRead.passwordController,
                  obscureText: true),
              20.verticalSpace,
              ButtonWidget(buttonText: 'Login', fontSize: MyDimension.dim16,
              textColor: Colors.white,
              buttonColor: MyColor.appColor,
              onPressed:loginController.isLoading ? null : () => loginControllerRead.login(),
                isLoading: loginController.isLoading,),
              20.verticalSpace,
              GestureDetector(
                onTap: ()=> routerConfig.pushReplacement(RoutesPath.signupScreen),
                child: const CustomText(
                  requiredText: '...Or SignUp?',
                  color: MyColor.appColor,
                  fontSize: MyDimension.dim22,
                  fontWeight: FontWeight.bold,
                  textDecoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}