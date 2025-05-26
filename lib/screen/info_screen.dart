import 'package:flutter/material.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 15, top: 15, left: 5),
                child: Text(
                  'مدیریت تراکنشها به تومان',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15, top: 20, left: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Expanded(child: Text('0')),
                    Text(' : دریافتی امروز'),
                    Expanded(child: Text('0')),
                    Text(' : پرداختی امروز'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
