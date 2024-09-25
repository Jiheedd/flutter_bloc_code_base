import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../../../core/strings/keys.dart';
import '../../models/post_model.dart';


abstract class PostLocalDataSource {
  Future<List<PostModel>> getCachedPosts();

  Future<Unit> cachePosts(List<PostModel> posts);
}

class PostLocalImplWithShares implements PostLocalDataSource {
  final SharedPreferences sharedPreferences;

  PostLocalImplWithShares({required this.sharedPreferences});

  @override
  Future<List<PostModel>> getCachedPosts() {
    final jsonString = sharedPreferences.getString(CACHED_POSTS);
    if (jsonString != null) {
      List decodeJsonData = json.decode(jsonString);
      List<PostModel> jsonToPostModels = decodeJsonData
          .map<PostModel>((jsonPostModel) => PostModel.fromJson(jsonPostModel))
          .toList();
      return Future.value(jsonToPostModels);
    } else {
      throw EmptyCacheException();
    }
  }

  @override
  Future<Unit> cachePosts(List<PostModel> posts) {
    List postModelsToJson = posts
        .map<Map<String, dynamic>>((postModel) => postModel.toJson())
        .toList();
    sharedPreferences.setString(CACHED_POSTS, json.encode(postModelsToJson));
    return Future.value(unit);
  }
}

class PostLocalImplWithSqfLite implements PostLocalDataSource {

  @override
  Future<List<PostModel>> getCachedPosts() {
    // List<PostModel> jsonToPostModels = [];
    // return Future.value(jsonToPostModels);
    throw UnimplementedError();
  }

  @override
  Future<Unit> cachePosts(List<PostModel> posts) {
    print("getCachedPosts Doesn't yet implemented !");
    throw UnimplementedError();
  }
}