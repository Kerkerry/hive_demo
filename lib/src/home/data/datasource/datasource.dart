import 'package:buub/src/home/domain/entities/post.dart';

abstract class Datasource {
  const Datasource();
  Future<List<Post>> fetchPosts();
  Future<Post> getPost({required int id});
  Future<void> initDatabase();
}
