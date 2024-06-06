import 'package:clean_flutter_code/core/errors/failure.dart';
import 'package:clean_flutter_code/features/posts/domain/entities/post.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/useCases/getAllPosts.dart';

part 'posts_event.dart';

part 'posts_state.dart';

class PostBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPostsUseCase getAllPosts;
  PostBloc({required this.getAllPosts}) : super(PostsInitial()) {
    on<PostsEvent>((event,emit)async{
      if(event is GetAllPostsEvent||event is RefreshPostsEvent){
        emit(LoadingPostsState());
        final posts=await getAllPosts.call();
        posts.fold(
                (failure) {
                  emit(ErrorPostsState(message: _mapFailureToString(failure))) ;
                }
                ,
                (posts) {
                  emit(LoadedPostsState(posts: posts)) ;
                });
      }
      else {

      }
    });

  }


  String _mapFailureToString(Failure failure){

    switch(failure.runtimeType){
      case ServerFailure:
        return"error server";
      case OffLineFailure:
        return"no internet connection";
      case EmptyCacheFailure:
        return"no data in the cache";
      default:
        return "Unexpected error ,please try again";

    }
  }
}
