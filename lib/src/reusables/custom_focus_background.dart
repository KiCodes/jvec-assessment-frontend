import 'package:flutter/material.dart';

class CustomFocusBackground extends StatelessWidget {
  const CustomFocusBackground({
    super.key,
    required this.mediaQuery,
  });

  final Size mediaQuery;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: mediaQuery.width,
      height: mediaQuery.height,
      decoration: const BoxDecoration(color: Color(0x281B1818)),
    );
  }
}