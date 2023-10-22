
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jvec_assessment_frontend/src/constants/color.dart';

class ButtonWidget extends StatefulWidget {
  final void Function()? onPressed;
  final String? buttonText;
  final double fontSize;
  final bool? iconAllowed;
  final Icon? icon;
  final Color? textColor;
  final Widget? child;
  final Color? buttonColor;
  final Color? borderSideColor;
  final bool isLoading;

  const ButtonWidget({
    super.key,
    this.onPressed,
    required this.buttonText,
    required this.fontSize,
    this.icon,
    this.iconAllowed = false,
    this.textColor,
    this.child,
    this.buttonColor,
    this.borderSideColor, required this.isLoading
  });

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: SizedBox(
        width: double.infinity,
        height: 55.h,
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [buildBoxShadow()],
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: ElevatedButton(
            onPressed: widget.isLoading ? null : widget.onPressed,
            style: ButtonStyle(
              textStyle: MaterialStateTextStyle.resolveWith(
                (states) => GoogleFonts.lato(
                  fontSize: widget.fontSize,
                  fontWeight: FontWeight.w600,
                ),
              ),
              backgroundColor: const MaterialStatePropertyAll(MyColor.appColor),
              shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                (states) => RoundedRectangleBorder(
                  side: BorderSide(
                    color: widget.borderSideColor ?? Colors.transparent,
                    width: 1.w,
                  ),
                  borderRadius: BorderRadius.circular(30.r),
                ),
              ),
              elevation: const MaterialStatePropertyAll(1),
            ),
            child:
            widget.isLoading
                ? CircularProgressIndicator( // Show loading indicator when isLoading is true
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(widget.textColor ?? Colors.transparent),
            )
                : widget.child ??
                Text(
                  widget.buttonText ?? '',
                  style: GoogleFonts.lato(
                    color: widget.textColor ?? Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
          ),
        ),
      ),
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
