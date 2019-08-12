import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class LogoIcon extends StatelessWidget {
  final Color color;
  final double size;

  const LogoIcon({Key key, this.color = Colors.white, this.size = 64})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      LineIcons.cubes,
      size: size,
      color: color,
    );
  }
}
