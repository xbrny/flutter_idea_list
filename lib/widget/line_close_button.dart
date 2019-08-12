import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class LineCloseButton extends StatelessWidget {
  final IconData iconData;

  const LineCloseButton({
    Key key,
    this.iconData = LineIcons.close,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        iconData,
        color: Colors.white,
      ),
      onPressed: () {
        Navigator.maybePop(context);
      },
    );
  }
}
