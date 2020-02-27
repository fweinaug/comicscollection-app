import 'package:json_annotation/json_annotation.dart';

part 'person.g.dart';

@JsonSerializable(nullable: false, fieldRename: FieldRename.snake, createToJson: false)
class Person {
  final int id;
  final String name;
  final String firstName;
  final String lastName;
  final DateTime createdAt;
  final DateTime updatedAt;

  Person({
    this.id,
    this.name,
    this.firstName,
    this.lastName,
    this.createdAt,
    this.updatedAt,
  });

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);
}
