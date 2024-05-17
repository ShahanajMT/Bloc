import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bloc_api/Features/post/models/post_model.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostInitial()) {
    on<PostInitialFetchEvent>(postInitialFetchEvent);
  }

  FutureOr<void> postInitialFetchEvent(
      PostInitialFetchEvent event, Emitter<PostState> emit) async {
        emit(PostFetchingLoadingState());
    var client = http.Client();
    List<PostModel> posts = [];
    try {
      var response = await client.get(
        Uri.parse('https://jsonplaceholder.typicode.com/posts/'),
      );

      List results = jsonDecode(response.body);

      for (int i = 0; i < results.length; i++) {
        PostModel post = PostModel.fromJson(results[i] as Map<String, dynamic>);
        posts.add(post);
      }

      print(posts);

      emit(PostFetchingSuccessfullSate(post: posts));

      //log(results as String);
    } catch (e) {
      emit(PostFetchingErrorState());
      log(e.toString());
    }
  }
}
