import 'package:app/model/user_model.dart';
import 'package:app/repository/user_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../model/trip_model.dart';

class Server{

  final _userRepo = Get.put(UserRepository());

  final _db = FirebaseFirestore.instance;

  void addUser(String uid, UserModel user) async{
    await _db.collection("Users")
        .doc(uid)
        .set(user.toJson())
        .then((_) => {print("Accepted")})
        .catchError((error) => {print("Error")});
  }

  void addTrip(TripModel trip) async {
    await _db.collection("Users")
        .doc(getUID())
        .collection("Trips")
        .add(trip.toJson());
  }

  static String getUID() {
    return FirebaseAuth.instance.currentUser!.uid;
  }
}