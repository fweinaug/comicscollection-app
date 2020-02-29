import 'package:comics_app/widgets/buttons.dart';
import 'package:comics_app/widgets/card.dart';
import 'package:comics_app/widgets/cover.dart';
import 'package:comics_app/widgets/line.dart';
import 'package:flutter/material.dart' hide Card, BackButton;

class ComicPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Header(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 30.0, 15.0, 10.0),
                  child: Issues(),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 20.0),
                  child: IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Expanded(
                          child: Creators(),
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Expanded(
                          child: Details(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 15.0,
            top: 15.0 + MediaQuery.of(context).padding.top,
            child: BackButton(),
          ),
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          bottom: 15.0,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.black26,
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.fromLTRB(15.0, 110.0 + MediaQuery.of(context).padding.top, 15.0, 0.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: MediaQuery.of(context).size.width,
              ),
              child: Card(
                child: Text(
                  'COMIC TITLE',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Helvetica Neue Condensed',
                    fontSize: 24.0,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF8C2B23),
                    letterSpacing: 1.0,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class Issues extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'ISSUES',
                style: TextStyle(
                  fontFamily: 'Helvetica Neue Condensed',
                  fontSize: 18.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                '0 / 4',
                style: TextStyle(
                  fontSize: 10.0,
                ),
              ),
            ],
          ),
          Line(),
          ListView.separated(
            shrinkWrap: true,
            primary: false,
            padding: EdgeInsets.all(0.0),
            itemCount: 4,
            itemBuilder: (context, index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Material(
                      type: MaterialType.transparency,
                      borderRadius: BorderRadius.circular(3.0),
                      clipBehavior: Clip.antiAlias,
                      child: InkWell(
                        onTap: () {},
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Cover(),
                            SizedBox(width: 9.0),
                            Text(
                              'Title',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: ReadButton(),
                  ),
                ],
              );
            },
            separatorBuilder: (context, index) => SizedBox(height: 8),
          ),
        ],
      ),
    );
  }
}

class Creators extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'CREATORS',
            style: TextStyle(
              fontFamily: 'Helvetica Neue Condensed',
              fontSize: 18.0,
              fontWeight: FontWeight.w800,
            ),
          ),
          Line(),
        ],
      ),
    );
  }
}

class Details extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'DETAILS',
            style: TextStyle(
              fontFamily: 'Helvetica Neue Condensed',
              fontSize: 18.0,
              fontWeight: FontWeight.w800,
            ),
          ),
          Line(),
          Text(
            'Publisher:',
            style: TextStyle(
              fontSize: 14.0,
              color: Color(0xFF676767),
            ),
          ),
          Text(
            'Publisher',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.underline,
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            'Series:',
            style: TextStyle(
              fontSize: 14.0,
              color: Color(0xFF676767),
            ),
          ),
          Text(
            '4 / 4',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            'Years:',
            style: TextStyle(
              fontSize: 14.0,
              color: Color(0xFF676767),
            ),
          ),
          Text(
            '2014 – 2018',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            'Added:',
            style: TextStyle(
              fontSize: 14.0,
              color: Color(0xFF676767),
            ),
          ),
          Text(
            'April 12, 2018',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
