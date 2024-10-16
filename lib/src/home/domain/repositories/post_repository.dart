import 'package:buub/core/typedefs/typedefs.dart';
import 'package:buub/src/home/domain/entities/post.dart';

abstract class PostRepository {
  const PostRepository();
  ResultFuture<List<Post>> fetchAllPosts();
  ResultFuture<Post> fetchPost({required int id});
}
