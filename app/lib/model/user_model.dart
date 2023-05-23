import 'dart:convert';

class UserModel {
  final String? id;
  final String fName;
  final String lName;
  final String userName;
  final String eMail;

  const UserModel({
    this.id,
    required this.fName,
    required this.lName,
    required this.userName,
    required this.eMail,
  });

  factory UserModel.fromJson(Map<String, dynamic> jsonData) =>
    UserModel(
      id: jsonData['id'],
      fName: jsonData['fName'],
      lName: jsonData['lName'],
      userName: jsonData['userName'],
      eMail: jsonData['eMail'],
    );

  Map<String, dynamic> toJson() => {
    'fName': fName,
    'lName': lName,
    'userName': userName,
    'eMail': eMail,
  };

  static String serialize(UserModel myUser) =>
      json.encode(myUser.toJson());

  static UserModel deserialize(String? json) =>
      UserModel.fromJson(jsonDecode(json!));

}