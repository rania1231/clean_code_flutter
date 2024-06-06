import 'package:clean_flutter_code/core/errors/failure.dart';
import 'package:clean_flutter_code/features/posts/domain/repositories/post_repository.dart';
import 'package:dartz/dartz.dart';

class DeletePostUseCase {
  PostRepository postRepository;

  DeletePostUseCase({required this.postRepository});

  Future<Either<Failure, Unit>> call(int id) async{
    return await postRepository.deletePost(id);
  }
}
