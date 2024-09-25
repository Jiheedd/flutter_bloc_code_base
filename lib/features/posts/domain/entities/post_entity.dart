


import 'package:equatable/equatable.dart';

class PostEntity extends Equatable {
  final int? id;
  final String title;
  final String body;

  const PostEntity({this.id, required this.title, required this.body});

  static PostEntity get emptyPost => const PostEntity(title: '', body: '');
  @override
  List<Object?> get props => [id, title, body];

  @override
  String toString() {

    return """id: $id, title: title, body: body""";
  }
}