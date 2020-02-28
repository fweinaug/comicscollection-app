import 'package:comics_app/router.dart';
import 'package:comics_app/widgets/card.dart';
import 'package:comics_app/widgets/cover.dart';
import 'package:flutter/material.dart' hide Card;
import 'package:flutter_svg/flutter_svg.dart';

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
                      '9',
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
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 30.0),
      itemCount: 4,
      itemBuilder: (context, index) {
        return ComicTile(
          onTap: () => Router.showComic(),
        );
      },
      separatorBuilder: (context, index) => SizedBox(height: 10.0),
    );
  }
}

class ComicTile extends StatelessWidget {
  const ComicTile({Key key, this.onTap}) : super(key: key);

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Material(
        borderRadius: BorderRadius.circular(3.0),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(3.0, 3.0, 10.0, 3.0),
                child: Cover(),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Title',
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
                      'Publisher',
                      style: TextStyle(
                        fontSize: 12.0,
                      ),
                    ),
                    SizedBox(
                      height: 14.0,
                    ),
                    Text(
                      '0 / 4',
                      style: TextStyle(
                        fontSize: 10.0,
                      ),
                    ),
                  ],
                ),
              ),
              Ink(
                width: 5.0,
                height: 86.0,
                color: Color(0xFFECECEC),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
