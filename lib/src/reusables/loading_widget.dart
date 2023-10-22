import 'package:flutter/material.dart';
import 'package:jvec_assessment_frontend/src/constants/color.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingWidget extends StatefulWidget {
  final Color? color;
  final double? size;
  const LoadingWidget({super.key, this.color, this.size});

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  @override
  Widget build(BuildContext context) {
    return LoadingAnimationWidget.fourRotatingDots(
        color: widget.color ?? MyColor.appColor, size: widget.size ?? 50);
  }
}
