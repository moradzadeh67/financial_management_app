import 'package:financial_management_app/model/money.dart';
import 'package:financial_management_app/screen/home_screen.dart';
import 'package:financial_management_app/screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(MoneyAdapter());
  await Hive.openBox<Money>('moneyBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static void getData() {
    HomeScreen.moneys.clear();
    Box<Money> moneyBox = Hive.box<Money>('moneyBox');
    for (var money in moneyBox.values) {
      HomeScreen.moneys.add(money);
    }
  }

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
