import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_api/Features/post/models/post_model.dart';
import 'package:bloc_api/Features/post/repos/post_repo.dart';
import 'package:meta/meta.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostInitial()) {
    on<PostInitialFetchEvent>(postInitialFetchEvent);
  }

  FutureOr<void> postInitialFetchEvent(
      PostInitialFetchEvent event, Emitter<PostState> emit) async {
        emit(PostFetchingLoadingState());
      
      List<PostModel> posts = await PostRepo.fetchPost();
      emit(PostFetchingSuccessfullSate(post: posts));

      //log(results as String);
    } 
  }

