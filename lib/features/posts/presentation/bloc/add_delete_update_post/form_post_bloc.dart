import 'package:base_code_bloc_flutter/features/posts/domain/entities/post_entity.dart';
import 'package:bloc/bloc.dart' show Bloc;
import 'package:go_router/go_router.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/strings/failures.dart';
import '../../../../../core/strings/messages.dart';
import '../../../domain/use_cases/add_post_use_case.dart';
import '../../../domain/use_cases/delete_post_use_case.dart';
import '../../../domain/use_cases/update_post_use_case.dart';

part 'form_post_event.dart';

part 'form_post_state.dart';

class FormPostBloc extends Bloc<FormPostEvent, FormPostState> {
  final AddPostUseCase addPost;
  final DeletePostUseCase deletePost;
  final UpdatePostUseCase updatePost;
  final GoRouter goRouter;

  FormPostBloc({
    required this.addPost,
    required this.deletePost,
    required this.updatePost,
    required this.goRouter,
  }) : super(FormPostInitial()) {
    on<AddPostEvent>((event, emit) async {
      emit(LoadingFormPostState());
      final failureOrDoneMessage = await addPost(event.post);
      emit(
        _eitherDoneMessageOrErrorState(
            failureOrDoneMessage, event.successMessage),
      );
    });
    on<UpdatePostEvent>((event, emit) async {
        emit(LoadingFormPostState());
        final failureOrDoneMessage = await updatePost(event.post);
        emit(
          _eitherDoneMessageOrErrorState(
              failureOrDoneMessage, event.successMessage),
        );
    });
    on<DeletePostEvent>((event, emit) async {
        emit(LoadingFormPostState());
        final failureOrDoneMessage = await deletePost(event.postId);
        emit(
          _eitherDoneMessageOrErrorState(
              failureOrDoneMessage, event.successMessage),
        );
    });

    on<NavigatingToFormEvent>((event, emit) {
      // emit(newState);
      goRouter.goNamed('update',
          pathParameters: {'enable_edit': event.enableEdit.toString()},
          extra: event.post);
    });
  }

  FormPostState _eitherDoneMessageOrErrorState(
      Either<Failure, Unit> either, String message) {
    return either.fold(
      (failure) => ErrorFormPostState(
        // message: _mapFailureToMessage(failure),
        message: FailureMessages.mapLocalizedFailureMessages[failure as Type] ?? "empty",
      ),
      (_) => MessageFormPostState(message: message),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case const (ServerFailure):
        return SERVER_FAILURE_MESSAGE;
      case const (OfflineFailure):
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return UNEXPECTED_ERROR;
    }
  }
}