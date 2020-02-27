import 'package:comics_app/models/image.dart';
import 'package:comics_app/models/issue.dart';
import 'package:comics_app/models/person.dart';
import 'package:comics_app/models/publisher.dart';
import 'package:json_annotation/json_annotation.dart';

part 'comic.g.dart';

@JsonSerializable(nullable: false, fieldRename: FieldRename.snake, createToJson: false)
class Comic {
  final int id;
  final String name;
  final Image image;
  final int issuesTotal;
  final int issuesCount;
  final int issuesRead;
  final bool concluded;
  final Publisher publisher;
  final List<Creator> creators;
  final List<Issue> issues;
  final DateTime createdAt;
  final DateTime updatedAt;

  Comic({
    this.id,
    this.name,
    this.image,
    this.issuesTotal,
    this.issuesCount,
    this.issuesRead,
    this.concluded,
    this.publisher,
    this.creators,
    this.issues,
    this.createdAt,
    this.updatedAt,
  });

  factory Comic.fromJson(Map<String, dynamic> json) => _$ComicFromJson(json);
}

@JsonSerializable(nullable: false, fieldRename: FieldRename.snake, createToJson: false)
class Creator {
  final Person person;
  final String contribution;

  Creator({
    this.person,
    this.contribution,
  });

  factory Creator.fromJson(Map<String, dynamic> json) => _$CreatorFromJson(json);
}
