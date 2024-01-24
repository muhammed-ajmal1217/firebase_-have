import 'package:badgemachinetestapp/helpers/spacing.dart';
import 'package:badgemachinetestapp/views/transaction_page.dart';
import 'package:badgemachinetestapp/widgets/visitor_adding.dart';
import 'package:flutter/material.dart';

class HomeButtons extends StatelessWidget {
  const HomeButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 10,
      bottom: 340,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: Colors.orange,
            heroTag: 'person',
            shape: const CircleBorder(),
            child: const Icon(Icons.person_add, color: Colors.white),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return const PersonAdding();
                },
              );
            },
          ),
          spacingHeight(10),
          FloatingActionButton(
            backgroundColor: Colors.orange,
            heroTag: 'transaction',
            shape: const CircleBorder(),
            child: const Icon(Icons.attach_money, color: Colors.white),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TransactionPage(),
                  ));
            },
          ),
        ],
      ),
    );
  }
}