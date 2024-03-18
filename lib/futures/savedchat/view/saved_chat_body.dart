import 'package:flutter/material.dart';
import 'package:socialapp/core/widgets/custom_text.dart';
import 'package:socialapp/futures/model/chat_model.dart';
import 'package:socialapp/futures/model/user_model.dart';
import 'package:socialapp/futures/service/chat_service.dart';
import 'package:socialapp/futures/service/user_service.dart';

class SavedChatBody extends StatelessWidget {
  const SavedChatBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder<UserModel>(
            stream: UserService().getCurrentUser(),
            builder: (context, user) {
              if (user.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (user.hasError) {
                return const Center(
                  child: Text('Something went wrong!'),
                );
              }
              return Expanded(
                child: ListView.builder(
                    itemCount: user.data!.savedChats == null
                        ? 0
                        : user.data!.savedChats!.length,
                    itemBuilder: (context, index) {
                      return StreamBuilder<List<ChatModel>>(
                          stream: ChatService()
                              .getUserChats(user.data!.savedChats![index]),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (snapshot.hasError) {
                              return const Center(
                                child: Text('Something went wrong!'),
                              );
                            }
                            final data = snapshot.data!.where((element) =>
                                user.data!.savedChats![index] ==
                                element.chatId) as List<ChatModel>;
                            return ListView.builder(
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  return CustomText(
                                      text: snapshot.data![index].chatId);
                                });
                          });
                    }),
              );
            }),
      ],
    );
  }
}
