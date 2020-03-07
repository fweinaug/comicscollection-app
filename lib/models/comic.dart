import 'package:comics_app/models/image.dart';
import 'package:comics_app/models/issue.dart';
import 'package:comics_app/models/person.dart';
import 'package:comics_app/models/publisher.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';

part 'comic.g.dart';

@JsonSerializable(nullable: false, fieldRename: FieldRename.snake, createToJson: false)
class Comic extends _Comic with _$Comic {
  Comic();

  factory Comic.fromJson(Map<String, dynamic> json) => _$ComicFromJson(json);
}

abstract class _Comic with Store {
  int id;
  String name;
  Image image;
  int issuesTotal;
  int issuesCount;

  @observable
  int issuesRead;

  bool concluded;
  Publisher publisher;
  List<Creator> creators;
  List<Issue> issues;
  DateTime createdAt;
  DateTime updatedAt;

  bool get series => issuesCount > 1 || issuesTotal > 1 || !concluded;

  @computed
  bool get finished => issuesRead == issuesCount;

  @computed
  bool get reading => issuesRead > 0 && issuesRead < issuesTotal;

  @computed
  double get progress => issuesCount > 0 ? issuesRead / issuesCount : 0.0;

  @action
  void markIssueAsRead(Issue issue) {
    issue.read = true;

    ++issuesRead;
  }

  @action
  void markIssueAsUnread(Issue issue) {
    issue.read = false;

    --issuesRead;
  }
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
