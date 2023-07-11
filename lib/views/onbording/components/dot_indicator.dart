import 'package:flutter/material.dart';

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    super.key,  this.isActive=false,
  });

final bool isActive;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height:isActive? 18:6,
      width: 4,
      decoration:  BoxDecoration(color: isActive? Colors.green:Colors.green.withOpacity(0.4),
      borderRadius: const BorderRadius.all(Radius.circular(12))
      ),
    );
  }
}