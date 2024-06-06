import 'dart:convert';

import 'package:clean_flutter_code/core/errors/exceptions.dart';
import 'package:dartz/dartz.dart';

import '../models/PostModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PostLocalDataSource {
  Future<List<PostModel>>getAllPosts();
  Future<Unit>savePosts(List<PostModel> postModels);
}

class PostLocalDataSourceImpl implements PostLocalDataSource{
  final SharedPreferences sharedPreferences;
  PostLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<List<PostModel>> getAllPosts()async {
   final dataString= sharedPreferences.getString("CACHED-POSTS");
   if(dataString!=null){
     List<Map<String,dynamic>> dataMap=json.decode(dataString);
     List<PostModel> data= dataMap.map((postModelMap) => PostModel.fromJson(postModelMap)).toList();
     return Future.value(data);
   }else{
     throw EmptyCacheException();
   }

  }

  @override
  Future<Unit> savePosts(List<PostModel> postModels) {
    List postModelsJson=postModels.map<Map<String,dynamic>>((postModel) => postModel.toJson()).toList();
    sharedPreferences.setString("CACHED-POSTS", json.encode(postModelsJson));
    return Future.value(unit);
  }

}