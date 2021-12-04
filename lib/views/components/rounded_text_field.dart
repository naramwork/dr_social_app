import 'package:dr_social/app/themes/color_const.dart';
import 'package:dr_social/controllers/color_mode.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/src/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class RoundedTextField extends StatelessWidget {
  final String? hintText;
  final IconData? icon;
  final Color? color;
  final bool isRequired;
  final String? imageIcon;
  final Color? backgroundColor;
  final Function onSave;
  final IconButton? suffixIcon;

  final TextInputType? inputType;
  final bool isPassword;

  final TextEditingController? controller;
  final int? maxLine;

  const RoundedTextField({
    Key? key,
    this.hintText,
    this.icon,
    required this.onSave,
    this.color,
    this.imageIcon,
    this.backgroundColor = Colors.blueAccent,
    this.controller,
    this.maxLine,
    this.isRequired = false,
    this.isPassword = false,
    this.inputType,
    this.suffixIcon,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      elevation: 4,
      color: Theme.of(context).primaryColor,
      margin: const EdgeInsets.symmetric(vertical: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              width: 2.w,
            ),
            icon != null
                ? Icon(
                    icon,
                    size: 35,
                    color: context.watch<ColorMode>().textInputIconColor,
                  )
                : ImageIcon(
                    AssetImage(imageIcon!),
                    size: 35,
                    color: context.watch<ColorMode>().textInputIconColor,
                  ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: VerticalDivider(
                thickness: 2,
                color: context.watch<ColorMode>().isDarkMode
                    ? const Color.fromRGBO(200, 230, 241, 0.6)
                    : Colors.grey.shade300,
              ),
            ),
            Expanded(
              child: TextFormField(
                onSaved: (save) {
                  onSave(save);
                },
                validator: (value) {
                  if (isRequired && (value == null || value.isEmpty)) {
                    return 'هذا الحقل مطلوب';
                  }
                  return null;
                },
                keyboardType: inputType,
                textAlignVertical: TextAlignVertical.center,
                cursorColor: context.watch<ColorMode>().isDarkMode
                    ? Colors.white
                    : Colors.grey,
                autocorrect: false,
                obscureText: isPassword,
                maxLength: maxLine,
                decoration: InputDecoration(
                  suffixIcon: suffixIcon,
                  contentPadding: EdgeInsets.symmetric(vertical: 3.h),
                  hintText: hintText,
                  hintStyle: TextStyle(
                      color: context.watch<ColorMode>().textInputHintColor,
                      fontSize: 16),
                  border: InputBorder.none,
                ),
              ),
            ),
            SvgPicture.asset(
              'assets/images/lift.svg',
              fit: BoxFit.fill,
              width: 14.w,
            ),
          ],
        ),
      ),
    );
  }
}
