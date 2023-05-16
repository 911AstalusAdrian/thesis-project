import 'dart:convert';

class User {
  final String? fName;
  final String? lName;
  final String? userName;
  final String? eMail;
  final String? password;

  const User({
    this.fName,
    this.lName,
    this.userName,
    this.eMail,
    this.password
  });

  factory User.fromJson(Map<String, dynamic> jsonData) =>
    User(
      fName: jsonData['fName'],
      lName: jsonData['lName'],
      userName: jsonData['userName'],
      eMail: jsonData['eMail'],
      password: jsonData['password'],
    );

  static Map<String, dynamic> toJson(User user) => {
    'fName': user.fName,
    'lName': user.lName,
    'userName': user.userName,
    'eMail': user.eMail,
    'password': user.password,
  };

  static String serialize(User myUser) =>
      json.encode(User.toJson(myUser));

  static User deserialize(String? json) =>
      User.fromJson(jsonDecode(json!));

}