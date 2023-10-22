import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jvec_assessment_frontend/src/constants/color.dart';
import 'package:jvec_assessment_frontend/src/reusables/dimension.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String) onChanged;

  const CustomSearchBar({super.key,
    required this.controller, required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: SearchBar(
        controller: controller,
        onChanged: onChanged,
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),),
        backgroundColor: MaterialStateProperty.all(Colors.white), // Background color
        padding: MaterialStateProperty.all(const EdgeInsets.all(12.0)),
        shadowColor: const MaterialStatePropertyAll(Colors.white),
        hintStyle: MaterialStateProperty.all( GoogleFonts.roboto(
          color: MyColor.textColor.withOpacity(0.5), fontSize: MyDimension.dim14,
        )),
        hintText: "Search...",
        trailing: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: GestureDetector(
                child: Icon(Icons.search, size: 25, color: MyColor.textColor.withOpacity(0.5),)),
          )
          ],
      ),
    );
  }
}
