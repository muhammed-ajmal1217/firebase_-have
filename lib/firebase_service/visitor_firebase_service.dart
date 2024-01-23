import 'package:badgemachinetestapp/model/data_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VisitorFirebaseService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addData(DataModel data) async {
    try {
      await firestore.collection('visitor').add(data.toJson());
    } catch (e) {
      print('Error adding payment to Firestore: $e');
      throw Exception('Failed to add payment to Firestore');
    }
  }

  Future<List<DataModel>> getData() async {
    try {
      QuerySnapshot querySnapshot = await firestore.collection('visitor').get();
      return querySnapshot.docs
          .map((doc) => DataModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error getting payments from Firestore: $e');
      throw Exception('Failed to get payments from Firestore');
    }
  }
}
