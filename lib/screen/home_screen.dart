import 'package:financial_management_app/constant.dart';
import 'package:flutter/material.dart';
import 'package:searchbar_animation/searchbar_animation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          backgroundColor: kPurpleColor,
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20, left: 5, top: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: SearchBarAnimation(
                        hintText: 'جستجو کنید ...',
                        buttonElevation: 0,
                        buttonShadowColour: Colors.black26,
                        isOriginalAnimation: false,
                        buttonBorderColour: Colors.black26,
                        buttonColour: Colors.white,
                        onFieldSubmitted: (String t) {},
                        textEditingController: searchController,
                        trailingWidget: const Icon(
                          Icons.search,
                          size: 20,
                          color: Colors.black,
                        ),
                        secondaryButtonWidget: const Icon(
                          Icons.close,
                          size: 20,
                          color: Colors.black,
                        ),
                        buttonWidget: const Icon(
                          Icons.search,
                          size: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),

                    Text('تراکنش ها ', style: TextStyle(fontSize: 20)),
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
