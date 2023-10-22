import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jvec_assessment_frontend/src/constants/color.dart';

class CustomTextField extends StatelessWidget {
  final String headerText;
  final String? labelText;
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? prefix;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final Widget? suffixIcon;
  final TextInputAction? textInputAction;
  final Widget? suffix;
  final Color? fillColor;

  const CustomTextField({
    super.key,
    required this.headerText,
    this.labelText,
    this.hintText,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.validator,
    this.onChanged,
    this.suffixIcon,
    this.prefix,
    this.textInputAction,
    this.suffix,
    this.fillColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          headerText,
          style: GoogleFonts.lato(
              fontWeight: FontWeight.w700,
              fontSize: 14.sp,
              color: const Color(0xFF475466)),
        ),
        SizedBox(height: 5.h),
        Container(
          decoration: BoxDecoration(
            boxShadow: [buildBoxShadow()],
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: TextFormField(
            onTapOutside: (event) {
              SystemChannels.textInput.invokeMethod('TextInput.hide');
            },
            validator: validator,
            onChanged: onChanged,
            controller: controller,
            keyboardType: keyboardType,
            obscureText: obscureText,
            textCapitalization: TextCapitalization.words,
            textInputAction: textInputAction,
            cursorColor: MyColor.appColor,
            decoration: InputDecoration(
                fillColor: fillColor ?? Colors.white,
                filled: true,
                suffix: suffix,
                prefixIcon: prefix,
                suffixIcon: suffixIcon,
                labelText: labelText,
                labelStyle: GoogleFonts.lato(
                  color: const Color(0xFF475466),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                ),
                hintStyle: GoogleFonts.lato(
                  fontSize: 16.sp,
                ),
                hintText: hintText,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0.r),
                  borderSide: BorderSide(
                    width: 1.w,
                    color: const Color(
                      0xFFCFD4DC,
                    ),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.r),
                  borderSide: const BorderSide(color: MyColor.appColor),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: const BorderSide(color: Colors.red),
                )),
          ),
        ),
      ],
    );
  }
  BoxShadow buildBoxShadow() {
    return BoxShadow(
      color: Colors.grey.withOpacity(0.5), // Shadow color
      offset: const Offset(0, 3), // Offset (x, y)
      blurRadius: 4, // Blur radius
      spreadRadius: 1, // Spread radius
    );
  }
}