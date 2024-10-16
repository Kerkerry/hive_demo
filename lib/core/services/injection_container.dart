import 'package:buub/core/internet_helper/internet_connection.dart';
import 'package:buub/src/home/data/datasource/datasource.dart';
import 'package:buub/src/home/data/datasource/datasource_implementation.dart';
import 'package:buub/src/home/data/repositories/post_repository_implementation.dart';
import 'package:buub/src/home/domain/repositories/post_repository.dart';
import 'package:buub/src/home/domain/usecases/fetch_all_posts.dart';
import 'package:buub/src/home/domain/usecases/fetch_post.dart';
import 'package:buub/src/home/presentation/bloc/post_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await Hive.initFlutter();
  sl
    ..registerFactory(() => PostBloc(post: sl(), posts: sl()))
    ..registerLazySingleton(() => FetchPost(repository: sl()))
    ..registerLazySingleton(() => FetchAllPosts(repository: sl()))
    ..registerLazySingleton<PostRepository>(
        () => PostRepositoryImplementation(datasource: sl()))
    ..registerLazySingleton<Datasource>(
        () => DatasourceImplementation(dio: sl()))
    ..registerLazySingleton(() => Dio())
    ..registerLazySingleton(() => const InternetConnection());
  await sl<Datasource>().initDatabase();
}
