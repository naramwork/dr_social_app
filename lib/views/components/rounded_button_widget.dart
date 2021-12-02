import 'package:flutter/material.dart';

class RoundedButtonWidget extends StatelessWidget {
  final Widget label;
  final double width;
  final Function onpressed;
  final double? borderRad;

  const RoundedButtonWidget({
    Key? key,
    required this.label,
    required this.width,
    required this.onpressed,
    this.borderRad,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
                color: Colors.black26, offset: Offset(0, 4), blurRadius: 5.0)
          ],
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue.shade400,
              Colors.blue.shade300,
              Colors.blue.shade300,
              Colors.blue.shade300,
              Colors.blue.shade400,
            ],
          ),
          borderRadius: BorderRadius.circular(borderRad ?? 50),
        ),
        child: ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            minimumSize: MaterialStateProperty.all(Size(width, 50)),
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
            // elevation: MaterialStateProperty.all(3),
            shadowColor: MaterialStateProperty.all(Colors.transparent),
          ),
          onPressed: () {
            onpressed();
          },
          child: Padding(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 10,
            ),
            child: label,
          ),
        ),
      ),
    );
  }
}
