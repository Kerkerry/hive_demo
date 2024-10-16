import 'package:buub/core/hive_helper/hive_fields/post_fields.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

class Post extends Equatable {
  @HiveField(PostFields.userId)
  final int userId;
  @HiveField(PostFields.id)
  final int id;
  @HiveField(PostFields.title)
  final String title;
  @HiveField(PostFields.body)
  final String body;

  const Post(
      {required this.userId,
      required this.id,
      required this.title,
      required this.body});

  @override
  List<Object?> get props => [userId, id, title, body];
}
