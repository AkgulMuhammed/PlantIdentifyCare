import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plant_identify_care/views/onbording/components/dot_indicator.dart';
import 'package:plant_identify_care/views/onbording/components/onboard_content.dart';

import '../../models/onboard_model.dart';




class OnBordingScreen extends StatefulWidget {
  const OnBordingScreen({super.key});

  @override
  State<OnBordingScreen> createState() => _OnBordingScreenState();
}

class _OnBordingScreenState extends State<OnBordingScreen> {
  late PageController _pageController;

  int _pageIndex = 0;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemCount: onboardData.length,
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _pageIndex = index;
                  });
                },
                itemBuilder: (context, index) => OnboardContent(
                    image: onboardData[index].image,
                    title: onboardData[index].title,
                    description: onboardData[index].description),
              ),
            ),
            Row(
              children: [
                ...List.generate(
                  onboardData.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: DotIndicator(isActive: index == _pageIndex),
                  ),
                ),
                const Spacer(),
                SizedBox(
                  height: 60,
                  width: 60,
                  child: ElevatedButton(
                      onPressed: () {
                        if (_pageIndex == onboardData.length - 1) {
                          Navigator.pushReplacementNamed(context, '/navpage');
                        } else {
                          _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.ease);
                        }
                      },
                      child: SvgPicture.asset("assets/icons/arrow-right.svg",
                          colorFilter: const ColorFilter.mode(
                              Colors.black, BlendMode.srcIn))),
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
