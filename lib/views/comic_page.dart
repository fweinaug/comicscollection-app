import 'package:cached_network_image/cached_network_image.dart';
import 'package:comics_app/models/comic.dart';
import 'package:comics_app/models/issue.dart';
import 'package:comics_app/router.dart';
import 'package:comics_app/widgets/buttons.dart';
import 'package:comics_app/widgets/card.dart';
import 'package:comics_app/widgets/cover.dart';
import 'package:comics_app/widgets/line.dart';
import 'package:comics_app/widgets/summary.dart';
import 'package:comics_app/widgets/text.dart';
import 'package:flutter/material.dart' hide Card, BackButton;
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ComicPage extends StatelessWidget {
  const ComicPage(
    this.comic, {
    Key key,
  }) : super(key: key);

  final Comic comic;

  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: comic,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            SingleChildScrollView(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
              child: Column(
                children: <Widget>[
                  Header(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 30.0, 15.0, 10.0),
                    child: Builder(
                      builder: (context) => comic.series ? Issues() : SingleIssue(),
                    ),
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
      ),
    );
  }
}

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final comic = Provider.of<Comic>(context);

    return Stack(
      children: <Widget>[
        Positioned.fill(
          bottom: 15.0,
          child: CachedNetworkImage(
            imageUrl: comic.image.imageUrl,
            fit: BoxFit.cover,
            color: Colors.black.withOpacity(0.35),
            colorBlendMode: BlendMode.darken,
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
                  comic.name.toUpperCase(),
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
    final comic = Provider.of<Comic>(context);

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
                  letterSpacing: 0.4,
                ),
              ),
              Observer(
                builder: (_) => Text(
                  '${comic.issuesRead} / ${comic.issuesCount}',
                  style: TextStyle(
                    fontSize: 10.0,
                  ),
                ),
              ),
            ],
          ),
          Line(),
          ListView.separated(
            shrinkWrap: true,
            primary: false,
            padding: EdgeInsets.all(0.0),
            itemCount: comic.issues.length,
            itemBuilder: (context, index) {
              return IssueTile(
                issue: comic.issues[index],
              );
            },
            separatorBuilder: (context, index) => SizedBox(height: 8),
          ),
        ],
      ),
    );
  }
}

class SingleIssue extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final comic = Provider.of<Comic>(context);
    final issue = comic.issues.first;

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Cover(
                imageUrl: issue.image.thumbnailUrl,
              ),
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
                      ],
                    ),
                    SizedBox(height: 45.0),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Line(),
              Observer(
                builder: (context) => Summary(issue.summary),
              ),
              SizedBox(height: 25.0),
            ],
          ),
        ],
      ),
    );
  }
}

class IssueTile extends StatelessWidget {
  const IssueTile({
    Key key,
    this.issue,
  }) : super(key: key);

  final Issue issue;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: Material(
            type: MaterialType.transparency,
            borderRadius: BorderRadius.circular(3.0),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () => Router.showIssue(Provider.of<Comic>(context, listen: false), issue),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Cover(
                    height: 60.0,
                    imageUrl: issue.image.thumbnailUrl,
                  ),
                  SizedBox(width: 9.0),
                  Text(
                    issue.title,
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
          child: ReadButton(
            issue: issue,
          ),
        ),
      ],
    );
  }
}

class Creators extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final comic = Provider.of<Comic>(context);

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
              letterSpacing: 0.4,
            ),
          ),
          Line(),
          _buildList(comic.creators),
        ],
      ),
    );
  }

  _buildList(List<Creator> creators) {
    if (creators == null || creators.isEmpty) {
      return Expanded(
        child: Center(
          child: Container(
            width: 30.0,
            height: 3.0,
            color: Color(0xFFD6D6D6),
          ),
        ),
      );
    }  

    final list = List<Widget>();

    for (var i = 0; i < creators.length; ++i) {
      final creator = creators[i];

      list.add(Wrap(
        direction: Axis.vertical,
        spacing: 1.0,
        children: <Widget>[
          Text(
            creator.person.name,
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            creator.contribution.join(', '),
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w200,
              color: Color(0xFF676767),
            ),
          ),
        ],
      ));
    }

    return Wrap(
      direction: Axis.vertical,
      spacing: 10.0,
      children: list,
    );
  }
}

class Details extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final comic = Provider.of<Comic>(context);

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
              letterSpacing: 0.4,
            ),
          ),
          Line(),
          LabeledText(
            label: 'Publisher:',
            text: comic.publisher.name,
            onTap: () => Router.showPublisher(comic.publisher),
          ),
          if (comic.series) SizedBox(height: 10.0),
          if (comic.series) LabeledText(
            label: 'Series:',
            text: '${comic.issuesCount} / ${comic.issuesTotal > 0 ? comic.issuesTotal : '?'}',
            textColor: comic.incomplete ? Color(0xFF8C2B23) : null,
            extra: comic.concluded ? 'concluded' : 'ongoing',
          ),
          SizedBox(height: 10.0),
          LabeledText(
            label: comic.series ? 'Years:' : 'Released:',
            text: comic.series
              ? comic.years ?? '–'
              : comic.releaseDate != null ? DateFormat.yMMMMd().format(comic.releaseDate) : '–',
          ),
          SizedBox(height: 10.0),
          LabeledText(
            label: 'Added:',
            text: DateFormat.yMMMMd().format(comic.createdAt),
          ),
        ],
      ),
    );
  }
}
