import 'package:badgemachinetestapp/model/payment_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentFirebaseService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addPayment(PaymentModel data) async {
    try {
      await firestore.collection('payments').add(data.toJson());
    } catch (e) {
      throw Exception('Failed to add payment to Firestore');
    }
  }

Future<List<PaymentModel>> getPayments() async {
  try {
    QuerySnapshot querySnapshot = await firestore.collection('payments').get();
    return querySnapshot.docs
        .map((doc) => PaymentModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  } catch (e) {
    throw Exception('Failed to get payments from Firestore');
  }
}


  Future<void> clearAllPayments() async {
    try {
      await firestore.collection('payments').get().then((snapshot) {
        for (var doc in snapshot.docs) {
          doc.reference.delete();
        }
      });
    } catch (e) {
      throw Exception('Failed to clear payments in Firestore');
    }
  }
}
