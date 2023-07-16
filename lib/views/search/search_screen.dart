import 'package:flutter/material.dart';
import '../home/components/recomend_plants.dart';
import 'components/search_box.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final List<Map<String, dynamic>> plantList = [
    {
      'image': 'assets/images/image_3.png',
      'title': 'Samantha',
      'country': 'Russia',
      'price': 440,
    },
    {
      'image': 'assets/images/image_3.png',
      'title': 'Samantha',
      'country': 'Russia',
      'price': 440,
    },
    {
      'image': 'assets/images/image_3.png',
      'title': 'Samantha',
      'country': 'Russia',
      'price': 440,
    },
    {
      'image': 'assets/images/image_3.png',
      'title': 'Samantha',
      'country': 'Russia',
      'price': 440,
    },
    {
      'image': 'assets/images/image_3.png',
      'title': 'Samantha',
      'country': 'Russia',
      'price': 440,
    },
    {
      'image': 'assets/images/image_3.png',
      'title': 'Samantha',
      'country': 'Russia',
      'price': 440,
    },
    {
      'image': 'assets/images/image_3.png',
      'title': 'Samantha',
      'country': 'Russia',
      'price': 440,
    },
    {
      'image': 'assets/images/image_3.png',
      'title': 'Samantha',
      'country': 'Russia',
      'price': 440,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: 30, top: 10),
          child: SearchBox(),
        ),
        toolbarHeight: 70,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(right: 15),
          child: SizedBox(
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: SizedBox(
                child: GridView.builder(
                  //physics: const NeverScrollableScrollPhysics(),
                  primary: true,
                  //shrinkWrap: true,
                  itemCount: plantList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 0.64, mainAxisSpacing: 0.9),
                  itemBuilder: (context, index) => RecommendsPlantCard(
                    isAsset: true,
                    latinceName: "",
                    image: plantList[index]['image'],
                    title: plantList[index]['title'],
                    //country: plantList[index]['country'],
                    //price: plantList[index]['price'],
                    press: () {},
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
