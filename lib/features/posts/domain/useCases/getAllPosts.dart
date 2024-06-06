import 'package:clean_flutter_code/core/errors/failure.dart';
import 'package:clean_flutter_code/features/posts/domain/repositories/post_repository.dart';
import 'package:dartz/dartz.dart';

import '../entities/post.dart';

class GetAllPostsUseCase {
  final PostRepository postRepository;

  GetAllPostsUseCase({required this.postRepository});

  Future<Either<Failure, List<Post>>> call() async{
    return await postRepository.getAllPosts();
  }
}
