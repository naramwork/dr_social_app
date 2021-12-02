import 'package:dr_social/app/themes/color_const.dart';
import 'package:flutter/material.dart';

class FAP extends StatelessWidget {
  final Function onPressed;
  const FAP({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      //Floating action button on Scaffold
      onPressed: () {
        onPressed();
      },
      child: Container(
        width: 60,
        height: 60,
        child: const Icon(
          Icons.add,
          size: 40,
        ),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: ColorConst.gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
      backgroundColor: Colors.blue.shade400, //icon inside button
    );
  }
}
