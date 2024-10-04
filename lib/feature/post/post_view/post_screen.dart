import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../config/setup_locator.dart';
import '../post_bloc/post_bloc.dart';

class PostScreen extends StatelessWidget {
  PostScreen({super.key});

  final PostBloc bloc = locator.get<PostBloc>()..add(FetchPostEvent());

  @override
  Widget build(BuildContext context) {
    bloc.stream.listen((state) {
      if (state is PostError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text((bloc.state as PostError).errorText),
          ),
        );
      }
      if (state is PostLoaded && state.message != null) {
        log("message");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text((bloc.state as PostLoaded).message!),
          ),
        );
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text("Post App"),
      ),
      body: StreamBuilder<PostState>(
        stream: bloc.stream,
        initialData: bloc.state,
        builder: (context, snapshot) {
          return Stack(
            children: [
              /// all state
              ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: bloc.state.postList.length,
                itemBuilder: (context, index) {
                  final post = bloc.state.postList[index];
                  return Card(
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(40),
                        ),
                        child: Text(post.id.toString()),
                      ),
                      title: Text(post.title ?? ""),
                      subtitle: Text(post.body ?? ""),
                      trailing: IconButton(
                        onPressed: () =>
                            bloc.add(DeletePostEvent(id: post.id.toString())),
                        icon: const Icon(CupertinoIcons.delete),
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
      floatingActionButton: StreamBuilder<PostState>(
          stream: bloc.stream,
          initialData: bloc.state,
          builder: (context, snapshot) {
            return FloatingActionButton(
              onPressed: () {
                bloc.add(
                    DeletePostEvent(id: bloc.state.postList[0].id.toString()));
              },
              backgroundColor: Colors.red,
              child: bloc.state is PostLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : const Icon(Icons.abc),
            );
          }),
    );
  }
}
