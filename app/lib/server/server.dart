import 'package:app/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/trip_model.dart';

class Server{

  // final _userRepo = Get.put(UserRepository());

  List<Map<String, dynamic>> tripsList = [];

  final _db = FirebaseFirestore.instance;

  static String getUID() {
    return FirebaseAuth.instance.currentUser!.uid;
  }

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

  Future<Map<String, dynamic>> getUserData() async {
    final userDocumentRef = _db.collection("Users").doc(getUID());
    final DocumentSnapshot snapshot = await userDocumentRef.get();
    final userData = snapshot.data()! as Map<String, dynamic>;
    return userData;
  }

  Future<List<Map<String, dynamic>>> getTrips() async {
    tripsList.clear();

    final tripsCollectionRef = _db.collection("Users").doc(getUID()).collection("Trips");

    try{
      final QuerySnapshot snapshot = await tripsCollectionRef.get();
      snapshot.docs.forEach((DocumentSnapshot doc) {
        final tripData = doc.data()! as Map<String, dynamic>;
        tripsList.add(tripData);
      });
      return tripsList;
    } catch (error) {
      print("Error");
      return tripsList;
    }
  }
}