part of 'post_bloc.dart';

@immutable
abstract class PostState {}

abstract class PostActionState extends PostState{}

class PostInitial extends PostState {}

class PostFetchingLoadingState extends PostState{}

class PostFetchingErrorState extends PostState{}


class PostFetchingSuccessfullSate extends PostState {
  final List<PostModel> post;

  PostFetchingSuccessfullSate({required this.post});
}
