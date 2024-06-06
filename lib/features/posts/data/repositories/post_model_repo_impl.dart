import 'package:clean_flutter_code/core/errors/exceptions.dart';
import 'package:clean_flutter_code/core/errors/failure.dart';
import 'package:clean_flutter_code/features/posts/data/models/PostModel.dart';
import 'package:clean_flutter_code/features/posts/domain/entities/post.dart';
import 'package:clean_flutter_code/features/posts/domain/repositories/post_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/network/network_info.dart';
import '../dataSources/post_local_data_source.dart';
import '../dataSources/post_remote_data_source.dart';

class PostModelRepositoryImpl implements PostRepository {
  final PostRemoteDataSource postRemoteDataSource;
  final PostLocalDataSource postLocalDataSource;
  final NetworkInfo networkInfo;

  PostModelRepositoryImpl(
      {required this.postLocalDataSource,
      required this.postRemoteDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    if (await networkInfo.isConnected) {
      try {
        final remotePosts = await postRemoteDataSource.getAllPosts();
        postLocalDataSource.savePosts(remotePosts);
        return Right(remotePosts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPosts = await postLocalDataSource.getAllPosts();
        return Right(localPosts);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(Post post) =>
      _getMsg(() => postRemoteDataSource
          .addPost(PostModel(id: post.id, title: post.title, body: post.body)));

  @override
  Future<Either<Failure, Unit>> updatePost(Post post) =>
      _getMsg(() => postRemoteDataSource.updatePost(
          PostModel(id: post.id, title: post.title, body: post.body)));

  @override
  Future<Either<Failure, Unit>> deletePost(int id) =>
      _getMsg(() => postRemoteDataSource.deletePost(id));

  Future<Either<Failure, Unit>> _getMsg(Future<Unit> Function() fct) async {
    if (await networkInfo.isConnected) {
      try {
        await fct();
        return Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }
}
