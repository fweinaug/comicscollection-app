import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

class ReadButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(0xFFECECEC),
      elevation: 1.0,
      shape: CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 11.0, 10.0, 9.0),
          child: SvgPicture.asset(
            'assets/icons/check.svg',
            width: 15.0,
            height: 15.0,
            color: Color(0xFF3AB88B),
          ),
        ),
      ),
    );
  }
}
