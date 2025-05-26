import 'package:financial_management_app/constant.dart';
import 'package:financial_management_app/screen/new_transactions_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
        floatingActionButton: const MyFloatingActionButton(),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              HeaderWidget(searchController: searchController),
              const Expanded(child: EmptyWidget()),
            ],
          ),
        ),
      ),
    );
  }
}

class MyFloatingActionButton extends StatelessWidget {
  const MyFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: kPurpleColor,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const NewTransactionsScreen(),
          ),
        );
      },
      child: const Icon(Icons.add),
    );
  }
}

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key, required this.searchController});

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        SvgPicture.asset(
          'assets/images/Empty_file.svg',
          height: 300,
          width: 300,
        ),
        SizedBox(height: 10),
        const Text('!هیچ تراکنشی وجود ندارد', style: TextStyle(fontSize: 20)),
        const Spacer(),
      ],
    );
  }
}
