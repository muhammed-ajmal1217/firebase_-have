import 'dart:io';
import 'package:badgemachinetestapp/controller/homepage_provider.dart';
import 'package:badgemachinetestapp/controller/payment_provider.dart';
import 'package:badgemachinetestapp/helpers/spacing.dart';
import 'package:badgemachinetestapp/model/data_model.dart';
import 'package:badgemachinetestapp/widgets/total_amount_categories.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentAdding extends StatefulWidget {
  final DataModel data;

  PaymentAdding({Key? key, required this.data}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _PaymentAddingState createState() => _PaymentAddingState();
}

class _PaymentAddingState extends State<PaymentAdding> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<PaymentProvider,HomeProvider>(builder: (context, provider,homepro, child) {
      return AlertDialog(
        backgroundColor: const Color.fromARGB(255, 21, 21, 21),
        actions: [
          spacingHeight(20),
          Center(
            child: CircleAvatar(
                    backgroundImage: widget.data.imagePath != null
                        ? homepro.isConnected
                            ? NetworkImage(widget.data.imagePath!)
                            : FileImage(File(widget.data.imagePath!)) as ImageProvider
                        : const AssetImage('assets/profilepng.png'),
                  ),
          ),
          spacingHeight(10),
          Center(
              child: Text(
            widget.data.visitorName,
            style: const TextStyle(color: Colors.white),
          )),
          TotalCashCategory(
            title: 'CASH',
            value: provider.cashSwitch,
            onChanged: (newValue) {
              provider.updateSwitches(cash: newValue);
            },
          ),
          spacingHeight(20),
          TotalCashCategory(
            title: 'UPI',
            value: provider.upiSwitch,
            onChanged: (newValue) {
              provider.updateSwitches(upi: newValue);
            },
          ),
          spacingHeight(10),
          TotalCashCategory(
            title: 'LATER',
            value: provider.laterSwitch,
            onChanged: (newValue) {
              provider.updateSwitches(later: newValue);
            },
          ),
          spacingHeight(10),
          TextFormField(
            controller: provider.amountController,
            style: const TextStyle(color: Colors.white),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.currency_rupee,
                  color: Color.fromARGB(255, 143, 143, 143)),
              hintText: 'Enter amount eg:2500',
              hintStyle:
                  const TextStyle(color: Color.fromARGB(255, 143, 143, 143)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          spacingHeight(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.amber),
                ),
              ),
              TextButton(
                onPressed: () {
                  provider.addPayments(
                    provider.cashSwitch
                        ? 'CASH'
                        : (provider.upiSwitch
                            ? 'UPI'
                            : (provider.laterSwitch ? 'LATER' : '')),
                    widget.data.visitorName
                  );
                  provider.calculateTotal();
                  Navigator.pop(context);
                },
                child: const Text(
                  'Done',
                  style: TextStyle(color: Colors.amber),
                ),
              ),
            ],
          ),
        ],
      );
    });
  }
}
