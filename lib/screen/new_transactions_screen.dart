import 'package:financial_management_app/constant.dart';
import 'package:flutter/material.dart';

class NewTransactionsScreen extends StatefulWidget {
  const NewTransactionsScreen({super.key});

  @override
  State<NewTransactionsScreen> createState() => _NewTransactionsScreenState();
}

class _NewTransactionsScreenState extends State<NewTransactionsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          width: double.infinity,
          margin: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text('تراکنش جدید', style: TextStyle(fontSize: 22)),
              MyTextField(hintText: 'توضیحات'),
              MyTextField(hintText: 'مبلغ', type: TextInputType.number),
              TypeAndDateWidget(),
              MyButton(text: 'اضافه کردن', onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  const MyButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: kPurpleColor),
        onPressed: onPressed,
        child: Text(text, style: TextStyle(fontSize: 18, color: Colors.white)),
      ),
    );
  }
}

class TypeAndDateWidget extends StatelessWidget {
  const TypeAndDateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MyRadioButton(
          value: 1,
          groupValue: 1000,
          onChanged: (value) {},
          text: 'دریافتی',
        ),
        MyRadioButton(
          value: 0,
          groupValue: 1000,
          onChanged: (value) {},
          text: 'پرداختی',
        ),

        OutlinedButton(
          onPressed: () {},
          child: const Text(
            'تاریخ',
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
        ),
      ],
    );
  }
}

class MyRadioButton extends StatelessWidget {
  final int value;
  final int groupValue;
  final Function(int?) onChanged;
  final String text;
  const MyRadioButton({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Radio(value: value, groupValue: groupValue, onChanged: onChanged),
        Text(text, style: TextStyle(color: Colors.black, fontSize: 18)),
      ],
    );
  }
}

class MyTextField extends StatelessWidget {
  final String hintText;
  final TextInputType type;
  const MyTextField({
    super.key,
    required this.hintText,
    this.type = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: type,
      style: TextStyle(fontSize: 16),
      cursorColor: Colors.red,
      decoration: InputDecoration(
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade500),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade500),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade500),
        ),
        hintText: hintText,
      ),
    );
  }
}
