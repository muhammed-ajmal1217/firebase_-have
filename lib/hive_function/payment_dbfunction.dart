
import 'package:badgemachinetestapp/model/payment_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

ValueNotifier<List<PaymentModel>> paymentNotifier=ValueNotifier([]);
addPayment(PaymentModel data)async{
  final payDb=await Hive.openBox<PaymentModel>('payment_box');
  payDb.add(data);
  List<PaymentModel> datas = payDb.values.toList();
  paymentNotifier.value=datas;
  paymentNotifier.notifyListeners();
}
 getPayments() async {
  final dataDb = await Hive.openBox<PaymentModel>('payment_box');
  List<PaymentModel> datas = dataDb.values.toList();
  paymentNotifier.value = datas;
  paymentNotifier.notifyListeners();
  return datas;
}
clearTransaction()async{
  final dataDb = await Hive.openBox<PaymentModel>('payment_box');
  await dataDb.clear();
  await Hive.deleteBoxFromDisk('payment_box');
}