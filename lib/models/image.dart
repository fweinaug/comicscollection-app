import 'package:json_annotation/json_annotation.dart';

part 'image.g.dart';

@JsonSerializable(nullable: false, fieldRename: FieldRename.snake, createToJson: false)
class Image {
  final String imageUrl;
  final String thumbnailUrl;

  Image({
    this.imageUrl,
    this.thumbnailUrl,
  });

  factory Image.fromJson(Map<String, dynamic> json) => _$ImageFromJson(json);
}
