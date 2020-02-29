import 'package:flutter/material.dart';

class ModalOverlay extends StatelessWidget {
  const ModalOverlay({
    Key key,
    this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                offset: Offset.zero,
                blurRadius: 20.0,
                spreadRadius: 10.0,
                color: Colors.black.withOpacity(0.25),
              ),
            ],
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 4.0, bottom: 5.0),
                child: Container(
                  width: 50.0,
                  height: 3.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFECECEC),
                    borderRadius: BorderRadius.circular(1.5),
                  ),
                ),
              ),
              child,
            ],
          ),
        ),
      ],
    );
  }
}
