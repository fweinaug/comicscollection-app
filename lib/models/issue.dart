import 'package:comics_app/models/image.dart';
import 'package:json_annotation/json_annotation.dart';

part 'issue.g.dart';

@JsonSerializable(nullable: false, fieldRename: FieldRename.snake, createToJson: false)
class Issue {
  final int id;
  final int number;
  final String title;
  final Image image;
  final String summary;
  final String releaseDate;
  final bool read;
  final DateTime createdAt;
  final DateTime updatedAt;

  Issue({
    this.id,
    this.number,
    this.title,
    this.image,
    this.summary,
    this.releaseDate,
    this.read,
    this.createdAt,
    this.updatedAt,
  });

  factory Issue.fromJson(Map<String, dynamic> json) => _$IssueFromJson(json);
}
