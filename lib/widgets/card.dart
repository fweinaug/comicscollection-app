import 'package:flutter/material.dart';

class Card extends StatelessWidget {
  const Card({
    Key key,
    this.child,
    this.padding = const EdgeInsets.all(10.0),
  }) : super(key: key);

  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
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
