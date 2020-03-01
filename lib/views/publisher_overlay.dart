import 'package:comics_app/models/publisher.dart';
import 'package:comics_app/widgets/buttons.dart';
import 'package:comics_app/widgets/line.dart';
import 'package:comics_app/widgets/overlay.dart';
import 'package:flutter/material.dart' hide CloseButton;
import 'package:url_launcher/url_launcher.dart';

class PublisherOverlay extends StatelessWidget {
  const PublisherOverlay(
    this.publisher, {
      Key key,
  }) : super(key: key);

  final Publisher publisher;

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
                      publisher.description,
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
                    GestureDetector(
                      onTap: () => _launchUrl(publisher.website),
                      child: Text(
                        publisher.websiteDomain,
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                        ),
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

_launchUrl(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  }
}
