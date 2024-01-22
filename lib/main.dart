import 'package:badgemachinetestapp/controller/homepage_provider.dart';
import 'package:badgemachinetestapp/controller/payment_provider.dart';
import 'package:badgemachinetestapp/controller/person_adding_provider.dart';
import 'package:badgemachinetestapp/model/data_model.dart';
import 'package:badgemachinetestapp/model/payment_model.dart';
import 'package:badgemachinetestapp/views/homepage.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(DataModelAdapter().typeId)) {
    Hive.registerAdapter(DataModelAdapter());
  }
  if (!Hive.isAdapterRegistered(PaymentModelAdapter().typeId)) {
    Hive.registerAdapter(PaymentModelAdapter());
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeProvider(),),
        ChangeNotifierProvider(create: (context) => PersonAddingProvider(),),
        ChangeNotifierProvider(create: (context) => PaymentProvider(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
