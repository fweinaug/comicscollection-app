import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Cover extends StatelessWidget {
  const Cover({
    Key key,
    @required this.imageUrl,
    this.height = 100.0,
    this.title = '',
  }) : assert(imageUrl != null),
       super(key: key);

  final String imageUrl;
  final double height;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(3.0),
      child: CachedNetworkImage(
        width: height * 0.6875,
        height: height,
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        placeholder: (_, __) => Container(
          width: height * 0.6875,
          height: height,
          color: Color(0xFFD6D6D6),
          padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 5.0),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 8.0,
              fontWeight: FontWeight.w600,
              color: Color(0xFF676767),
            ),
          ),
        ),
      ),
    );
  }
}
