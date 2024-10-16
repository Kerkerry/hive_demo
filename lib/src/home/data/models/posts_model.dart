import 'dart:convert';

import 'package:buub/core/hive_helper/hive_types/hive_types.dart';
import 'package:buub/core/typedefs/typedefs.dart';
import 'package:buub/src/home/domain/entities/posts.dart';
import 'package:hive/hive.dart';
part 'posts_model.g.dart';

@HiveType(typeId: HiveTypes.postsModel)
class PostsModel extends Posts {
  const PostsModel({required super.message, required super.posts});

  PostsModel.fromMapa(DataMap map)
      : this(message: "Success", posts: map['data']);
  factory PostsModel.fromJson(String source) =>
      PostsModel.fromMapa(jsonDecode(source));
}
