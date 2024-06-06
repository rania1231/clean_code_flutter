import 'package:clean_flutter_code/core/errors/failure.dart';
import 'package:dartz/dartz.dart';

import '../entities/post.dart';
import '../repositories/post_repository.dart';

class UpdatePostUseCase {
  PostRepository postRepository;

  UpdatePostUseCase({required this.postRepository});

  Future<Either<Failure, Unit>> call(Post post)async {
    return await postRepository.updatePost(post);
  }
}
