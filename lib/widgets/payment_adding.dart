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
        backgroundColor: const Color.fromARGB(255, 21, 21, 21),
        actions: [
          spacingHeight(20),
          Center(
            child: CircleAvatar(
              backgroundImage: FileImage(File(widget.data.imagePath ?? '')),
            ),
          ),
          spacingHeight(10),
          Center(child: Text(widget.data.visitorName,style: TextStyle(color: Colors.white),)),
          ListTile(
            title: Text('CASH',style: TextStyle(color: Colors.white),),
            trailing: Switch(
              focusColor: Colors.orange,
              value: provider.cashSwitch,
              onChanged: (newValue) {
                print('Switch onChanged: $newValue');
                provider.updateSwitches(cash: newValue);
              },
            ),
          ),
          spacingHeight(20),
          ListTile(
            title: Text('UPI',style: TextStyle(color: Colors.white),),
            trailing: Switch(
              focusColor: Colors.orange,
              value: provider.upiSwitch,
              onChanged: (newValue) {
                print('Switch onChanged: $newValue');
                provider.updateSwitches(upi: newValue);
              },
            ),
          ),
          spacingHeight(10),
          ListTile(
            title: Text('LATER',style: TextStyle(color: Colors.white),),
            trailing: Switch(
              focusColor: Colors.orange,
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
            style: TextStyle(color: Colors.white),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.currency_rupee,color: const Color.fromARGB(255, 143, 143, 143)),
              hintText: 'Enter amount eg:2500',
              hintStyle: TextStyle(color: const Color.fromARGB(255, 143, 143, 143)),
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
                child: Text('Cancel',style: TextStyle(color: Colors.amber),),
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
                      provider.calculateTotal();
                    Navigator.pop(context);
                },
                child: Text('Done',style: TextStyle(color: Colors.amber),),
              ),
            ],
          ),
        ],
      );
    });
  }
}
