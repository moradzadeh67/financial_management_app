import 'dart:math';
import 'package:financial_management_app/constant.dart';
import 'package:financial_management_app/model/money.dart';
import 'package:financial_management_app/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class NewTransactionsScreen extends StatefulWidget {
  const NewTransactionsScreen({super.key});
  static int groupId = 0;
  static TextEditingController descriptionController = TextEditingController();
  static TextEditingController priceController = TextEditingController();
  static bool isEditing = false;
  static int index = 0;
  @override
  State<NewTransactionsScreen> createState() => _NewTransactionsScreenState();
}

class _NewTransactionsScreenState extends State<NewTransactionsScreen> {
  Box<Money> hiveBox = Hive.box<Money>('moneyBox');
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
              Text(
                NewTransactionsScreen.isEditing
                    ? 'ویرایش تراکنش'
                    : 'تراکنش جدید',
                style: TextStyle(fontSize: 22),
              ),
              MyTextField(
                hintText: 'توضیحات',
                controller: NewTransactionsScreen.descriptionController,
              ),
              MyTextField(
                hintText: 'مبلغ',
                controller: NewTransactionsScreen.priceController,
                type: TextInputType.number,
              ),
              TypeAndDateWidget(),
              MyButton(
                text: NewTransactionsScreen.isEditing
                    ? ' ویرایش کردن'
                    : 'اضافه کردن',
                onPressed: () {
                  Money item = Money(
                    id: Random().nextInt(9999),
                    title: NewTransactionsScreen.descriptionController.text,
                    price: NewTransactionsScreen.priceController.text,
                    isReceived: NewTransactionsScreen.groupId == 1
                        ? true
                        : false,
                    date: '1400/01/01',
                  );
                  if (NewTransactionsScreen.isEditing) {
                    HomeScreen.moneys[NewTransactionsScreen.index] = item;
                  } else {
                    // HomeScreen.moneys.add(item);
                    hiveBox.add(item);
                  }
                  Navigator.pop(context);
                },
              ),
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

class TypeAndDateWidget extends StatefulWidget {
  const TypeAndDateWidget({super.key});

  @override
  State<TypeAndDateWidget> createState() => _TypeAndDateWidgetState();
}

class _TypeAndDateWidgetState extends State<TypeAndDateWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MyRadioButton(
          value: 1,
          groupValue: NewTransactionsScreen.groupId,
          onChanged: (value) {
            setState(() {
              NewTransactionsScreen.groupId = value!;
            });
          },
          text: 'دریافتی',
        ),
        MyRadioButton(
          value: 2,
          groupValue: NewTransactionsScreen.groupId,
          onChanged: (value) {
            setState(() {
              NewTransactionsScreen.groupId = value!;
            });
          },
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
        Radio(
          activeColor: kPurpleColor,
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
        ),
        Text(text, style: TextStyle(color: Colors.black, fontSize: 18)),
      ],
    );
  }
}

class MyTextField extends StatelessWidget {
  final String hintText;
  final TextInputType type;
  final TextEditingController controller;
  const MyTextField({
    super.key,
    required this.hintText,
    this.type = TextInputType.text,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
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
