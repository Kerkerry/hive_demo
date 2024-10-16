import 'package:buub/core/hive_helper/hive_fields/posts_fields.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

class Posts extends Equatable {
  @HiveField(PostsFields.message)
  final String message;
  @HiveField(PostsFields.posts)
  final List posts;

  const Posts({required this.message, required this.posts});

  @override
  List<Object?> get props => [];
}
