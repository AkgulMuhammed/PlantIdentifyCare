import 'package:flutter/material.dart';
import 'package:plant_identify_care/constants/app_colors.dart';
import 'package:plant_identify_care/views/home/components/body.dart';

class HomeScreen extends StatefulWidget {
  final bool isSideBarOpen;

  const HomeScreen({Key? key, required this.isSideBarOpen}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: widget.isSideBarOpen ? kPrimaryColor : Colors.transparent,
          width: widget.isSideBarOpen ? 2 : 0,
        ),
      ),
      child: Scaffold(
        appBar: buildAppBar(context),
        body: const Body(),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: kPrimaryColor,
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
