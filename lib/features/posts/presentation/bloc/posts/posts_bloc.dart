import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/strings/failures.dart';
import '../../../domain/entities/post_entity.dart';
import '../../../domain/use_cases/get_all_posts_use_case.dart';

part 'posts_event.dart';
part 'posts_state.dart';

// class PostsBloc extends Bloc<PostsEvent, PostsState> {
//   final GetAllPostsUseCase getAllPosts;
//
//   PostsBloc({
//     required this.getAllPosts,
//   }) : super(PostsInitial()) {
//
//     on<GetAllPostsEvent>((event, Emitter<PostsState> emit) async {
//       emit(LoadingPostsState());
//       final failureOrPosts = await getAllPosts();
//       emit(_mapFailureOrPostsToState(failureOrPosts));
//     });
//
//     on<RefreshPostsEvent>((event, emit) async {
//       emit(LoadingPostsState());
//       await Future.delayed(const Duration(seconds: 5));
//
//       final failureOrPosts = await getAllPosts();
//       emit(_mapFailureOrPostsToState(failureOrPosts));
//       // await _loadAllPosts(emit);
//     });
//   }
//
//   //
//   Future<void> _loadAllPosts(Emitter<PostsState> emit) async {
//     emit(LoadingPostsState());
//     await Future.delayed(const Duration(seconds: 3));
//     final failureOrPosts = await getAllPosts();
//     emit(_mapFailureOrPostsToState(failureOrPosts));
//   }
//
//   PostsState _mapFailureOrPostsToState(
//       Either<Failure, List<PostEntity>> either) {
//     return either.fold(
//           (failure) => ErrorPostsState(message: _mapFailureToMessage(failure)),
//           (posts) => LoadedPostsState(posts: posts),
//     );
//   }
//
//   String _mapFailureToMessage(Failure failure) {
//     switch (failure.runtimeType) {
//       case const (ServerFailure):
//         return SERVER_FAILURE_MESSAGE;
//       case const (EmptyCacheFailure):
//         return EMPTY_CACHE_FAILURE_MESSAGE;
//       case const (OfflineFailure):
//         return OFFLINE_FAILURE_MESSAGE;
//       default:
//         return UNEXPECTED_ERROR;
//     }
//   }
// }
class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPostsUseCase getAllPosts;
  PostsBloc({
    required this.getAllPosts,
  }) : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetAllPostsEvent) {
        emit(LoadingPostsState());

        final failureOrPosts = await getAllPosts();
        emit(_mapFailureOrPostsToState(failureOrPosts));
      } else if (event is RefreshPostsEvent) {
        emit(LoadingPostsState());

        await Future.delayed(const Duration(seconds: 5));

        final failureOrPosts = await getAllPosts();
        emit(_mapFailureOrPostsToState(failureOrPosts));
      }
    });
  }

  PostsState _mapFailureOrPostsToState(Either<Failure, List<PostEntity>> either) {
    return either.fold(
          (failure) => ErrorPostsState(message: _mapFailureToMessage(failure)),
          (posts) => LoadedPostsState(
        posts: posts,
      ),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case EmptyCacheFailure:
        return EMPTY_CACHE_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Unexpected Error , Please try again later .";
    }
  }
}