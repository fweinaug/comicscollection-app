import 'package:comics_app/views/comic_page.dart';
import 'package:comics_app/views/issue_overlay.dart';
import 'package:comics_app/views/publisher_overlay.dart';
import 'package:flutter/material.dart';

class Router {
  static final GlobalKey<NavigatorState> _key = GlobalKey<NavigatorState>();

  static GlobalKey<NavigatorState> get navigatorKey => _key;
  static NavigatorState get _navigator => _key.currentState;

  static void showComic() {
    _navigator.push(MaterialPageRoute(
      builder: (_) => ComicPage(),
    ));
  }

  static void showPublisher() {
    showModalBottomSheet(context: _navigator.overlay.context,
      builder: (_) => PublisherOverlay(),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
    );
  }

  static void showIssue() {
    showModalBottomSheet(context: _navigator.overlay.context,
      builder: (_) => IssueOverlay(),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
    );
  }
}
