import 'package:flutter/material.dart';
import 'package:socialapp/futures/home/view/widgets/postitem/post_item.dart';
import 'package:socialapp/model/post_model.dart';
import 'package:socialapp/service/post_service.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder<List<PostModel>>(
            stream: PostServices().getPosts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return const Center(
                  child: Text('Something went wrong!'),
                );
              }
              return Expanded(
                  child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return PostItem(post: snapshot.data![index]);
                },
              ));
            }),
      ],
    );
  }
}
