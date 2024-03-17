import 'package:flutter/material.dart';
import 'package:socialapp/core/widgets/custom_text.dart';
import 'package:socialapp/futures/savedchat/view/saved_chat_body.dart';

class SavedChatView extends StatelessWidget {
  const SavedChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: 'Saved Chat'),
      ),
      body: const SavedChatBody(),
    );
  }
}
