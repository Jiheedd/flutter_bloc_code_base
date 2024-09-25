import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import '../../../../../core/env/end_points.dart';
import '../../../../../core/env/env.dart';
import '../../../../../core/error/exceptions.dart';
import '../../models/post_model.dart';


abstract class PostRemoteDataSource {

  Future<List<PostModel>> getAllPosts();
  Future<Unit> addPost(PostModel postModel);
  Future<Unit> updatePost(PostModel postModel);
  Future<Unit> deletePost(int idPost);
}


class PostRemoteImplWithHttp implements PostRemoteDataSource {
  final http.Client client;

  PostRemoteImplWithHttp({required this.client});

  @override
  Future<List<PostModel>> getAllPosts() async {
    final response = await client.get(
      Uri.parse("$BASE_URL${EndPoints.posts}"),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      final List decodedJson = json.decode(response.body) as List;
      final List<PostModel> postModels = decodedJson
          .map<PostModel>((jsonPostModel) => PostModel.fromJson(jsonPostModel))
          .toList();

      return postModels;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addPost(PostModel postModel) async {
    final body = {
      "title": postModel.title,
      "body": postModel.body,
    };

    final response =
    await client.post(Uri.parse("$BASE_URL${EndPoints.posts}"), body: body);

    if (response.statusCode == 201) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updatePost(PostModel postModel) async {
    final postId = postModel.id.toString();
    final body = {
      "title": postModel.title,
      "body": postModel.body,
    };

    final response = await client.patch(
      Uri.parse("$BASE_URL${EndPoints.posts}/$postId"),
      body: body,
    );

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deletePost(int postId) async {
    final response = await client.delete(
      Uri.parse("$BASE_URL${EndPoints.posts}/${postId.toString()}"),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}



class PostRemoteImplWithDio implements PostRemoteDataSource {
  final Dio dio;

  PostRemoteImplWithDio({required this.dio});

  @override
  Future<List<PostModel>> getAllPosts() async {
    try {
      final response = await dio.get(
        "$BASE_URL${EndPoints.posts}",
        options: Options(
          headers: {"Content-Type": "application/json"},
        ),
      );

      if (response.statusCode == 200) {
        final List decodedJson = response.data as List;
        final List<PostModel> postModels = decodedJson
            .map<PostModel>((jsonPostModel) => PostModel.fromJson(jsonPostModel))
            .toList();

        return postModels;
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addPost(PostModel postModel) async {
    final body = {
      "title": postModel.title,
      "body": postModel.body,
    };

    try {
      final response = await dio.post(
        "$BASE_URL${EndPoints.posts}",
        data: json.encode(body),
        options: Options(
          headers: {"Content-Type": "application/json"},
        ),
      );

      if (response.statusCode == 201) {
        return Future.value(unit);
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updatePost(PostModel postModel) async {
    final postId = postModel.id.toString();
    final body = {
      "title": postModel.title,
      "body": postModel.body,
    };

    try {
      final response = await dio.patch(
        "$BASE_URL${EndPoints.posts}/$postId",
        data: json.encode(body),
        options: Options(
          headers: {"Content-Type": "application/json"},
        ),
      );

      if (response.statusCode == 200) {
        return Future.value(unit);
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deletePost(int postId) async {
    try {
      final response = await dio.delete(
        "$BASE_URL${EndPoints.posts}/$postId",
        options: Options(
          headers: {"Content-Type": "application/json"},
        ),
      );

      if (response.statusCode == 200) {
        return Future.value(unit);
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }
}