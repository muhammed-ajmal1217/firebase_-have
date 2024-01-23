import 'dart:io';

import 'package:badgemachinetestapp/controller/homepage_provider.dart';
import 'package:badgemachinetestapp/controller/visitor_adding_provider.dart';
import 'package:badgemachinetestapp/helpers/colors.dart';
import 'package:badgemachinetestapp/helpers/spacing.dart';
import 'package:badgemachinetestapp/hive_function/visitor_db_function.dart';
import 'package:badgemachinetestapp/model/data_model.dart';
import 'package:badgemachinetestapp/views/transaction_page.dart';
import 'package:badgemachinetestapp/widgets/payment_adding.dart';
import 'package:badgemachinetestapp/widgets/visitor_adding.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  final Function(bool)? onSwitchChanged;
  HomePage({
    Key? key,
    this.onSwitchChanged,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    getData();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Manager',style: GoogleFonts.montserrat(color: Colors.white),),
        backgroundColor: Colors.black,
      ),
      body: Consumer<HomeProvider>(builder: (context, provider, child) {
        List<DataModel> filteredData = provider.filterData(
            datas,
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
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                            color: Color.fromARGB(255, 23, 23, 23)
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.green,
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
                                      radius: 30,
                                      backgroundImage:
                                          FileImage(File(data.imagePath ?? '')),
                                    ),
                                  ),
                                ),
                              ),
                              ListTile(
                                title: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(data.visitorName,
                                        style: GoogleFonts.montserrat(color: Colors.white,fontSize: 14)),
                                    Text(data.sponsorName,
                                        style: GoogleFonts.montserrat(color: Colors.white,fontSize: 12)),
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
                              ? Colors.amber
                              : Colors.blue[50],
                        ),
                        child: Center(
                          child: Text(
                            letter,
                             style: GoogleFonts.montserrat(color: Colors.black,fontSize: 17,fontWeight: FontWeight.w800),
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
            Positioned(
              right: 10,
              bottom: 340,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  FloatingActionButton(
                    backgroundColor: Colors.orange,
                    heroTag: 'person',
                    shape: CircleBorder(),
                    child: Icon(Icons.person_add, color: Colors.white),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return PersonAdding();
                        },
                      );
                    },
                  ),
                  spacingHeight(10),
                  FloatingActionButton(
                    backgroundColor: Colors.orange,
                    heroTag: 'transaction',
                    shape: CircleBorder(),
                    child: Icon(Icons.attach_money, color: Colors.white),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TransactionPage(),
                          ));
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
