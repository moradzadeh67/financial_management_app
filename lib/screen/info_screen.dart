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
              const MonyInfoWidget(
                firstText: ' : دریافتی امروز ',
                firstPrice: '0',
                secondText: ': پرداختی امروز ',
                secondPrice: '0',
              ),
              const MonyInfoWidget(
                firstText: ' : دریافتی این ماه',
                firstPrice: '0',
                secondText: ': پرداختی این ماه',
                secondPrice: '0',
              ),
              const MonyInfoWidget(
                firstText: ' : دریافتی امسال',
                firstPrice: '0',
                secondText: ': پرداختی امسال',
                secondPrice: '0',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MonyInfoWidget extends StatelessWidget {
  final String firstText;
  final String secondText;
  final String firstPrice;
  final String secondPrice;
  const MonyInfoWidget({
    super.key,
    required this.firstText,
    required this.secondText,
    required this.firstPrice,
    required this.secondPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, top: 20, left: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Text(
              secondPrice,
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: 14),
            ),
          ),
          Text(
            secondText,
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 14),
          ),

          Expanded(
            child: Text(
              firstPrice,
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: 14),
            ),
          ),
          Text(firstText, style: TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
