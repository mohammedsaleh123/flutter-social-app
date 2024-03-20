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

class AddPostController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
  TextEditingController captionController = TextEditingController();
  File? postImage;
  File? postVideo;
  bool isPostLoading = false;
  VideoPlayerController? postVideoController;
  bool isVideoPlaying = false;
  // @override
  // void onInit() {
  //   super.onInit();
  // }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  void onCloseScreen() {
    captionController.text = '';
    //postVideoController!.dispose();
    postImage = null;
    postVideo = null;
    update();
  }

  @override
  void dispose() {
    captionController.dispose();
    postVideoController!.dispose();
    postImage = null;
    postVideo = null;
    update();
    super.dispose();
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
        postVideoController = VideoPlayerController.file(postVideo!)
          ..initialize();
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

  VideoPlayer? displayVideo() {
    if (postVideo != null) {
      postVideoController =
          VideoPlayerController.networkUrl(Uri.parse(postVideo!.path));
      postVideoController!.initialize();
      postVideoController!.play();
      return VideoPlayer(postVideoController!);
    }
    return null;
  }

  void switchBetweenImageAndVideo() {
    isVideoPlaying = !isVideoPlaying;
    update();
  }

  Future<void> addPost() async {
    isPostLoading = true;
    update();
    String? videoUrl;
    String? imageUrl;
    final postId = const Uuid().v4();
    final imageFileName = const Uuid().v4();
    final videoFileName = const Uuid().v1();
    if (postImage != null) {
      isPostLoading = true;
      final refImage =
          storage.ref().child('posts/$imageFileName').child('$postId.jpg');
      await refImage.putFile(postImage!);
      imageUrl = await refImage.getDownloadURL();
    } else if (postVideo != null) {
      isPostLoading = true;
      final ref =
          storage.ref().child('posts/$videoFileName').child('$postId.mp4');
      await ref.putFile(postVideo!);
      videoUrl = await ref.getDownloadURL();
    }
    PostServices().addPost(
      PostModel(
        caption: captionController.text,
        uid: auth.currentUser!.uid,
        postId: postId,
        postImage: imageUrl ?? '',
        postVideo: videoUrl ?? '',
        likes: [],
        userSaved: [],
        createdAt: Timestamp.now(),
      ),
      postId,
    );
    isPostLoading = false;
    postImage = null;
    postVideo = null;
    captionController.clear();
    update();
  }
}
