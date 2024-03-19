import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialapp/model/chat_model.dart';
import 'package:socialapp/service/chat_service.dart';
import 'package:uuid/uuid.dart';

class ChatController extends GetxController {
  // @override
  // void onInit() {
  //   super.onInit();
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  // }

  TextEditingController messageController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
  File? messageImage;
  bool isLoading = false;

  Future<void> pickMessageImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      messageImage = File(image.path);
      update();
    }
  }

  Future<void> sendMessage(String reciverId) async {
    final uuid = const Uuid().v4();
    final ref = storage.ref().child('messages').child(uuid);
    String? url;
    isLoading = true;
    update();
    if (messageImage != null) {
      await ref.putFile(messageImage!);
      url = await ref.getDownloadURL();
    }
    List<String> chatRoom = [auth.currentUser!.uid, reciverId];
    chatRoom.sort();
    String chatId = chatRoom.join('-');
    await ChatService().addMessage(
      chatId,
      ChatModel(
        chatId: chatId,
        senderId: auth.currentUser!.uid,
        receiverId: reciverId,
        message: messageController.text,
        createdAt: Timestamp.now(),
        messageImage: url ?? '',
      ).toJson(),
      reciverId,
    );

    messageController.clear();
    messageImage = null;
    isLoading = false;
    update();
  }
}
