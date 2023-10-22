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

import '../controller/signup_controller.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final signUpController = context.watch<SignUpController>();
    final signUpControllerRead = context.read<SignUpController>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 70),
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
              20.verticalSpace,
              const Text(
                'Sign Up',
                style: TextStyle(fontSize: 24, color: MyColor.appColor, fontWeight: FontWeight.bold),
              ),
              CustomTextField(headerText: 'First Name',
                  controller: signUpControllerRead.firstNameController),
              20.verticalSpace,
              CustomTextField(headerText: 'Last Name',
                  controller: signUpControllerRead.lastNameController,
              ),
              20.verticalSpace,
              CustomTextField(headerText: 'Phone Number',
                controller: signUpControllerRead.phoneNumberController, keyboardType: TextInputType.phone),
              20.verticalSpace,
              CustomTextField(headerText: 'Email',
                controller: signUpControllerRead.emailController, keyboardType: TextInputType.emailAddress),
              20.verticalSpace,
              CustomTextField(headerText: 'Password',
              controller: signUpControllerRead.passwordController,
                  obscureText: true),
              20.verticalSpace,
              ButtonWidget(buttonText: 'Sign up', fontSize: MyDimension.dim16,
              textColor: Colors.white,
              buttonColor: MyColor.appColor,
              onPressed:signUpController.isLoading ? null : () => signUpControllerRead.signUp(),
                isLoading: signUpController.isLoading,),
              20.verticalSpace,
              GestureDetector(
                onTap: ()
                {
                  routerConfig.pushReplacement(RoutesPath.loginScreen);
                  signUpControllerRead.isLoading = false;

                  },
                child: const CustomText(
                  requiredText: '...Or Login?',
                  color: MyColor.appColor,
                  fontSize: MyDimension.dim22,
                  fontWeight: FontWeight.bold,
                  textDecoration: TextDecoration.underline,
                ),
              ),
              70.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}