import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app/app.dart';
import 'app/injection_container.dart' as di;
import 'app/injection_container.dart';
import 'core/network/connection_status_listener/connection_status_bloc.dart';
import 'features/posts/presentation/bloc/add_delete_update_post/form_post_bloc.dart';
import 'features/posts/presentation/bloc/posts/posts_bloc.dart';

void main() async {
  // final networkInfo = NetworkInfoImpl(InternetConnectionChecker());
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl<PostsBloc>(),
        ),
        BlocProvider(create: (_) => sl<FormPostBloc>()),
        BlocProvider(
          create: (context) => sl<ConnectivityBloc>(),
        ),
        // BlocProvider(
        //     create: (_) => sl<PostsBloc>()..add(GetAllPostsEvent())),
        // BlocProvider(create: (_) => sl<FormPostBloc>()),
      ],
      child: MyApp(),
    ),
  );
}