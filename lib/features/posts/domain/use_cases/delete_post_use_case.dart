

import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repositories/post_repository.dart';

class DeletePostUseCase{

  final PostRepository postRepository;

  DeletePostUseCase(this.postRepository);

  Future<Either<Failure, Unit>> call(int idPost) async {
    return await postRepository.deletePost(idPost);
  }
}