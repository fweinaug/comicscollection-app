import 'package:comics_app/models/publisher.dart';
import 'package:comics_app/widgets/buttons.dart';
import 'package:comics_app/widgets/line.dart';
import 'package:comics_app/widgets/overlay.dart';
import 'package:comics_app/widgets/text.dart';
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
                    Text(
                      publisher.name.toUpperCase(),
                      style: TextStyle(
                        fontFamily: 'Helvetica Neue Condensed',
                        fontSize: 18.0,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.4,
                      ),
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
                    LabeledText(
                      label: 'Founded:',
                      text: '${publisher.founded}',
                      extra: '${DateTime.now().year - publisher.founded} years ago',
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    LabeledText(
                      label: 'Website:',
                      text: publisher.websiteDomain,
                      onTap: () => _launchUrl(publisher.website),
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

void _launchUrl(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  }
}
