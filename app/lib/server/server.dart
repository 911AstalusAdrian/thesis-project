import 'package:app/model/user_model.dart';
import 'package:app/repository/user_repository.dart';
import 'package:get/get.dart';

class Server{

  final _userRepo = Get.put(UserRepository());

  void addUser(String uid, UserModel user) async{
    await _userRepo.createUser(uid, user);
  }

  getUserFromUid(String uid) async {
    _userRepo.getUser(uid);
  }

}