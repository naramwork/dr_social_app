import 'package:flutter/material.dart';

class NextButton extends StatelessWidget {
  final double width;
  final Function onpressed;
  final double? borderRad;

  const NextButton({
    Key? key,
    required this.width,
    required this.onpressed,
    this.borderRad,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                topRight: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
          ),
          minimumSize: MaterialStateProperty.all(Size(width, 50)),
          // elevation: MaterialStateProperty.all(3),
        ),
        onPressed: () {
          onpressed();
        },
        child: const Padding(
          padding: EdgeInsets.only(
            top: 10,
            bottom: 10,
          ),
          child: Text('السابق'),
        ),
      ),
    );
  }
}
