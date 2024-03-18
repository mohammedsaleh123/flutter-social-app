import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialapp/futures/model/user_model.dart';
import 'package:socialapp/futures/service/user_service.dart';
import 'package:socialapp/futures/navbar/nav_bar_view.dart';
import 'package:uuid/uuid.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  TextEditingController registerNameController = TextEditingController();
  TextEditingController registerEmailController = TextEditingController();
  TextEditingController registerPasswordController = TextEditingController();
  TextEditingController registerConfirmPasswordController =
      TextEditingController();
  File? profileImage;
  bool isLogin = false;
  bool isRegister = false;
  bool isLoginWithGoogle = false;

  @override
  void onInit() {
    super.onInit();
    loginEmailController;
    loginPasswordController;
    registerNameController;
    registerEmailController;
    registerPasswordController;
    registerConfirmPasswordController;
  }

  @override
  void dispose() {
    super.dispose();
    loginEmailController.dispose();
    loginPasswordController.dispose();
    registerNameController.dispose();
    registerEmailController.dispose();
    registerPasswordController.dispose();
    registerConfirmPasswordController.dispose();
  }

  Future<void> pickImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      profileImage = File(file.path);
      update();
    }
  }

  Future<void> login() async {
    isLogin = true;
    update();
    try {
      bool isLoginDone = await UserService().login(
        loginEmailController.text,
        loginPasswordController.text,
      );
      if (isLoginDone) {
        isLogin = false;
        Get.off(() => const NavBarView());
        loginEmailController.clear();
        loginPasswordController.clear();
        update();
      }
    } catch (e) {
      Get.snackbar('error', e.toString());
    }
  }

  Future<void> loginWithGoogle() async {
    isLoginWithGoogle = true;
    update();
    UserCredential cred = await UserService().loginWithGoogle();
    await firestore.collection('users').doc(cred.user!.uid).update({
      'uid': cred.user!.uid,
      'userName': cred.user!.displayName!,
      'email': cred.user!.email!,
      'profileImage': cred.user!.photoURL!,
      'createdAt': Timestamp.now(),
    });
    isLoginWithGoogle = false;
    Get.off(() => const NavBarView());
    loginEmailController.clear();
    loginPasswordController.clear();
    registerNameController.clear();
    registerEmailController.clear();
    registerPasswordController.clear();
    registerConfirmPasswordController.clear();
    profileImage = null;
    update();
  }

  Future<void> register() async {
    isRegister = true;
    update();
    final uuid = const Uuid().v4();
    Reference ref = storage.ref().child('profilePictures/$uuid');
    await ref.putFile(profileImage!);
    final image = await ref.getDownloadURL();
    UserCredential user = await UserService().register(
      registerEmailController.text,
      registerPasswordController.text,
    );
    await firestore.collection('users').doc(user.user!.uid).set(
          UserModel(
            uid: auth.currentUser!.uid,
            userName: registerNameController.text,
            email: registerEmailController.text,
            profileImage: image,
            following: [],
            followers: [],
            savedChats: [],
            createdAt: Timestamp.now(),
          ).toJson(),
        );
    isRegister = false;
    Get.off(() => const NavBarView());
    registerNameController.clear();
    registerEmailController.clear();
    registerPasswordController.clear();
    registerConfirmPasswordController.clear();
    profileImage = null;
    update();
  }
}
