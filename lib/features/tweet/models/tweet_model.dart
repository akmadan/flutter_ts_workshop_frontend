import 'dart:convert';

class TweetModel {
  final TweetDataModel tweet;
  final AdminDataModel admin;
  TweetModel({
    required this.tweet,
    required this.admin,
  });

  Map<String, dynamic> toMap() {
    return {
      'tweet': tweet.toMap(),
      'admin': admin.toMap(),
    };
  }

  factory TweetModel.fromMap(Map<String, dynamic> map) {
    return TweetModel(
      tweet: TweetDataModel.fromMap(map['tweet']),
      admin: AdminDataModel.fromMap(map['admin']),
    );
  }

  String toJson() => json.encode(toMap());

  factory TweetModel.fromJson(String source) =>
      TweetModel.fromMap(json.decode(source));
}

class AdminDataModel {
  final String uid;
  final String firstName;
  final String lastNAme;
  final String email;
  // final DateTime createdAt;
  AdminDataModel({
    required this.uid,
    required this.firstName,
    required this.lastNAme,
    required this.email,
    // required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'firstName': firstName,
      'lastNAme': lastNAme,
      'email': email,
      // 'createdAt': createdAt.toIso8601String(),
    };
  }

  factory AdminDataModel.fromMap(Map<String, dynamic> map) {
    return AdminDataModel(
      uid: map['uid'] ?? '',
      firstName: map['firstName'] ?? '',
      lastNAme: map['lastNAme'] ?? '',
      email: map['email'] ?? '',
      // createdAt: DateTime.parse(map['createdAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory AdminDataModel.fromJson(String source) =>
      AdminDataModel.fromMap(json.decode(source));
}

class TweetDataModel {
  final String tweetId;
  final String content;
  final DateTime createdAt;
  final String adminId;
  TweetDataModel({
    required this.tweetId,
    required this.content,
    required this.createdAt,
    required this.adminId,
  });

  Map<String, dynamic> toMap() {
    return {
      'tweetId': tweetId,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
      'adminId': adminId,
    };
  }

  factory TweetDataModel.fromMap(Map<String, dynamic> map) {
    return TweetDataModel(
      tweetId: map['tweetId'] ?? '',
      content: map['content'] ?? '',
      createdAt: DateTime.parse(map['createdAt']),
      adminId: map['adminId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TweetDataModel.fromJson(String source) =>
      TweetDataModel.fromMap(json.decode(source));
}
