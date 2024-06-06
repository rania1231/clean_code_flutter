import 'dart:convert';

import 'package:clean_flutter_code/core/errors/exceptions.dart';
import 'package:clean_flutter_code/features/posts/data/models/PostModel.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart'as http;

abstract class PostRemoteDataSource{
   Future<List<PostModel>> getAllPosts();
   Future<Unit>addPost(PostModel postModel);
   Future<Unit>updatePost(PostModel postModel);
   Future<Unit>deletePost(int id);


}

class PostRemoteDataSourceImpl implements PostRemoteDataSource{
  final http.Client client;
  final linkBase="https://jsonplaceholder.typicode.com";
  PostRemoteDataSourceImpl({required this.client});


  @override
  Future<List<PostModel>> getAllPosts()async {
   final response=await client.get(Uri.parse(linkBase+'/posts/'));
   if(response.statusCode==200){
     List<Map<String,dynamic>>dataJson=json.decode(response.body) ;
     List<PostModel>data= dataJson.map((postMap) => PostModel.fromJson(postMap)).toList();
     return data;
   }
   else{
     throw ServerException();
   }
  }


  @override
  Future<Unit> addPost(PostModel postModel) async{
    final body={
      "id":postModel.id,
      "title":postModel.title,
      "body":postModel.body
    };
    final response=await client.post(Uri.parse(linkBase+'/posts/'),body: body);
    if(response.statusCode==201){
      return Future.value(unit);
    }
    else{
      throw ServerException();
    }
  }

  @override
  Future<Unit> deletePost(int id)async {
    final response=await client.delete(Uri.parse(linkBase+'/posts/$id'));
    if(response.statusCode==200){
      return Future.value(unit);
    }
    else{
      throw ServerException();
    }
  }



  @override
  Future<Unit> updatePost(PostModel postModel)async {
    final body={
      'id':postModel.id,
    'title':postModel.title,
    'body':postModel.body
    };
    final response=await client.patch(Uri.parse(linkBase+'/posts/${postModel.id}'),body:body);
    if(response.statusCode==200){
      return Future.value(unit);
    }else{
      throw ServerException();
    }

  }

}