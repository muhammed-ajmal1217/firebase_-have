
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_flutter/adapters.dart';
part 'payment_model.g.dart';
@HiveType(typeId: 2)
class PaymentModel{
  @HiveField(0)
  String name;
  @HiveField(1)
  dynamic amount;
  @HiveField(2)
  String paymentMethod;
  @HiveField(3)
  DateTime time;
  PaymentModel({
    required this.name,
    required this.amount,
    required this.paymentMethod,
    required this.time,
  });
    factory PaymentModel.fromJson(Map<String, dynamic> json) {
  return PaymentModel(
    name: json['name'],
    amount: json['amount'],
    paymentMethod: json['payment'],
    time: (json['time'] as Timestamp).toDate(),
  );
}

  Map<String,dynamic> toJson(){
    return{
      'name':name,
      'amount':amount,
      'payment':paymentMethod,
      'time':time,
    };
  }
  
}