import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:socialapp/model/user_model.dart';

class UserService {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> register(String email, String password) async {
    await auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<bool> login(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      Get.snackbar('error', e.toString());
    }
    return false;
  }

  Future<void> resetPassword(String email) async {
    await auth.sendPasswordResetEmail(email: email);
  }

  Future<UserCredential> loginWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      return await auth.signInWithCredential(credential);
    } catch (error) {
      Get.snackbar('error', error.toString());
      return Future.error(error);
    }
  }

  Future<void> signOut() async {
    await auth.signOut();
  }

  Stream<UserModel> getCurrentUser() {
    Stream<DocumentSnapshot<Map<String, dynamic>>> snapshot =
        firestore.collection('users').doc(auth.currentUser!.uid).snapshots();
    return snapshot.map((event) {
      return UserModel.fromJson(event.data() as Map<String, dynamic>);
    });
  }

  Stream<UserModel> getUser(String uid) {
    final snapshot = firestore.collection('users').doc(uid).snapshots();
    return snapshot.map((event) {
      return UserModel.fromJson(event.data() as Map<String, dynamic>);
    });
  }

  Stream<List<UserModel>> getAllUsers() {
    final snapshot = firestore.collection('users').snapshots();
    return snapshot.map((event) {
      return event.docs
          .map((e) => UserModel.fromJson(e.data()))
          .toList()
          .where((element) => element.uid != auth.currentUser!.uid)
          .toList();
    });
  }

  Future<void> updateUser(String uid, Map<String, dynamic> data) async {
    await firestore.collection('users').doc(uid).update(data);
  }

  Future<void> deleteUser(String uid) async {
    await firestore.collection('users').doc(uid).delete();
  }

  Future<void> followUser(String otherUserId) async {
    await firestore.collection('users').doc(auth.currentUser!.uid).update({
      'following': FieldValue.arrayUnion([otherUserId])
    });
    await firestore.collection('users').doc(otherUserId).update({
      'followers': FieldValue.arrayUnion([auth.currentUser!.uid])
    });
  }

  Future<void> unfollowUser(String otherUserId) async {
    await firestore.collection('users').doc(auth.currentUser!.uid).update({
      'following': FieldValue.arrayRemove([otherUserId])
    });
    await firestore.collection('users').doc(otherUserId).update({
      'followers': FieldValue.arrayRemove([auth.currentUser!.uid])
    });
  }
}
