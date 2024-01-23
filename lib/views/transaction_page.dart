import 'package:badgemachinetestapp/controller/payment_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TransactionPage extends StatefulWidget {
  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<PaymentProvider>(context, listen: false).getPayments();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Center(child: Text('Transaction',style: GoogleFonts.montserrat(color: Colors.white),)),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Provider.of<PaymentProvider>(context, listen: false)
                    .clearTransaction();
              },
              child: Text(
                'Clear',
                style: TextStyle(fontSize: 16, color: Colors.blue),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Primary',
                      style: GoogleFonts.montserrat(
                          fontSize: 18, fontWeight: FontWeight.w700,color: Colors.white),
                    ),
                    Text(
                      'Attendance',
                      style: GoogleFonts.montserrat(
                          fontSize: 18, fontWeight: FontWeight.w700,color: Colors.white),
                    ),
                  ],
                ),
                Expanded(
                  child: Consumer<PaymentProvider>(
                    builder: (context, paymentProvider, child) {
                      return ListView.builder(
                        itemCount: paymentProvider.payments.length,
                        itemBuilder: (context, index) {
                          final data = paymentProvider.payments[index];
                          return Padding(
                            padding: const EdgeInsets.only(
                                top: 10, left: 20, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(data.name,
                                        style: GoogleFonts.montserrat(color: Colors.white,fontSize: 16),),
                                    Text(
                                      "${data.amount}-${data.paymentMethod}",
                                      style: GoogleFonts.montserrat(color: Colors.white,fontSize: 12),
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(data.name,
                                        style: GoogleFonts.montserrat(color: Colors.white,fontSize: 16),),
                                    Text(
                                      DateFormat.jm()
                                          .format(DateTime.now().toLocal()),
                                      style: GoogleFonts.montserrat(color: Colors.white,fontSize: 12),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Consumer<PaymentProvider>(
            builder: (context, value, child) => Container(
              height: 80,
              width: double.infinity,
              color:  Colors.black,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          "Cash",
                          style: GoogleFonts.montserrat(color: Colors.white,fontSize: 12),
                        ),
                        Text(
                          value.totalcash.toString(),
                          style: GoogleFonts.montserrat(
                              color: Colors.green,
                              fontSize: 17,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "Upi",
                          style: GoogleFonts.montserrat(color: Colors.white,fontSize: 12),
                        ),
                        Text(
                          value.totalupi.toString(),
                          style: GoogleFonts.montserrat(
                              color: Colors.orange,
                              fontSize: 17,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "Later",
                          style: GoogleFonts.montserrat(color: Colors.white,fontSize: 12),
                        ),
                        Text(
                          value.totallater.toString(),
                          style: GoogleFonts.montserrat(
                              color: Colors.red,
                              fontSize: 17,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
