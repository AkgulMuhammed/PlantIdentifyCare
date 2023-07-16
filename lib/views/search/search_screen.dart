

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:plant_identify_care/constants/app_colors.dart';
import 'package:plant_identify_care/services/firebase_controller.dart';
import 'package:plant_identify_care/views/plantDetail/plant_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FirebaseController>(
      init: FirebaseController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: _appBar(controller),
            toolbarHeight: 70,
          ),
          body: Obx(
            () => controller.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : controller.comeToFlowers.isEmpty
                    ? _buildNoDataWidget(context)
                    : Obx(
                        () {
                          if (controller.isLoading.value) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          final filteredList =
                              textEditingController.text.isEmpty
                                  ? controller.comeToFlowers
                                  : controller.filteredFlowers;

                          return ListView.builder(
                            itemCount: filteredList.length,
                            itemBuilder: (context, index) {
                              final flower = filteredList[index];

                              return Card(
                                
                                child: ListTile(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) =>
                                          PlantDetails(detailsFlower: flower),
                                    ));
                                  },
                                  title: Text(flower.turkishName),
                                  subtitle: Text(flower.latinceName),
                                  leading: CircleAvatar(
                                      child: CustomImage(image: flower.image)),
                                ),
                              ); 
                            },
                          );
                        },
                      ),
          ),
        );
      },
    );
  }

  Padding _appBar(FirebaseController controller) {
    return Padding(
        padding: const EdgeInsets.only(left: 30, top: 10),
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: 54,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 10),
                blurRadius: 50,
                color: kPrimaryColor.withOpacity(0.23),
              ),
            ],
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  controller: textEditingController,
                  onChanged: (query) {
                    setState(() {
                      controller.searchFlowers(query);
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Ara",
                    hintStyle: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                    ),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                ),
              ),
              SvgPicture.asset("assets/icons/search.svg"),
            ],
          ),
        ));
  }

  Widget _buildNoDataWidget(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.my_library_books_rounded,
            color: Colors.blue,
            size: 50,
          ),
          SizedBox(height: 20),
          Text(
            "Kayıtlı bir Veri  yok ",
          ),
        ],
      ),
    );
  }
}

class CustomImage extends StatelessWidget {
  final String? image;

  const CustomImage({
    required this.image,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (image == null) {
      return ClipOval(child: Image.asset("assets/images/bottom_img_1.png"));
    }
    return GetBuilder<FirebaseController>(
      init: FirebaseController(), 
      id: image,
      builder: (controller) {
        return FutureBuilder<String>(
          future: controller.getImageURL(image!),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData && snapshot.data != null) {
              return Image.network(
                snapshot.data!,
                fit: BoxFit.cover,
              );
            } else {
              return const Text('Image not available');
            }
          },
        );
      },
    );
  }
}
