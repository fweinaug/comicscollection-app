import 'package:flutter/material.dart';

class Card extends StatelessWidget {
  const Card({Key key, this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(3.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            offset: Offset.zero,
            blurRadius: 10.0,
            spreadRadius: 0.0,
            color: Colors.black.withOpacity(0.15),
          ),
        ],
      ),
      child: child,
    );
  }
}
