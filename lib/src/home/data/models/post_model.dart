import 'dart:convert';

import 'package:buub/core/hive_helper/hive_types/hive_types.dart';
import 'package:buub/core/typedefs/typedefs.dart';
import 'package:buub/src/home/domain/entities/post.dart';
import 'package:hive/hive.dart';

part 'post_model.g.dart';

@HiveType(typeId: HiveTypes.postModel)
class PostModel extends Post {
  const PostModel(
      {required super.userId,
      required super.id,
      required super.title,
      required super.body});

  PostModel.fromMap(DataMap map)
      : this(
            id: map['id'],
            userId: map['userId'],
            title: map['title'],
            body: map['body']);
  factory PostModel.fromJson(String json) =>
      PostModel.fromMap(jsonDecode(json));
}
