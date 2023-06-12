
import 'package:app/model/entry_model.dart';
import 'package:app/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'model/trip_model.dart';

class FirebaseHandler{

  final List<Map<String, dynamic>> _tripsList = [];
  final List<Map<String, dynamic>> _ongoingAndFutureTripsList = [];
  final List<Map<String, dynamic>> _itineraryList = [];

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

  void addEntry(String tripId, ItineraryEntry entry) async {

    await _db.collection("Trips")
        .doc(tripId)
        .collection("Itinerary")
        .add(entry.toJson());
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



  Future<Map<String, dynamic>> getTripDetails(String tripID) async {
    final tripsDocumentRef = _db.collection("Trips").doc(tripID);
    final DocumentSnapshot snapshot = await tripsDocumentRef.get();
    final tripData = snapshot.data()! as Map<String, dynamic>;
    return tripData;
  }

  Future<Map<String, dynamic>> getUserData() async {
    final userDocumentRef = _db.collection("Users").doc(getUID());
    final DocumentSnapshot snapshot = await userDocumentRef.get();
    final userData = snapshot.data()! as Map<String, dynamic>;
    return userData;
  }

  Future<List<Map<String, dynamic>>> getItinerary(String tripID) async {
    _itineraryList.clear();

    final itineraryCollectionRef =
    _db.collection("Trips")
        .doc(tripID)
        .collection("Itinerary");

    try{
      final QuerySnapshot snapshot = await itineraryCollectionRef.get();
      snapshot.docs.forEach((DocumentSnapshot doc) {
        final itineraryEntry = doc.data()! as Map<String, dynamic>;
        _itineraryList.add(itineraryEntry);
      });
      return _itineraryList;
    } catch(error) {
      print("Error getting the itinerary list");
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getOngoingAndFutureTrips() async{
    _ongoingAndFutureTripsList.clear();

    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day, 0, 0 ,0);
    Timestamp todayTimestamp = Timestamp.fromDate(today);
    
    final tripsCollectionRef = _db.collection("Trips");

    try{
      final QuerySnapshot snapshot = await tripsCollectionRef
          .where('startDate', isLessThan: todayTimestamp)
          .get();
      snapshot.docs.forEach((DocumentSnapshot doc) {
        final tripData = doc.data()! as Map<String, dynamic>;
        tripData['ongoing'] = true;
        tripData['tripID'] = doc.id;
        Timestamp endDate = tripData['endDate'] as Timestamp;
        if (todayTimestamp.compareTo(endDate) < 0) {
          _ongoingAndFutureTripsList.add(tripData);
        }
      });
    } catch (error) {
      print(error.toString());
      print("Error getting Ongoing Trips!");
    }


    // get future trips
    try{
      final QuerySnapshot snapshot = await tripsCollectionRef
          .where("startDate", isGreaterThanOrEqualTo: todayTimestamp)
          .orderBy("startDate", descending: false)
          .get();
      snapshot.docs.forEach((DocumentSnapshot doc) {
        final tripData = doc.data()! as Map<String, dynamic>;
        tripData['ongoing'] = false;
        tripData['tripID'] = doc.id;
        _ongoingAndFutureTripsList.add(tripData);
      });
      return _ongoingAndFutureTripsList;
    } catch (error) {
      print("Error getting Future Trips!");
      return [];
    }
    
  }


  Future<List<Map<String, dynamic>>> getOwnedTrips() async {
    _tripsList.clear();

    final tripsCollectionRef = _db.collection("Trips");

    try{
      final QuerySnapshot snapshot = await tripsCollectionRef.where('owner', isEqualTo: getUID()).get();
      snapshot.docs.forEach((DocumentSnapshot doc) {
        final tripData = doc.data()! as Map<String, dynamic>;
        tripData['tripID'] = doc.id;
        _tripsList.add(tripData);
      });
      return _tripsList;
    } catch (error) {
      print("Error getting Owned Trips");
      return [];
    }
  }
}