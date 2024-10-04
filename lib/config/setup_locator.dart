import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../data/repository/app_repository.dart';
import '../data/source/data_souce.dart';
import '../feature/post/post_bloc/post_bloc.dart';

final locator = GetIt.instance;

void setupLocator() {
  /// network
  locator.registerLazySingleton<Network>(() {
    final client = DioService(dio: Dio());
    client.configuration(Api.baseUrl);
    return client;
  });

  /// repository
  locator.registerLazySingleton<AppRepository>(
      () => AppRepositoryImpl(network: locator()));

  /// bloc
  locator
      .registerLazySingleton<PostBloc>(() => PostBloc(repository: locator()));
}
