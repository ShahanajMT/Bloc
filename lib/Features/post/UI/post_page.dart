import 'package:bloc_api/Features/post/posts/post_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final PostBloc postBloc = PostBloc();

  @override
  void initState() {
    // TODO: implement initState
    postBloc.add(PostInitialFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('POST'),
      ),
      body: BlocConsumer<PostBloc, PostState>(
        bloc: postBloc,
        listenWhen: (previous, current) => current is PostActionState,
        buildWhen: (previous, current) => current is !PostActionState,
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case PostFetchingLoadingState:
              return const Center(child: CircularProgressIndicator(),);
            case PostFetchingSuccessfullSate:
              final successstate = state as PostFetchingSuccessfullSate;
              
              return Container(
                child: ListView.builder(itemBuilder: (context, index) {
                  return Container(
                    color: Colors.red.shade300,
                    padding: EdgeInsets.all(16),
                    margin: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(successstate.post[index].title, style: TextStyle(fontWeight: FontWeight.bold),),
                         Text(successstate.post[index].body),
                      ],
                    ),
                  );
                },),
              );
            default:
              return const SizedBox();
          }
          
        },
      ),
    );
  }
}
