


import 'package:base_code_bloc_flutter/core/error/failures.dart';
import 'package:base_code_bloc_flutter/features/posts/domain/entities/post_entity.dart';
import 'package:base_code_bloc_flutter/features/posts/domain/repositories/post_repository.dart';
import 'package:dartz/dartz.dart';

class GetAllPostsUseCase {
  final PostRepository postRepository;

  GetAllPostsUseCase(this.postRepository);

  Future<Either<Failure, List<PostEntity>>> call() async {
    return await postRepository.getAllPosts();
  }
}