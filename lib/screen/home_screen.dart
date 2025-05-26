import 'package:financial_management_app/constant.dart';
import 'package:financial_management_app/model/mony.dart';
import 'package:financial_management_app/screen/new_transactions_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:searchbar_animation/searchbar_animation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static List<Money> moneys = [
    Money(
      id: 0,
      title: 'Test1',
      price: '1000',
      date: '1400/01/02',
      isReceived: true,
    ),

    Money(
      id: 1,
      title: 'Test2',
      price: '2000',
      date: '1400/01/02',
      isReceived: false,
    ),

    Money(
      id: 2,
      title: 'Test3',
      price: '3000',
      date: '1400/01/02',
      isReceived: false,
    ),
  ];

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
        floatingActionButton: fabWidget(),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              HeaderWidget(searchController: searchController),
              //const Expanded(child: EmptyWidget()),
              Expanded(
                child: ListView.builder(
                  itemCount: HomeScreen.moneys.length,
                  itemBuilder: (context, index) {
                    return MyListTileWidget(index: index);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget fabWidget() {
    return FloatingActionButton(
      backgroundColor: kPurpleColor,
      onPressed: () {
        NewTransactionsScreen.descriptionController.text = '';
        NewTransactionsScreen.priceController.text = '';
        NewTransactionsScreen.groupId = 0;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const NewTransactionsScreen(),
          ),
        ).then((value) {
          setState(() {
            print('Refresh');
          });
        });
      },
      child: const Icon(Icons.add),
    );
  }
}

class MyListTileWidget extends StatelessWidget {
  final int index;
  const MyListTileWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: HomeScreen.moneys[index].isReceived
                  ? kGreenColor
                  : kRedColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Icon(
                HomeScreen.moneys[index].isReceived ? Icons.add : Icons.remove,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              HomeScreen.moneys[index].title,
              style: TextStyle(fontSize: 22),
            ),
          ),
          const Spacer(),
          Column(
            children: [
              Row(
                children: [
                  const Text(
                    'تومان',
                    style: TextStyle(fontSize: 18, color: kRedColor),
                  ),
                  Text(
                    HomeScreen.moneys[index].price,
                    style: const TextStyle(fontSize: 18, color: kRedColor),
                  ),
                ],
              ),
              Text(
                HomeScreen.moneys[index].date,
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ],
          ),
        ],
      ),
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
          Text('تراکنش ها ', style: TextStyle(fontSize: 24)),
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
