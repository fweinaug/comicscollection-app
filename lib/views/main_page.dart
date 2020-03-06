import 'package:animations/animations.dart';
import 'package:comics_app/models/comic.dart';
import 'package:comics_app/stores/comic_store.dart';
import 'package:comics_app/views/comic_page.dart';
import 'package:comics_app/widgets/card.dart';
import 'package:comics_app/widgets/cover.dart';
import 'package:flutter/material.dart' hide Card;
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Header(),
          Expanded(
            child: ComicList(),
          ),
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final issuesCount = Provider.of<ComicStore>(context).issuesCount;

    return Ink(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFD6D6D6),
            width: 1.0,
          ),
        )
      ),
      child: SafeArea(
        bottom: false,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
                child: Wrap(
                  spacing: 5.0,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: <Widget>[
                    SvgPicture.asset(
                      'assets/icons/comics.svg',
                      width: 11.0,
                      height: 12.0,
                    ),
                    Text(
                      issuesCount.toString(),
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w200,
                        color: Color(0xFF676767),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: MenuButton(),
            ),
            Text(
              'COMICS',
              style: TextStyle(
                fontFamily: 'Helvetica Neue Condensed',
                fontSize: 20.0,
                fontWeight: FontWeight.w900,
                color: Color(0xFF3AB88B),
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuButton extends StatefulWidget {
  @override
  _MenuButtonState createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _showMenu,
      customBorder: CircleBorder(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
        child: SvgPicture.asset(
          'assets/icons/more.svg',
          width: 4.0,
          height: 16.0,
        ),
      ),
    );
  }

  void _showMenu() async {
    final RenderBox button = context.findRenderObject();
    final RenderBox overlay = Overlay.of(context).context.findRenderObject();
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset.zero, ancestor: overlay),
        button.localToGlobal(button.size.bottomRight(Offset.zero), ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );

    final selectedItem = await showMenu(
      context: context,
      position: position,
      items: [
        PopupMenuItem(
          child: Text('About'),
          value: 'about',
        ),
      ],
    );

    if (selectedItem == 'about') {
      showAboutDialog(context: context);
    }
  }
}

class ComicList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final comics = Provider.of<ComicStore>(context).comics;

    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 30.0),
      itemCount: comics.length,
      itemBuilder: (context, index) {
        final comic = comics[index];

        return OpenContainer(
          transitionType: ContainerTransitionType.fadeThrough,
          openBuilder: (context, _) => ComicPage(comic),
          closedBuilder: (context, openContainer) => ComicTile(
            comic: comic,
            onTap: openContainer,
          ),
          tappable: false,
        );
      },
      separatorBuilder: (context, index) => SizedBox(height: 10.0),
    );
  }
}

class ComicTile extends StatelessWidget {
  const ComicTile({
    Key key,
    @required this.comic,
    this.onTap,
  }) : assert(comic != null),
       super(key: key);

  final Comic comic;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      padding: EdgeInsets.all(0.0),
      child: Material(
        borderRadius: BorderRadius.circular(3.0),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(3.0, 3.0, 10.0, 3.0),
                    child: Cover(),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        comic.name,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 2.0,
                      ),
                      Text(
                        'Creator',
                        style: TextStyle(
                          fontSize: 12.0,
                        ),
                      ),
                      Text(
                        comic.publisher.name,
                        style: TextStyle(
                          fontSize: 12.0,
                        ),
                      ),
                      SizedBox(
                        height: 14.0,
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
                ],
              ),
              ComicProgress(
                comic: comic,
                width: 5.0,
                height: 86.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ComicProgress extends StatelessWidget {
  const ComicProgress({
    Key key,
    @required this.comic,
    @required this.width,
    @required this.height,
  }) : assert(comic != null),
       assert(width != null && width > 0),
       assert(height != null && height > 0),
       super(key: key);

  final Comic comic;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Stack(
        children: <Widget>[
          Ink(
            width: width,
            height: height,
            color: comic.finished ? Color(0xFF3AB88B).withOpacity(comic.concluded ? 1.0 : 0.5) : Color(0xFFECECEC),
          ),
          if (comic.reading) Positioned(
            bottom: 0.0,
            child: Ink(
              width: width,
              height: height * comic.progress,
              color: Color(0xFFFFCD35),
            ),
          ),
        ],
      ),
    );
  }
}
