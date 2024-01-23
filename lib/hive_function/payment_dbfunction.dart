import 'package:badgemachinetestapp/model/payment_model.dart';
import 'package:hive_flutter/adapters.dart';

class PaymentDBFunction {
  Future<void> addPayment(PaymentModel data) async {
    final payDb = await Hive.openBox<PaymentModel>('payment_box');
    payDb.add(data);
  }

  Future<List<PaymentModel>> getPayments() async {
    final dataDb = await Hive.openBox<PaymentModel>('payment_box');
    return dataDb.values.toList();
  }

  Future<void> clearTransaction() async {
    final dataDb = await Hive.openBox<PaymentModel>('payment_box');
    await dataDb.clear();
    await Hive.deleteBoxFromDisk('payment_box');
  }
}
