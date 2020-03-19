import 'package:comics_app/models/comic.dart';
import 'package:comics_app/models/issue.dart';
import 'package:comics_app/router.dart';
import 'package:comics_app/stores/comic_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class BackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(0xFFECECEC),
      elevation: 5.0,
      shape: CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => Navigator.pop(context),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: SvgPicture.asset(
            'assets/icons/back.svg',
            width: 13.0,
            height: 13.0,
            color: Color(0xFF777777),
          ),
        ),
      ),
    );
  }
}

class CloseButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(0xFFECECEC),
      elevation: 1.0,
      shape: CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => Navigator.pop(context),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: SvgPicture.asset(
            'assets/icons/close.svg',
            width: 15.0,
            height: 15.0,
            color: Color(0xFF777777),
          ),
        ),
      ),
    );
  }
}

class ReadButton extends StatefulWidget {
  const ReadButton({
    Key key,
    @required this.issue,
  }) : assert(issue != null),
       super(key: key);

  final Issue issue;

  @override
  _ReadButtonState createState() => _ReadButtonState();
}

class _ReadButtonState extends State<ReadButton> with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  bool _pressed = false;

  initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      reverseDuration: Duration(milliseconds: 0),
      value: 1.0,
      vsync: this,
    )..addStatusListener((status) {
      if (status == AnimationStatus.dismissed && !_pressed) {
        _controller.forward();
      }
    });

    _animation = CurvedAnimation(parent: _controller, curve: Curves.elasticOut);
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Material(
        color: Color(widget.issue.read ? 0xFF3AB88B : 0xFFECECEC),
        elevation: 1.0,
        shape: CircleBorder(),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          highlightColor: Color(0xFF3AB88B),
          onTapDown: (_) {
            _pressed = true;

            if (!widget.issue.read) {
              _controller.reverse();
            }
          },
          onTapCancel: () {
            _pressed = false;

            _controller.forward();
          },
          onTap: () async {
            _pressed = false;

            final store = Provider.of<ComicStore>(context, listen: false);
            await store.toggleRead(widget.issue);

            if (_controller.status == AnimationStatus.dismissed) {
              _controller.forward();
            }
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 11.0, 10.0, 9.0),
            child: ScaleTransition(
              scale: _animation,
              alignment: Alignment.center,
              child: SvgPicture.asset(
                'assets/icons/check.svg',
                width: 15.0,
                height: 15.0,
                color: Color(widget.issue.read ? 0xFFFFFFFF : 0xFF3AB88B),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class EditButton extends StatelessWidget {
  const EditButton({
    Key key,
    @required this.comic,
    @required this.issue,
  }) : assert(comic != null),
       assert(issue != null),
       super(key: key);

  final Comic comic;
  final Issue issue;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(0xFFECECEC),
      elevation: 1.0,
      shape: CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => Router.editIssue(comic, issue),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: SvgPicture.asset(
            'assets/icons/text.svg',
            width: 15.0,
            height: 15.0,
            color: Color(0xFF777777),
          ),
        ),
      ),
    );
  }
}
