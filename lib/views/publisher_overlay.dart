import 'package:comics_app/widgets/buttons.dart';
import 'package:comics_app/widgets/line.dart';
import 'package:comics_app/widgets/overlay.dart';
import 'package:flutter/material.dart' hide CloseButton;

class PublisherOverlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ModalOverlay(
      child: Column(
        children: <Widget>[
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  CloseButton(),
                  SizedBox(width: 12.0),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 80.0,
                      height: 35.0,
                      color: Colors.black12,
                    ),
                    Line(),
                    Text(
                      'This is a short description of this publisher. It can be very long so we have to make sure it gets wrapped into multiple lines. This is a short description of this publisher. It can be very long so we have to make sure it gets wrapped into multiple lines.',
                      style: TextStyle(
                        fontSize: 14.0,
                        height: 1.2,
                      ),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Text(
                      'Website:',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Color(0xFF676767),
                      ),
                    ),
                    Text(
                      'example.com',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
