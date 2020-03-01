import 'package:comics_app/models/comic.dart';
import 'package:comics_app/models/issue.dart';
import 'package:comics_app/models/publisher.dart';
import 'package:comics_app/views/comic_page.dart';
import 'package:comics_app/views/issue_overlay.dart';
import 'package:comics_app/views/publisher_overlay.dart';
import 'package:flutter/material.dart';

class Router {
  static final GlobalKey<NavigatorState> _key = GlobalKey<NavigatorState>();

  static GlobalKey<NavigatorState> get navigatorKey => _key;
  static NavigatorState get _navigator => _key.currentState;

  static void showComic(Comic comic) {
    _navigator.push(MaterialPageRoute(
      builder: (_) => ComicPage(comic),
    ));
  }

  static void showPublisher(Publisher publisher) {
    showModalBottomSheet(context: _navigator.overlay.context,
      builder: (_) => PublisherOverlay(publisher),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
    );
  }

  static void showIssue(Comic comic, Issue issue) {
    showModalBottomSheet(context: _navigator.overlay.context,
      builder: (_) => IssueOverlay(comic, issue),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
    );
  }
}
