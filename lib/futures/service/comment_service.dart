import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socialapp/futures/model/comment_model.dart';

class CommentService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<void> addComment(String postId, Map<String, dynamic> data) async {
    await firestore
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .add(data);
  }

  Future<void> deleteComment(String postId, String commentId) async {
    await firestore
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(commentId)
        .delete();
  }

  Stream<List<CommentModel>> getComments(String postId) {
    return firestore
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .snapshots()
        .map((event) {
      return event.docs.map((e) => CommentModel.fromJson(e.data())).toList();
    });
  }

  Future<void> addLikeToComment(
      String postId, String commentId, String userId) async {
    return firestore
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(commentId)
        .update({
      'likes': FieldValue.arrayUnion([userId])
    });
  }
}
