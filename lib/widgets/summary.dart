import 'package:flutter/material.dart';

class Summary extends StatelessWidget {
  const Summary(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    if (text != null && text.isNotEmpty) {
      return Text(text);
    }

    return Center(
      child: Text('There is no summary for this issue yet :(',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w200,
          color: Color(0xFF676767),
        ),
      ),
    );
  }
}
