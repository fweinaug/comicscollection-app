import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Cover extends StatelessWidget {
  const Cover({
    Key key,
    @required this.imageUrl,
    this.height = 100.0,
  }) : assert(imageUrl != null),
       super(key: key);

  final String imageUrl;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(3.0),
      child: CachedNetworkImage(
        width: height * 0.6875,
        height: height,
        imageUrl: imageUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}
