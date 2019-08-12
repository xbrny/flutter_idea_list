import 'package:flutter/material.dart';
import 'package:idea_list/constant/constant.dart';

class GradientContainer extends StatelessWidget {
  final double height;
  final Widget child;
  final EdgeInsets padding;

  const GradientContainer({
    Key key,
    this.height,
    this.child,
    this.padding = const EdgeInsets.all(kSpaceLarge),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      height: height,
      decoration: BoxDecoration(
        gradient: kAppLinearGradient,
        boxShadow: [
          BoxShadow(
            color: kIdeaOrange100.withOpacity(0.3),
            offset: Offset(0, 8),
            blurRadius: 10,
          ),
        ],
      ),
      child: child,
    );
  }
}
