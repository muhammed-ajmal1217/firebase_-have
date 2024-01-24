import 'package:badgemachinetestapp/firebase_service/payment_firebase_service.dart';
import 'package:badgemachinetestapp/hive_function/payment_dbfunction.dart';
import 'package:badgemachinetestapp/model/payment_model.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class PaymentProvider extends ChangeNotifier {
  bool upiSwitch = false;
  bool cashSwitch = false;
  bool laterSwitch = false;
  List<PaymentModel> payments = [];
  PaymentDBFunction dbFunction = PaymentDBFunction();
  TextEditingController amountController = TextEditingController();
  List cash = [];
  List upi = [];
  List later = [];
  dynamic totalcash = 0;
  dynamic totalupi = 0;
  dynamic totallater = 0;
  dynamic total = 0;

  void addPayments(String selectedPayment, String name) async {
    final amount = amountController.text.trim();
    final data = PaymentModel(
      name: name,
      amount: amount,
      paymentMethod: selectedPayment,
      time: DateTime.now(),
    );
    payments.add(data);
     dbFunction.addPayment(data);
     PaymentFirebaseService().addPayment(data);
     dbFunction.getPayments();
     PaymentFirebaseService().getPayments();
    calculateTotal();
    amountController.clear();
    notifyListeners();
  }

  void updateSwitches({bool? cash, bool? upi, bool? later}) {
    if (cash != null) cashSwitch = cash;
    if (upi != null) upiSwitch = upi;
    if (later != null) laterSwitch = later;
    notifyListeners();
  }

  getPayments() async {
    var connectionResult = await Connectivity().checkConnectivity();
    if (connectionResult == ConnectivityResult.none) {
      payments = await dbFunction.getPayments();
      notifyListeners();
    } else {
      payments = await PaymentFirebaseService().getPayments();
      notifyListeners();
    }
    notifyListeners();
    calculateTotal();
  }

  clearTransaction() async {
    await dbFunction.clearTransaction();
    await PaymentFirebaseService().clearAllPayments();
    getPayments();
    notifyListeners();
  }

  void calculateTotal() {
    cash.clear();
    upi.clear();
    later.clear();

    for (var i = 0; i < payments.length; i++) {
      if (payments[i].paymentMethod == "CASH") {
        cash.add(payments[i].amount);
      } else if (payments[i].paymentMethod == "UPI") {
        upi.add(payments[i].amount);
      } else if (payments[i].paymentMethod == "LATER") {
        later.add(payments[i].amount);
      }
    }

    totalcash = cash.fold(0, (a, b) => a + parseAmount(b));
    totalupi = upi.fold(0, (a, b) => a + parseAmount(b));
    totallater = later.fold(0, (a, b) => a + parseAmount(b));
    total=totalcash+totalupi+totallater;
    notifyListeners();
  }

  int parseAmount(dynamic value) {
    if (value is int) {
      return value;
    } else if (value is String) {
      return int.parse(value);
    } else {
      return 0;
    }
  }
  }
