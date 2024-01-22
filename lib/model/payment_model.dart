
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
  PaymentModel({
    required this.name,
    required this.amount,
    required this.paymentMethod,
  });
}