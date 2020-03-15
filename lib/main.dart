import 'package:comics_app/router.dart';
import 'package:comics_app/stores/comic_store.dart';
import 'package:comics_app/views/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

void main() => runApp(ComicApp());

class ComicApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ComicStore>(
          create: (_) => ComicStore(),
        ),
      ],
      child: MaterialApp(
        title: 'Comics Collection',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Helvetica Neue',
          scaffoldBackgroundColor: Color(0xFFECECEC),
        ),
        navigatorKey: Router.navigatorKey,
        home: Consumer<ComicStore>(
          builder: (context, store, child) => Observer(
            builder: (context) {
              if (store.initializeStatus != FutureStatus.fulfilled) {
                return SplashScreen();
              }

              return child;
            },
          ),
          child: MainPage(),
        ),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  @override
  initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 1000), vsync: this, value: 0.0);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.bounceOut);

    _controller.forward();
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF3AB88B),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ScaleTransition(
              scale: _animation,
              alignment: Alignment.center,
              child: Image.asset(
                'assets/images/logo_white.png',
                width: 100.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
