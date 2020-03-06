import 'package:comics_app/models/comic.dart';
import 'package:comics_app/models/issue.dart';
import 'package:comics_app/widgets/buttons.dart';
import 'package:comics_app/widgets/cover.dart';
import 'package:comics_app/widgets/line.dart';
import 'package:comics_app/widgets/overlay.dart';
import 'package:comics_app/widgets/text.dart';
import 'package:flutter/material.dart' hide CloseButton;

class IssueOverlay extends StatelessWidget {
  const IssueOverlay(
    this.comic,
    this.issue, {
      Key key,
  }) : super(key: key);

  final Comic comic;
  final Issue issue;

  @override
  Widget build(BuildContext context) {
    return ModalOverlay(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 15.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Cover(),
                SizedBox(width: 9.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          ReadButton(
                            issue: issue,
                          ),
                          SizedBox(width: 8.0),
                          EditButton(
                            comic: comic,
                            issue: issue,
                          ),
                          SizedBox(width: 8.0),
                          CloseButton(),
                        ],
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        comic.name,
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                      Text(
                        issue.title,
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Line(),
                Text(issue.summary),
                SizedBox(height: 15.0),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: LabeledText(
                        label: 'Released:',
                        text: 'May 6, 2015',
                      ),
                    ),
                    Expanded(
                      child: LabeledText(
                        label: 'Added:',
                        text: 'April 18, 2018',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
