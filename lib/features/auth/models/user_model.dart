import 'dart:convert';

class UserModel {
  final String uid;
  final List<String> tweets;
  final String firstName;
  final String lastName;
  final String email;
  final DateTime createdAt;
  UserModel({
    required this.uid,
    required this.tweets,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'tweets': tweets,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      tweets: List.from(map['tweets'] ?? []),
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      email: map['email'] ?? '',
      createdAt:
          DateTime.parse(map['createdAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
