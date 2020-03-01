import 'package:comics_app/router.dart';
import 'package:comics_app/stores/comic_store.dart';
import 'package:comics_app/views/main_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(ComicApp());

class ComicApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => ComicStore(),
      child: MaterialApp(
        title: 'Comic Collection',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Helvetica Neue',
          scaffoldBackgroundColor: Color(0xFFECECEC),
        ),
        navigatorKey: Router.navigatorKey,
        home: MainPage(),
      ),
    );
  }
}
