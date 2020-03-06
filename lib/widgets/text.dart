import 'package:flutter/material.dart';

class LabeledText extends StatelessWidget {
  const LabeledText({
    Key key,
    @required this.label,
    @required this.text,
    this.extra,
    this.onTap,
  }) : assert(label != null),
       assert(text != null),
       super(key: key);

  final String label;
  final String text;
  final String extra;
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
    final child = Wrap(
      spacing: 5.0,
      crossAxisAlignment: WrapCrossAlignment.end,
      children: <Widget>[
        Text(
          text,
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            decoration: onTap != null ? TextDecoration.underline : null,
          ),
        ),
        if (extra != null && extra.isNotEmpty) Text('($extra)',
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w200,
          ),
        ),
      ],
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
