

import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../constants/app_colors.dart';

class IndicatorRow extends StatelessWidget {
  final String title1;
  final double percent1;
  final String title2;
  final double percent2;

  const IndicatorRow({Key? key, required this.title1, required this.percent1, required this.title2, required this.percent2}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        children: [
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, bottom: 15),
                child: Text(
                  title1,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
                ),
              ),
              LinearPercentIndicator(
                barRadius: const Radius.circular(100),
                lineHeight: 8,
                percent: percent1,
                progressColor: kPrimaryColor,
                backgroundColor: kTertiaryColor,
              ),
            ],
          )),
          const SizedBox(width: 25),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left:10, bottom: 15),
                child: Text(
                  title2,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
                ),
              ),
              LinearPercentIndicator(
                barRadius: const Radius.circular(100),
                lineHeight: 8,
                percent: percent2,
                progressColor: kPrimaryColor,
                backgroundColor: kTertiaryColor,
              ),
            ],
          )),
        ],
      ),
    );
  }
}
