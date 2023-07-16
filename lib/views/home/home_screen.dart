import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plant_identify_care/constants/app_colors.dart';
import 'package:plant_identify_care/services/firebase_controller.dart';
import 'package:plant_identify_care/views/home/components/body.dart';

class HomeScreen extends StatefulWidget {
  final bool isSideBarOpen;

  const HomeScreen({Key? key, required this.isSideBarOpen}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<FirebaseController>(
      init: FirebaseController(),
      builder: (controller) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: widget.isSideBarOpen ? kPrimaryColor : Colors.transparent,
              width: widget.isSideBarOpen ? 2 : 0,
            ),
          ),
          child: Scaffold(
            appBar: buildAppBar(context),
            body: Obx(
              () => controller.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : controller.comeToFlowers.isEmpty
                      ? _buildNoDataWidget(context)
                      : Body(flowersList: controller.comeToFlowers),
            ),
          ),
        );
      },
    );
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

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: kPrimaryColor,
      centerTitle: true,
      title: Text(
        'Plant Identify Care!',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.white,
            ),
      ),
      elevation: 0,
    );
  }
}
