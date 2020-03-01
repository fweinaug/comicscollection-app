import 'package:comics_app/models/image.dart';
import 'package:json_annotation/json_annotation.dart';

part 'publisher.g.dart';

@JsonSerializable(nullable: false, fieldRename: FieldRename.snake, createToJson: false)
class Publisher {
  final int id;
  final String name;
  @JsonKey(nullable: true)
  final Image image;
  final String description;
  final String website;
  final DateTime createdAt;
  final DateTime updatedAt;

  final String websiteDomain;

  Publisher({
    this.id,
    this.name,
    this.image,
    this.description,
    this.website,
    this.createdAt,
    this.updatedAt,
  }) : websiteDomain = website != null ? Uri.parse(website).host : null;

  factory Publisher.fromJson(Map<String, dynamic> json) => _$PublisherFromJson(json);
}
