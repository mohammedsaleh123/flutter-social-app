import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socialapp/futures/model/post_model.dart';

class PostServices {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<void> addPost(PostModel model, String postId) async {
    await firestore.collection('posts').doc(postId).set(model.toJson());
  }

  Future<void> updatePost(PostModel model) async {
    await firestore
        .collection('posts')
        .doc(model.postId)
        .update(model.toJson());
  }

  Future<void> deletePost(String postId) async {
    await firestore.collection('posts').doc(postId).delete();
  }

  Stream<List<PostModel>> getPosts() {
    return firestore
        .collection('posts')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((event) {
      return event.docs.map((e) => PostModel.fromJson(e.data())).toList();
    });
  }

  Stream<PostModel> getPost(String postId) {
    return firestore.collection('posts').doc(postId).snapshots().map((event) {
      return PostModel.fromJson(event.data() as Map<String, dynamic>);
    });
  }

  Stream<List<PostModel>> getUserPosts(String uid) {
    return firestore
        .collection('posts')
        .where('uid', isEqualTo: uid)
        .snapshots()
        .map((event) {
      return event.docs.map((e) => PostModel.fromJson(e.data())).toList();
    });
  }

  Stream<List<PostModel>> getSearchPosts(String search) {
    return firestore.collection('posts').snapshots().map((event) {
      return event.docs.map((e) => PostModel.fromJson(e.data())).toList();
    });
  }

  Future<void> addLike(String postId, String uid, List likes) async {
    if (likes.contains(uid)) {
      await firestore.collection('posts').doc(postId).update({
        'likes': FieldValue.arrayRemove([uid]),
      });
    } else {
      await firestore.collection('posts').doc(postId).update({
        'likes': FieldValue.arrayUnion([uid]),
      });
    }
  }

  Future<void> savePost(String postId, String uid) async {
    await firestore.collection('posts').doc(postId).update({
      'userSaved': FieldValue.arrayUnion([uid]),
    });
  }

  Future<void> unsavePost(String postId, String uid) async {
    await firestore.collection('posts').doc(postId).update({
      'userSaved': FieldValue.arrayRemove([uid]),
    });
  }
}
