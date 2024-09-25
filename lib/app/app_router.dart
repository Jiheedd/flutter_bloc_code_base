import 'package:go_router/go_router.dart';
import '../core/network/connection_status_listener/connection_status_bloc.dart';
import '../features/posts/presentation/bloc/add_delete_update_post/form_post_bloc.dart';
import '../features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'injection_container.dart' as di;

class AppRouter {
  final GoRouter goRouter = di.sl<GoRouter>();

  void dispose() {
    di.sl<PostsBloc>().close();
    di.sl<FormPostBloc>().close();
    di.sl<ConnectivityBloc>().close();
  }
}

// class AppRouter {
//   final PostsBloc postsBloc = di.sl<PostsBloc>()..add(GetAllPostsEvent());
//   final AddDeleteUpdatePostBloc addDeleteUpdatePostBloc = di.sl<AddDeleteUpdatePostBloc>();
//
//   late final GoRouter goRouter = GoRouter(
//     routes: [
//       GoRoute(
//         path: '/',
//         builder: (context, state) => MultiBlocProvider(
//           providers: [
//             BlocProvider.value(value: postsBloc),
//             BlocProvider.value(value: addDeleteUpdatePostBloc),
//           ],
//           child: const PostsPage(),
//         ),
//         routes: [
//           GoRoute(
//             path: 'posts',
//             builder: (context, state) => BlocProvider.value(
//               value: postsBloc,
//               child: const PostsPage(),
//             ),
//             routes: [
//               GoRoute(
//                 path: 'update',
//                 builder: (context, state)  {
//                   final navigationState = state.extra as NavigatingToFormState?;
//                   return BlocProvider.value(
//                     value: addDeleteUpdatePostBloc,
//                     child: PostAddUpdatePage(isUpdatePost: navigationState?.enableEdit ?? false, post: navigationState?.post ?? PostEntity.emptyPost,),
//                   );
//                 },
//               ),
//             ],
//           ),
//         ],
//       ),
//     ],
//   );
//
//   void dispose() {
//     postsBloc.close();
//     addDeleteUpdatePostBloc.close();
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import '../presentation/manager/home_bloc.dart';
// import '../presentation/pages/home_screen.dart';
// import '../presentation/pages/second_screen.dart';
// import '../presentation/pages/third_screen.dart';
//
// class AppRouter {
//   final HomeBloc homeBloc = HomeBloc();
//
//   late final GoRouter goRouter = GoRouter(
//     routes: [
//       GoRoute(
//         path: '/',
//         builder: (context, state) => BlocProvider.value(
//           value: homeBloc,
//           child: const HomeScreen(),
//         ),
//         routes: [
//           GoRoute(
//             path: '/second',
//             builder: (context, state) => BlocProvider.value(
//               value: homeBloc,
//               child: const SecondScreen(),
//             ),
//           ),
//           GoRoute(
//             path: '/third',
//             builder: (context, state) => BlocProvider.value(
//               value: homeBloc,
//               child: const ThirdScreen(),
//             ),
//           ),
//         ],
//       ),
//     ],
//   );
//
//   /// The route configuration.
//   // late final GoRouter goRouter = GoRouter(
//   //   routes: <RouteBase>[
//   //     GoRoute(
//   //       path: '/',
//   //       builder: (BuildContext context, GoRouterState state) {
//   //         return BlocProvider.value(
//   //           value: homeBloc,
//   //           child: const HomeScreen(),
//   //         );
//   //       },
//   //       routes: <RouteBase>[
//   //         GoRoute(
//   //           path: '/second',
//   //           builder: (BuildContext context, GoRouterState state) {
//   //             return BlocProvider.value(
//   //               value: HomeBloc(),
//   //               child: const SecondScreen(),
//   //             );
//   //           },
//   //         ),
//   //         GoRoute(
//   //           path: '/third',
//   //           builder: (BuildContext context, GoRouterState state) {
//   //             return BlocProvider.value(
//   //               value: HomeBloc(),
//   //               child: const ThirdScreen(),
//   //             );
//   //           },
//   //         ),
//   //       ],
//   //     ),
//   //   ],
//   // );
//
//   void dispose() {
//     homeBloc.close();
//   }
// }
//
// // import 'package:bloc_test/presentation/pages/third_screen.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// //
// // import '../presentation/manager/home_bloc.dart';
// // import '../presentation/pages/home_screen.dart';
// // import '../presentation/pages/second_screen.dart';
// //
// // class AppRouter {
// //   final HomeBloc homeBloc = HomeBloc();
// //
// //   Route<dynamic> onGenerateRoute(RouteSettings settings) {
// //     switch (settings.name) {
// //       case '/':
// //         return MaterialPageRoute(
// //           builder: (_) => BlocProvider.value(
// //             value: homeBloc,
// //             child: const HomeScreen(),
// //           ),
// //         );
// //       case '/second':
// //         return MaterialPageRoute(
// //           builder: (_) => BlocProvider.value(
// //             value: homeBloc,
// //             child: const SecondScreen(),
// //           ),
// //         );
// //       case '/third':
// //         return MaterialPageRoute(
// //           builder: (_) => BlocProvider.value(
// //             value: homeBloc,
// //             child: const ThirdScreen(),
// //           ),
// //         );
// //       default:
// //         return MaterialPageRoute(
// //           builder: (_) => BlocProvider.value(
// //             value: homeBloc,
// //             child: const HomeScreen(),
// //           ),
// //         );
// //     }
// //   }
// //
// //
// //   void dispose() {
// //     homeBloc.close();
// //   }
// // }