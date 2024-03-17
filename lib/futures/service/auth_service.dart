import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:socialapp/futures/model/user_model.dart';

class AuthService {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<UserCredential> register(String email, String password) async {
    final UserCredential user = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return user;
  }

  Future<UserCredential?> login(String email, String password) async {
    UserCredential user =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    return user;
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

  Future<void> logout() async {
    await auth.signOut();
  }

  Stream<UserModel> getCurrentUser() {
    User? user = auth.currentUser;
    Stream<DocumentSnapshot<Map<String, dynamic>>> snapshot =
        firestore.collection('users').doc(user!.uid).snapshots();
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

  Future<void> updateUser(String uid, Map<String, dynamic> data) async {
    await firestore.collection('users').doc(uid).update(data);
  }

  Future<void> deleteUser(String uid) async {
    await firestore.collection('users').doc(uid).delete();
  }

  Future<void> followUser(String uid) async {
    await firestore.collection('users').doc(uid).update({
      'followers': FieldValue.arrayUnion([auth.currentUser!.uid])
    });
  }

  Future<void> unfollowUser(String uid) async {
    await firestore.collection('users').doc(uid).update({
      'followers': FieldValue.arrayRemove([auth.currentUser!.uid])
    });
  }
}
