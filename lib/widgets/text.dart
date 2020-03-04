import 'package:flutter/material.dart';

class LabeledText extends StatelessWidget {
  const LabeledText({
    Key key,
    @required this.label,
    @required this.text,
    this.onTap,
  }) : assert(label != null),
       assert(text != null),
       super(key: key);

  final String label;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.vertical,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
            fontSize: 14.0,
            color: Color(0xFF676767),
          ),
        ),
        _buildText(),
      ],
    );
  }

  _buildText() {
    final child = Text(
      text,
      style: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
        decoration: onTap != null ? TextDecoration.underline : null,
      ),
    );

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: child,
      );
    }

    return child;
  }
}
