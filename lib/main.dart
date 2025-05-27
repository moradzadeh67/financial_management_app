import 'package:financial_management_app/model/money.dart';
import 'package:financial_management_app/screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(MoneyAdapter());
  await Hive.openBox<Money>('monyBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Dirooz'),
      debugShowCheckedModeBanner: false,
      title: 'اپلیکیشن مدیریت مالی',
      home: MainScreen(),
    );
  }
}
