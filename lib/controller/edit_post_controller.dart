import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialapp/model/post_model.dart';
import 'package:socialapp/service/post_service.dart';
import 'package:uuid/uuid.dart';
import 'package:video_player/video_player.dart';

class EditPostController extends GetxController {
  // @override
  // void onInit() {
  //   super.onInit();
  // }

  @override
  void dispose() {
    videoPlayerController!.dispose();
    super.dispose();
  }

  VideoPlayerController? videoPlayerController;
  TextEditingController updateCaptionController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
  PostModel? post;
  File? postImage;
  File? postVideo;
  bool isEditing = false;

  VideoPlayer displayVideo(String videoUrl) {
    videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(videoUrl));
    videoPlayerController!.initialize();
    videoPlayerController!.play();
    return VideoPlayer(videoPlayerController!);
  }

  Future<void> pickImage(String type, bool isVideo) async {
    if (isVideo == true) {
      postImage = null;
      ImagePicker imagePicker = ImagePicker();
      XFile? videoVile = await imagePicker.pickVideo(
        source: type == 'gallery' ? ImageSource.gallery : ImageSource.camera,
      );
      if (videoVile != null) {
        postVideo = File(videoVile.path);
        update();
      }
    } else {
      postVideo = null;
      ImagePicker imagePicker = ImagePicker();
      XFile? file = await imagePicker.pickImage(
        source: type == 'gallery' ? ImageSource.gallery : ImageSource.camera,
      );
      if (file != null) {
        postImage = File(file.path);
        update();
      }
    }
  }

  Future<void> updatePost(
      String postId,
      List<String> likes,
      List<String> userSaved,
      Timestamp createdAt,
      String image,
      String video) async {
    isEditing = true;
    final postImageuuid = const Uuid().v4();
    final postVideouuid = const Uuid().v1();
    if (postVideo != null) {
      Reference ref =
          storage.ref().child('posts/$postVideouuid').child('$postId.mp4');
      await ref.putFile(postVideo!);
      video = await ref.getDownloadURL();
      //video = postVideo!.path;
      update();
    } else {
      video = video;
      update();
    }
    if (postImage != null) {
      Reference ref =
          storage.ref().child('posts/$postImageuuid').child('$postId.jpg');
      await ref.putFile(postImage!);
      image = await ref.getDownloadURL();
      //image = postImage!.path;
      update();
    } else {
      image = image;
      update();
    }

    PostServices().updatePost(
      PostModel(
        caption: updateCaptionController.text,
        uid: auth.currentUser!.uid,
        postId: postId,
        postImage: image,
        postVideo: video,
        likes: likes,
        userSaved: userSaved,
        createdAt: createdAt,
      ),
    );
    isEditing = false;
    update();
  }

  void onCloseScreen() {
    postImage = null;
    postVideo = null;
    updateCaptionController.text = '';
    update();
  }

  String initialCaption(String caption) {
    updateCaptionController.text = caption;
    return caption;
  }
}
