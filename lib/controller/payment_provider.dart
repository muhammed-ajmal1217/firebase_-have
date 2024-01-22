import 'package:badgemachinetestapp/hive_function/payment_dbfunction.dart';
import 'package:badgemachinetestapp/model/payment_model.dart';
import 'package:flutter/material.dart';

class PaymentProvider extends ChangeNotifier{
  bool upiSwitch = false;
  bool cashSwitch = false;
  bool laterSwitch = false;
  TextEditingController amountController = TextEditingController();
    void addPayments(String selectedPayment,String name) async {
    final amount = amountController.text.trim();
    final data = PaymentModel(
      name: name,
      amount: amount,
      paymentMethod: selectedPayment,
    );
    await addPayment(data);
    amountController.clear();
    notifyListeners();
  }
    void updateSwitches({bool? cash, bool? upi, bool? later}) {
    if (cash != null) cashSwitch = cash;
    if (upi != null) upiSwitch = upi;
    if (later != null) laterSwitch = later;
    notifyListeners();
  }
}