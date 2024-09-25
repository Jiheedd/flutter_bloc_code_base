import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/connectivity_services.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/post_entity.dart';
import '../../domain/repositories/post_repository.dart';
import '../data_sources/local/post_local_data_source.dart';
import '../data_sources/remote/post_remote_data_source.dart';
import '../models/post_model.dart';

typedef DeleteOrUpdateOrAddPost = Future<Unit> Function();

class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource remoteDataSource;

  final PostLocalDataSource localDataSource;
  final ConnectivityService networkInfo;

  PostRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<PostEntity>>> getAllPosts() async {
    try {
      if (await networkInfo.isConnected) {
        return await _fetchRemotePosts(remoteDataSource);
      } else {
        return await _fetchCachedPosts(localDataSource);
      }
    } catch (e) {
      return Left(UnknownFailure());
    }
  }

  Future<Either<Failure, List<PostEntity>>> _fetchRemotePosts(PostRemoteDataSource postLocalImpl,
      {bool isFirstAttempt = true}) async {
    try {
      final remotePosts = await remoteDataSource.getAllPosts();
      localDataSource.cachePosts(remotePosts);
      return Right(remotePosts);
    } on PackageException {
      // if (isFirstAttempt) {
      //   return await _fetchRemotePosts(postRemoteImplWithDio, isFirstAttempt: false);
      // } else {
      //   return Left(PackageFailure());
      // }
      return Left(PackageFailure());

    } on ServerException {
      return Left(ServerFailure());
    } on OfflineException {
      return Future.delayed(const Duration(seconds: 1)).then((_) => getAllPosts());
    } catch (e) {
      return Left(UnknownFailure());
    }
  }

  Future<Either<Failure, List<PostEntity>>> _fetchCachedPosts(PostLocalDataSource postLocalImpl,
      {bool isFirstAttempt = true}) async {
    try {
      final cachedPosts = await localDataSource.getCachedPosts();
      return Right(cachedPosts);
    } on EmptyCacheException {
      // if (isFirstAttempt) {
      //   return await _fetchCachedPosts(postLocalImplWithSqfLite, isFirstAttempt: false);
      // } else {
      //   return Left(EmptyCacheFailure());
      // }
      return Left(EmptyCacheFailure());

    } on PackageException {
      // if (isFirstAttempt) {
      //   return await _fetchCachedPosts(postLocalImplWithSqfLite, isFirstAttempt: false);
      // } else {
      //   return Left(PackageFailure());
      // }
      return Left(PackageFailure());

    } catch (e) {
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(PostEntity post) async {
    final PostModel postModel = PostModel(id: post.id, title: post.title, body: post.body);
    return await _getMessage(() => remoteDataSource.addPost(postModel));
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int postId) async {
    return await _getMessage(() => remoteDataSource.deletePost(postId));
  }

  @override
  Future<Either<Failure, Unit>> updatePost(PostEntity post) async {
    final PostModel postModel = PostModel(id: post.id, title: post.title, body: post.body);
    return await _getMessage(() => remoteDataSource.updatePost(postModel));
  }

  Future<Either<Failure, Unit>> _getMessage(DeleteOrUpdateOrAddPost deleteOrUpdateOrAddPost) async {
    if (await networkInfo.isConnected) {
      try {
        await deleteOrUpdateOrAddPost();
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      } catch (e) {
        return Left(UnknownFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}