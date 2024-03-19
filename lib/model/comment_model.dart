import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  final String userId;
  final String comment;
  final String postId;
  final Timestamp createdAt;
  final List likes;
  final List comments;
  String? commentImage;

  CommentModel({
    required this.userId,
    required this.comment,
    required this.postId,
    required this.createdAt,
    required this.likes,
    required this.comments,
    this.commentImage,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'comment': comment,
      'postId': postId,
      'createdAt': createdAt,
      'likes': likes,
      'comments': comments,
      'commentImage': commentImage,
    };
  }

  static CommentModel fromJson(Map<String, dynamic> json) {
    return CommentModel(
      userId: json['userId'],
      comment: json['comment'],
      postId: json['postId'],
      createdAt: json['createdAt'],
      likes: json['likes'],
      comments: json['comments'],
      commentImage: json['commentImage'],
    );
  }

  Stream<CommentModel> fromFirestore(DocumentSnapshot snapshot) {
    return snapshot.reference.snapshots().map((event) {
      return CommentModel.fromJson(event.data() as Map<String, dynamic>);
    });
  }
}
