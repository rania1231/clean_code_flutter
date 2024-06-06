import 'package:clean_flutter_code/features/posts/domain/repositories/post_repository.dart';
import 'package:dartz/dartz.dart';


import '../../../../core/errors/failure.dart';
import '../entities/post.dart';

class AddPostUseCase{
  PostRepository postRepository;
  AddPostUseCase({required this.postRepository});

  Future<Either<Failure,Unit>> call(Post post)async{
    return await postRepository.addPost(post);
  }
}