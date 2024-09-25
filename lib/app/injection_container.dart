import 'package:base_code_bloc_flutter/core/util/bloc_observer.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

// import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/network/connection_status_listener/connection_status_bloc.dart';
import '../core/network/connectivity_services.dart';
import '../core/strings/messages.dart';
import '../core/util/app_localizations.dart';
import '../core/widgets/no_hero_widget.dart';
import '../features/posts/data/data_sources/local/post_local_data_source.dart';
import '../features/posts/data/data_sources/remote/post_remote_data_source.dart';
import '../features/posts/data/repositories/post_repository_impl.dart';
import '../features/posts/domain/entities/post_entity.dart';
import '../features/posts/domain/repositories/post_repository.dart';
import '../features/posts/domain/use_cases/add_post_use_case.dart';
import '../features/posts/domain/use_cases/delete_post_use_case.dart';
import '../features/posts/domain/use_cases/get_all_posts_use_case.dart';
import '../features/posts/domain/use_cases/update_post_use_case.dart';
import '../features/posts/presentation/bloc/add_delete_update_post/form_post_bloc.dart';
import '../features/posts/presentation/bloc/posts/posts_bloc.dart';
import '../features/posts/presentation/pages/post_details/post_detail_page.dart';
import '../features/posts/presentation/pages/post_form/post_form_page.dart';
import '../features/posts/presentation/pages/posts/posts_page.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Set the Bloc observer
  sl.registerLazySingleton(() => MyBlocObserver());
  Bloc.observer = sl<MyBlocObserver>();

  // External dependencies
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  // sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => Connectivity());

  // sl.registerLazySingleton(() => getLocalizedFailureMessages(context));
  // Localized failure messages
  // sl.registerLazySingleton<Map<Type, String>>(
  //         () => getLocalizedFailureMessages());

  // Core
  // sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<ConnectivityService>(
      () => ConnectivityService(sl()));

  // Data sources
  sl.registerLazySingleton<PostRemoteDataSource>(
      () => PostRemoteImplWithHttp(client: sl()));
  sl.registerLazySingleton<PostLocalDataSource>(
      () => PostLocalImplWithShares(sharedPreferences: sl()));

  // Repository
  sl.registerLazySingleton<PostRepository>(
    () => PostRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetAllPostsUseCase(sl()));
  sl.registerLazySingleton(() => AddPostUseCase(sl()));
  sl.registerLazySingleton(() => DeletePostUseCase(sl()));
  sl.registerLazySingleton(() => UpdatePostUseCase(sl()));

  // Blocs
  sl.registerFactory(() => PostsBloc(getAllPosts: sl()));
  sl.registerFactory(
    () => FormPostBloc(
      addPost: sl(),
      updatePost: sl(),
      deletePost: sl(),
      goRouter: sl(),
      // localizedFailureMessages: sl(),
    ),
  );
  sl.registerFactory(() => ConnectivityBloc(sl()));
  // Router
  sl.registerLazySingleton(
    () => GoRouter(
      routes: [
        GoRoute(
          name: 'home',
          path: '/',
          builder: (context, state) {
            FailureMessages().init(context);

            return BlocProvider.value(
              value: sl<PostsBloc>(),
              child: const PostsPage(),
            );
          },
          // builder: (context, state) => MultiBlocProvider(
          //   providers: [
          //     BlocProvider(
          //       create: (_) => sl<PostsBloc>(),
          //     ),
          //     BlocProvider(create: (_) => sl<FormPostBloc>()),
          //     BlocProvider(
          //       create: (context) => sl<ConnectivityBloc>(),
          //     ),
          //     // BlocProvider(
          //     //     create: (_) => sl<PostsBloc>()..add(GetAllPostsEvent())),
          //     // BlocProvider(create: (_) => sl<FormPostBloc>()),
          //   ],
          //   child: const PostsPage(),
          // ),
          routes: [
            GoRoute(
              name: 'details',
              path: 'details',
              builder: (context, state) {
                final post = state.extra as PostEntity?;
                return BlocProvider.value(
                  value: sl<PostsBloc>(),
                  child: PostDetailPage(post: post ?? PostEntity.emptyPost),
                );
              },
            ),
            GoRoute(
              name: 'update',
              path: 'update/:enable_edit',
              builder: (context, state) {
                final post = state.extra as PostEntity?;
                final enableEdit =
                    bool.parse(state.pathParameters['enable_edit'] ?? "false");
                return BlocProvider(
                  // value: sl<FormPostBloc>(),
                  create: (BuildContext context) => sl<FormPostBloc>(),
                  child: PostAddUpdatePage(
                    isUpdatePost: enableEdit,
                    post: post,
                  ),
                );
              },
            ),
          ],
        ),
      ],
      observers: [NoHeroRouterObserver()],
    ),
  );
}