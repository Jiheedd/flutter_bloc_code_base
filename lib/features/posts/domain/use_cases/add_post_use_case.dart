

import 'package:base_code_bloc_flutter/features/posts/domain/entities/post_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repositories/post_repository.dart';

class AddPostUseCase {
  final PostRepository postRepository ;

  AddPostUseCase(this.postRepository);

  Future<Either<Failure, Unit>> call(PostEntity post) async {
    return await postRepository.addPost(post);
  }
}