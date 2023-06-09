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

  Future<String> getName() async {
    DocumentSnapshot snapshot = await  _db.collection("Users")
    .doc(getUID()).get();
    Map<String, dynamic> data =  snapshot.data() as Map<String, dynamic>;
    return data['fName'];
  }

  void addUser(String uid, UserModel user) async{
    await _db.collection("Users")
        .doc(uid)
        .set(user.toJson())
        .then((_) => {print("Accepted")})
        .catchError((error) => {print("Error")});
  }

  void addTrip(BasicTripModel trip) async {
    TripWithOwner tripWithOwner = TripWithOwner(owner: getUID(), tripDetails: trip);
    await _db.collection("Trips")
        .add(tripWithOwner.toJson());
  }

  void deleteTrip(String tripID) async{
    await _db.collection("Trips")
        .doc(tripID)
        .delete();
  }

  void editTrip(String tripID, BasicTripModel trip) async{
    await _db.collection('Trips')
        .doc(tripID)
        .update(trip.toJson());
  }

  Future<Map<String, dynamic>> getUserData() async {
    final userDocumentRef = _db.collection("Users").doc(getUID());
    final DocumentSnapshot snapshot = await userDocumentRef.get();
    final userData = snapshot.data()! as Map<String, dynamic>;
    return userData;
  }

  Future<List<Map<String, dynamic>>> getOwnedTrips() async {
    tripsList.clear();

    final tripsCollectionRef = _db.collection("Trips");

    try{
      final QuerySnapshot snapshot = await tripsCollectionRef.where('owner', isEqualTo: getUID()).get();
      snapshot.docs.forEach((DocumentSnapshot doc) {
        final tripData = doc.data()! as Map<String, dynamic>;
        tripData['tripID'] = doc.id;
        tripsList.add(tripData);
      });
      return tripsList;
    } catch (error) {
      print("Error");
      return tripsList;
    }
  }
}