import 'dart:io';
import 'package:badgemachinetestapp/controller/homepage_provider.dart';
import 'package:badgemachinetestapp/controller/payment_provider.dart';
import 'package:badgemachinetestapp/model/data_model.dart';
import 'package:badgemachinetestapp/widgets/homepage_button.dart';
import 'package:badgemachinetestapp/widgets/payment_adding.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  final Function(bool)? onSwitchChanged;
  const HomePage({
    super.key,
    this.onSwitchChanged,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    var pro = Provider.of<HomeProvider>(context, listen: false);
    var pro1 = Provider.of<PaymentProvider>(context, listen: false);
    pro.checkConnection(context);
    pro.checkConnections(context);
    pro1.getPayments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        actions: [
          GestureDetector(
              onTap: () {
                Provider.of<HomeProvider>(context, listen: false)
                    .clearDatas(context);
              },
              child: const Text(
                'Clear',
                style: TextStyle(color: Colors.blue, fontSize: 18),
              ))
        ],
        title: Text(
          'Payment Manager',
          style: GoogleFonts.montserrat(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: Consumer2<HomeProvider, PaymentProvider>(
          builder: (context, provider, paypro, child) {
        if (!provider.isDataLoaded) {
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.black,
            backgroundColor: Colors.amber,
          ));
        }
        List<DataModel> filteredData = provider.filterData(
          provider.isConnected ? provider.firestoreData : provider.hiveData,
          String.fromCharCode('A'.codeUnitAt(0) + provider.isSelected),
        );
        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.black,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                    ),
                    itemCount: filteredData.length,
                    itemBuilder: (context, index) {
                      final data = filteredData[index];
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color.fromARGB(255, 23, 23, 23)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 2.0,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return PaymentAdding(
                                            data: data,
                                          );
                                        },
                                      );
                                    },
                                    child: CircleAvatar(
                    backgroundImage: data.imagePath != null
                        ? provider.isConnected
                            ? NetworkImage(data.imagePath!)
                            : FileImage(File(data.imagePath!)) as ImageProvider
                        : const AssetImage('assets/profilepng.png'),
                  ),
                                  ),
                                ),
                              ),
                              ListTile(
                                title: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(data.visitorName,
                                        style: GoogleFonts.montserrat(
                                            color: Colors.white, fontSize: 14)),
                                    Text(data.sponsorName,
                                        style: GoogleFonts.montserrat(
                                            color: Colors.white, fontSize: 12)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )),
            Container(
              height: 80,
              width: double.infinity,
              color: Colors.black,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 26,
                itemBuilder: (context, index) {
                  String letter =
                      String.fromCharCode('A'.codeUnitAt(0) + index);
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      child: Container(
                        height: 60,
                        width: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(80),
                          color: provider.isSelected == index
                              ? Colors.orange
                              : Colors.blue[50],
                        ),
                        child: Center(
                          child: Text(
                            letter,
                            style: GoogleFonts.montserrat(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                      ),
                      onTap: () {
                        provider.selectAlpha(index);
                      },
                    ),
                  );
                },
              ),
            ),
            const HomeButtons(),
          ],
        );
      }),
    );
  }
}
