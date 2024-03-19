import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialapp/model/comment_model.dart';
import 'package:socialapp/service/comment_service.dart';
import 'package:uuid/uuid.dart';

class CommentController extends GetxController {
  GlobalKey<FormState> commentKey = GlobalKey<FormState>();
  TextEditingController commentController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
  File? commentImage;

  @override
  void onInit() {
    super.onInit();
    commentController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    commentController.dispose();
  }

  Future<void> pickCommentImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      commentImage = File(image.path);
      update();
    }
  }

  Future<void> addComment(
    String postId,
  ) async {
    String? url;
    final uuid = const Uuid().v4();
    final ref = storage.ref().child('comments').child(uuid);
    if (commentImage != null) {
      await ref.putFile(commentImage!);
      url = await ref.getDownloadURL();
    }
    await CommentService().addComment(
      postId,
      CommentModel(
        userId: auth.currentUser!.uid,
        comment: commentController.text,
        postId: postId,
        createdAt: Timestamp.now(),
        likes: [],
        comments: [],
        commentImage: commentImage == null ? null : url,
      ).toJson(),
    );
    commentController.clear();
    commentImage = null;
    update();
  }
}
