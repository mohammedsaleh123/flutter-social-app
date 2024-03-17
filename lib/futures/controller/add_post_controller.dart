import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialapp/futures/model/post_model.dart';
import 'package:socialapp/futures/service/post_service.dart';
import 'package:uuid/uuid.dart';

class AddPostController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
  TextEditingController captionController = TextEditingController();
  File? postImage;
  bool isPostLoading = false;
  // @override
  // void onInit() {
  //   super.onInit();
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  // }

  Future<void> pickImage(String type) async {
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(
      source: type == 'gallery' ? ImageSource.gallery : ImageSource.camera,
    );
    if (file != null) {
      postImage = File(file.path);
      update();
    }
  }

  Future<void> addPost() async {
    isPostLoading = true;
    update();
    final postId = const Uuid().v4();
    final fileName = const Uuid().v4();
    final ref = storage.ref().child('posts/$fileName').child(postId);
    await ref.putFile(postImage!);
    final imageUrl = await ref.getDownloadURL();
    PostServices().addPost(
      PostModel(
        caption: captionController.text,
        uid: auth.currentUser!.uid,
        postId: postId,
        postImage: imageUrl,
        likes: [],
        userSaved: [],
        createdAt: Timestamp.now(),
      ),
      postId,
    );
    isPostLoading = false;
    postImage = null;
    captionController.clear();
    update();
  }
}
