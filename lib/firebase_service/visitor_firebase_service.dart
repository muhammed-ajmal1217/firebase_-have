import 'package:badgemachinetestapp/model/data_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class VisitorFirebaseService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Reference firebaseStorage = FirebaseStorage.instance.ref();
  String downloadurl = '';
  Future<void> addData(DataModel data) async {
    try {
      await firestore.collection('visitor').add(data.toJson());
    } catch (e) {
      throw Exception('Failed to add payment to Firestore');
    }
  }

  Future<List<DataModel>> getData() async {
    try {
      QuerySnapshot querySnapshot = await firestore.collection('visitor').get();
      return querySnapshot.docs
          .map((doc) =>
              DataModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to get payments from Firestore $e');
    }
  }

  Future<void> clearAllData() async {
    try {
      QuerySnapshot querySnapshot =
          await firestore.collection('visitor').get();

      for (QueryDocumentSnapshot document in querySnapshot.docs) {
        await document.reference.delete();
      }
    } catch (e) {
      throw Exception('Failed to clear data in Firestore');
    }
  }
    imageAdder({image, name}) async {
    Reference childfolder = firebaseStorage.child('images');
    Reference imageupload = childfolder.child("$image.jpg");
    try {
      await imageupload.putFile(image);
      downloadurl = await imageupload.getDownloadURL();
    } catch (e) {
      throw Exception(e);
    }
  }
}
