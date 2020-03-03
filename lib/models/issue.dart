import 'package:comics_app/models/image.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';

part 'issue.g.dart';

@JsonSerializable(nullable: false, fieldRename: FieldRename.snake, createToJson: false)
class Issue extends _Issue with _$Issue {
  Issue();

  factory Issue.fromJson(Map<String, dynamic> json) => _$IssueFromJson(json);
}

abstract class _Issue with Store {
  int id;
  int number;
  String title;
  Image image;
  String releaseDate;

  @observable
  String summary;

  @observable
  bool read;

  DateTime createdAt;
  DateTime updatedAt;
}
