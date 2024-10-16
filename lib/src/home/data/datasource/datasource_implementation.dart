import 'dart:convert';

import 'package:buub/core/constants/api_constants.dart';
import 'package:buub/core/constants/db_keys.dart';
import 'package:buub/core/errors/api_exception.dart';
import 'package:buub/core/errors/api_failure.dart';
import 'package:buub/core/errors/log_helper.dart';
import 'package:buub/core/internet_helper/internet_connection.dart';
import 'package:buub/src/home/data/datasource/datasource.dart';
import 'package:buub/src/home/data/models/post_model.dart';
import 'package:buub/src/home/data/models/posts_model.dart';
import 'package:buub/src/home/domain/entities/post.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

class DatasourceImplementation implements Datasource {
  final Dio _dio;

  static const String _key = DbKeys.key;

  late Box<PostsModel> _postBox;
  DatasourceImplementation({required Dio dio}) : _dio = dio;

  @override
  Future<void> initDatabase() async {
    try {
      Hive.registerAdapter(PostsModelAdapter());
      Hive.registerAdapter(PostModelAdapter());
      _postBox = await Hive.openBox(_key);
    } catch (e) {
      logger.d(e);
      throw (APIFailure(statusCode: 404, message: e.toString()));
    }
  }

  @override
  Future<List<Post>> fetchPosts() async {
    final bool isConnected = await const InternetConnection().checkConnection();

    if (isConnected) {
      try {
        // await initDatabase();
        final response = await _dio
            .request(apiUrl, options: Options(method: 'GET'))
            .onError((DioException err, StackTrace stackTrace) {
          logger.d(err.message);
          throw (APIException(
              statusCode: err.response!.statusCode, message: err.message));
        });

        if (response.statusCode != 200) {
          logger.d(response);
          throw APIException(
              statusCode: response.statusCode, message: response.statusMessage);
        }

        final PostsModel posts =
            PostsModel(message: "Success", posts: response.data);
        logger.d(posts);
        _postBox.put(_key, posts);
        if (_postBox.isOpen && _postBox.isNotEmpty) {
          final response = _postBox.get(_key);
          return response!.posts
              .map((post) => PostModel.fromMap(post))
              .toList();
        } else {
          throw (const APIException(
              statusCode: 505, message: "Error fetching from local db"));
        }
      } on APIException {
        rethrow;
      } catch (e) {
        logger.d(e);
        throw (APIException(statusCode: 505, message: e.toString()));
      }
    } else {
      try {
        if (_postBox.isOpen && _postBox.isNotEmpty) {
          final response = _postBox.get(_key);
          return response!.posts
              .map((post) => PostModel(
                  id: post['id'],
                  userId: post['userId'],
                  title: post['title'],
                  body: post['body']))
              .toList();
        } else {
          throw (const APIException(
              statusCode: 505,
              message: "No internet and no data in the local database"));
        }
      } on APIException {
        rethrow;
      } catch (e) {
        logger.d(e);
        throw (APIException(statusCode: 505, message: e.toString()));
      }
    }
  }

  @override
  Future<Post> getPost({required int id}) async {
    final bool isConnected = await const InternetConnection().checkConnection();
    if (isConnected) {
      try {
        final response =
            await _dio.request(apiUrl, options: Options(method: 'GET')).onError(
          (DioException error, stackTrace) {
            logger.d(error.message);
            throw (APIException(
                statusCode: error.response?.statusCode,
                message: error.message));
          },
        );
        if (response.statusCode != 200) {
          logger.d(response.statusMessage);
          throw (APIException(
              statusCode: response.statusCode,
              message: response.statusMessage));
        }

        return PostModel.fromMap(jsonDecode(response.data));
      } on APIException {
        rethrow;
      } catch (e) {
        logger.d(e);
        throw (APIException(statusCode: 505, message: e.toString()));
      }
    } else {
      try {
        if (_postBox.isOpen && _postBox.isNotEmpty) {
          final response = _postBox.get(_key);
          return response!.posts.firstWhere((post) => post.id == id);
        }
      } on APIException {
        rethrow;
      } catch (e) {
        logger.d(e);
        throw (APIException(statusCode: 505, message: e.toString()));
      }
    }
    throw (const APIException(
        message: "Error request no successful", statusCode: 505));
  }
}
