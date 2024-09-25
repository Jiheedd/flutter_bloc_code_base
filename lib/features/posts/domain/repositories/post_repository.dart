

import 'package:base_code_bloc_flutter/features/posts/domain/entities/post_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

abstract class PostRepository {
  Future<Either<Failure, List<PostEntity>>> getAllPosts();
  Future<Either<Failure, Unit>> addPost(PostEntity post);
  Future<Either<Failure, Unit>> updatePost(PostEntity post);
  Future<Either<Failure, Unit>> deletePost(int idPost);
}