part of 'form_post_bloc.dart';

abstract class FormPostState extends Equatable {
  const FormPostState();

  @override
  List<Object> get props => [];
}

class FormPostInitial extends FormPostState {
}

class LoadingFormPostState extends FormPostState {}

class ErrorFormPostState extends FormPostState {
  final String message;

  const ErrorFormPostState({required this.message});

  @override
  List<Object> get props => [message];
}

class MessageFormPostState extends FormPostState {
  final String message;

  const MessageFormPostState({required this.message});

  @override
  List<Object> get props => [message];
}