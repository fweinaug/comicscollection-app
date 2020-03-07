import 'package:flutter/material.dart';

class Cover extends StatelessWidget {
  const Cover({
    Key key,
  }) : super(key: key);
    this.height = 100.0,

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: height * 0.6875,
      height: height,
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(3.0),
      ),
    );
  }
}
