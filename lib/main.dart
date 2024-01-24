
import 'package:badgemachinetestapp/controller/homepage_provider.dart';
import 'package:badgemachinetestapp/controller/payment_provider.dart';
import 'package:badgemachinetestapp/model/data_model.dart';
import 'package:badgemachinetestapp/model/payment_model.dart';
import 'package:badgemachinetestapp/views/homepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: 'AIzaSyCNWCP2Ex0amFF8xggp6LV2b2O7Hrl1SpM',
            appId: '1:191851436679:android:45a8087e78ecd56059b622',
            messagingSenderId: '191851436679',
            storageBucket: "badgetestfirebase.appspot.com",
            projectId: 'badgetestfirebase',));
  } catch (e) {
    // ignore: avoid_print
    print('Error initializing Firebase: $e');
  }
  await Hive.initFlutter();
  Hive.registerAdapter(DataModelAdapter());
  Hive.registerAdapter(PaymentModelAdapter());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeProvider()),
        ChangeNotifierProvider(create: (context) => PaymentProvider()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
