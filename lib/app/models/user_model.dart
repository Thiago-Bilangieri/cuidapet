import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  final String email;
  final String registerType;
  final String imgAvatar;
  UserModel({
    required this.email,
    required this.registerType,
    required this.imgAvatar,
  });

  UserModel.empty()
      : email = "",
        registerType = "",
        imgAvatar = "";

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'register_type': registerType,
      'img_avatar': imgAvatar,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: (map['email'] ?? '') as String,
      registerType: (map['register_type'] ?? '') as String,
      imgAvatar: (map['img_avatar'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
