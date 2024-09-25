part of 'form_post_bloc.dart';

abstract class FormPostEvent extends Equatable {
  const FormPostEvent();

  @override
  List<Object?> get props => [];
}

class NavigatingToFormEvent extends FormPostEvent {
  final bool enableEdit;
  final PostEntity? post;

  const NavigatingToFormEvent(this.enableEdit, {this.post});

  @override
  List<Object?> get props => [enableEdit, post];
}

class AddPostEvent extends FormPostEvent {
  final PostEntity post;
  final String successMessage;
  const AddPostEvent({required this.post, required this.successMessage, });

  @override
  List<Object?> get props => [post];
}

class UpdatePostEvent extends FormPostEvent {
  final PostEntity post;
  final String successMessage;

  const UpdatePostEvent({required this.post, required this.successMessage, });

  @override
  List<Object?> get props => [post];
}

class DeletePostEvent extends FormPostEvent {
  final int postId;
  final String successMessage;

  const DeletePostEvent({ required this.postId, required this.successMessage, });

  @override
  List<Object?> get props => [postId];
}