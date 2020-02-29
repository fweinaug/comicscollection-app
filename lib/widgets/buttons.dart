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
          padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 8.0),
          child: SvgPicture.asset(
            'assets/icons/back.svg',
            width: 13.5,
            height: 10.0,
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
          padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 7.0),
          child: SvgPicture.asset(
            'assets/icons/close.svg',
            width: 10.5,
            height: 10.5,
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
          padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 8.0),
          child: SvgPicture.asset(
            'assets/icons/check.svg',
            width: 14.0,
            height: 11.0,
            color: Color(0xFF3AB88B),
          ),
        ),
      ),
    );
  }
}
