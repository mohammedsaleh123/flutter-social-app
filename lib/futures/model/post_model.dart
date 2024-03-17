import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String caption;
  final String uid;
  final String postId;
  final String postImage;
  final List<String> likes;
  final List<String> userSaved;
  final Timestamp createdAt;

  PostModel({
    required this.caption,
    required this.uid,
    required this.postId,
    required this.postImage,
    required this.likes,
    required this.userSaved,
    required this.createdAt,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      caption: json['caption'],
      uid: json['uid'],
      postId: json['postId'],
      postImage: json['postImage'],
      likes: List<String>.from(json['likes']),
      userSaved: List<String>.from(json['userSaved']),
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'caption': caption,
      'uid': uid,
      'postId': postId,
      'postImage': postImage,
      'likes': likes,
      'userSaved': userSaved,
      'createdAt': createdAt,
    };
  }

  Stream<PostModel> fromFirestore(DocumentSnapshot snapshot) {
    return snapshot.reference.snapshots().map((event) {
      return PostModel.fromJson(event.data() as Map<String, dynamic>);
    });
  }
}
