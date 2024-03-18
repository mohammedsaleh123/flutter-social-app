import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String userName;
  final String email;
  final String profileImage;
  List? following;
  List? followers;
  List? savedChats;
  final Timestamp createdAt;

  UserModel({
    required this.uid,
    required this.userName,
    required this.email,
    required this.profileImage,
    this.following,
    this.followers,
    this.savedChats,
    required this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      userName: json['userName'],
      email: json['email'],
      profileImage: json['profileImage'],
      following: json['following'],
      followers: json['followers'],
      savedChats: json['savedChats'],
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'userName': userName,
      'email': email,
      'profileImage': profileImage,
      'following': following,
      'followers': followers,
      'savedChats': savedChats,
      'createdAt': createdAt,
    };
  }

  Future<UserModel> fromFirestore(DocumentSnapshot snapshot) async {
    return UserModel(
      uid: snapshot.get('uid'),
      userName: snapshot.get('userName'),
      email: snapshot.get('email'),
      profileImage: snapshot.get('profileImage'),
      following: snapshot.get('following'),
      followers: snapshot.get('followers'),
      savedChats: snapshot.get('savedChats'),
      createdAt: snapshot.get('createdAt'),
    );
  }
}
