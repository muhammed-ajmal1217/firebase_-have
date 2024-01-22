import 'dart:io';
import 'package:badgemachinetestapp/controller/payment_provider.dart';
import 'package:badgemachinetestapp/helpers/spacing.dart';
import 'package:badgemachinetestapp/model/data_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentAdding extends StatefulWidget {
  final DataModel data;

  PaymentAdding({Key? key, required this.data}) : super(key: key);

  @override
  _PaymentAddingState createState() => _PaymentAddingState();
}

class _PaymentAddingState extends State<PaymentAdding> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PaymentProvider>(builder: (context, provider, child) {
      return AlertDialog(
        actions: [
          spacingHeight(20),
          Center(
            child: CircleAvatar(
              backgroundImage: FileImage(File(widget.data.imagePath ?? '')),
            ),
          ),
          spacingHeight(10),
          Center(child: Text(widget.data.visitorName)),
          ListTile(
            title: Text('CASH'),
            trailing: Switch(
              value: provider.cashSwitch,
              onChanged: (newValue) {
                print('Switch onChanged: $newValue');
                provider.updateSwitches(cash: newValue);
              },
            ),
          ),
          spacingHeight(20),
          ListTile(
            title: Text('UPI'),
            trailing: Switch(
              value: provider.upiSwitch,
              onChanged: (newValue) {
                print('Switch onChanged: $newValue');

                provider.updateSwitches(upi: newValue);
              },
            ),
          ),
          spacingHeight(10),
          ListTile(
            title: Text('LATER'),
            trailing: Switch(
              value: provider.laterSwitch,
              onChanged: (newValue) {
                print('Switch onChanged: $newValue');
                provider.updateSwitches(later: newValue);
              },
            ),
          ),
          spacingHeight(10),
          TextFormField(
            controller: provider.amountController,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.currency_rupee),
              hintText: 'Enter amount eg:2500',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  provider.addPayments(
                      provider.cashSwitch
                          ? 'CASH'
                          : (provider.upiSwitch
                              ? 'UPI'
                              : (provider.laterSwitch ? 'LATER' : '')),
                      widget.data.visitorName);
                },
                child: Text('Done'),
              ),
            ],
          ),
        ],
      );
    });
  }
}
