import 'package:clean_flutter_code/features/posts/domain/entities/post.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';

abstract class PostRepository {
  Future<Either<Failure, List<Post>>> getAllPosts();

  Future<Either<Failure, Unit>> addPost(Post post);

  Future<Either<Failure, Unit>> deletePost(int id);

  Future<Either<Failure, Unit>> updatePost(Post post);
}
