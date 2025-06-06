import 'dart:math';

import 'package:financial_management_app/constant.dart';
import 'package:financial_management_app/main.dart';
import 'package:financial_management_app/model/money.dart';
import 'package:financial_management_app/utils/extention.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class NewTransactionsScreen extends StatefulWidget {
  const NewTransactionsScreen({super.key});
  static int groupId = 0;
  static TextEditingController descriptionController = TextEditingController();
  static TextEditingController priceController = TextEditingController();
  static bool isEditing = false;
  static int id = 0;
  static String date = '';
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
                style: TextStyle(
                  fontSize: ScreenSize(context).screenWidth < 1004
                      ? 14
                      : ScreenSize(context).screenWidth * 0.015,
                ),
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
              SizedBox(height: 10),
              TypeAndDateWidget(),
              MyButton(
                text: NewTransactionsScreen.isEditing
                    ? ' ویرایش کردن'
                    : 'اضافه کردن',
                onPressed: () {
                  Money item = Money(
                    id: Random().nextInt(9999999),
                    title: NewTransactionsScreen.descriptionController.text,
                    price: NewTransactionsScreen.priceController.text,
                    isReceived: NewTransactionsScreen.groupId == 1
                        ? true
                        : false,
                    date: NewTransactionsScreen.date,
                  );
                  if (NewTransactionsScreen.isEditing) {
                    int index = 0;
                    MyApp.getData();
                    for (int i = 0; i < hiveBox.values.length; i++) {
                      if (hiveBox.values.elementAt(i).id ==
                          NewTransactionsScreen.id) {
                        index = i;
                      }
                    }
                    hiveBox.putAt(index, item);
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
        Expanded(
          child: MyRadioButton(
            value: 1,
            groupValue: NewTransactionsScreen.groupId,
            onChanged: (value) {
              setState(() {
                NewTransactionsScreen.groupId = value!;
              });
            },
            text: 'دریافتی',
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: MyRadioButton(
            value: 2,
            groupValue: NewTransactionsScreen.groupId,
            onChanged: (value) {
              setState(() {
                NewTransactionsScreen.groupId = value!;
              });
            },
            text: 'پرداختی',
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: SizedBox(
            height: 50,
            child: OutlinedButton(
              onPressed: () async {
                var pickedDate = await showPersianDatePicker(
                  context: context,
                  initialDate: Jalali.now(),
                  firstDate: Jalali(1400),
                  lastDate: Jalali(1499),
                );
                setState(() {
                  String year = pickedDate!.year.toString();
                  //
                  String month = pickedDate.month.toString().length == 1
                      ? '0${pickedDate.month.toString()}'
                      : pickedDate.month.toString();
                  //
                  String day = pickedDate.day.toString().length == 1
                      ? '0${pickedDate.day.toString()}'
                      : pickedDate.day.toString();
                  //
                  NewTransactionsScreen.date = '$year/$month/$day';
                });
              },
              child: Text(
                NewTransactionsScreen.date,
                style: TextStyle(
                  fontSize: ScreenSize(context).screenWidth < 1004
                      ? 14
                      : ScreenSize(context).screenWidth * 0.01,
                  color: Colors.black,
                ),
              ),
            ),
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
        Text(
          text,
          style: TextStyle(
            color: Colors.black,
            fontSize: ScreenSize(context).screenWidth < 1004
                ? 14
                : ScreenSize(context).screenWidth * 0.01,
          ),
        ),
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
        hintStyle: TextStyle(
          fontSize: ScreenSize(context).screenWidth < 1004
              ? 14
              : ScreenSize(context).screenWidth * 0.012,
          color: Colors.grey.shade500,
        ),
      ),
    );
  }
}
