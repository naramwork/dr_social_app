import 'package:country_calling_code_picker/picker.dart';
import 'package:dr_social/app/themes/color_const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/svg.dart';
import 'package:phone_number/phone_number.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PhoneTextField extends StatefulWidget {
  final String? hintText;
  final IconData? icon;
  final Color? color;
  final bool isRequired;
  final String? imageIcon;
  final Color? backgroundColor;
  final Function onSave;

  final TextEditingController? controller;
  final int? maxLine;

  const PhoneTextField({
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
  }) : super(key: key);

  @override
  State<PhoneTextField> createState() => _PhoneTextFieldState();
}

class _PhoneTextFieldState extends State<PhoneTextField> {
  Country? _selectedCountry;

  @override
  void initState() {
    initCountry();
    super.initState();
  }

  void initCountry() async {
    final country = await getDefaultCountry(context);
    setState(() {
      _selectedCountry = country;
    });
  }

  void _showCountryPicker() async {
    final country = await showCountryPickerSheet(
      context,
    );
    if (country != null) {
      setState(() {
        _selectedCountry = country;
      });
    }
  }

  Future<bool> validatePhone(value) async {
    PhoneNumberUtil plugin = PhoneNumberUtil();
    RegionInfo region = RegionInfo(
        name: _selectedCountry!.name,
        prefix: int.parse(_selectedCountry!.callingCode),
        code: _selectedCountry!.countryCode);
    bool isValid = await plugin.validate(value, region.code);
    return Future.value(isValid);
  }

  final snackBar = const SnackBar(
    content: Text(
      'تأكد من ادخال رقم هاتف صحيح',
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    ),
    behavior: SnackBarBehavior.floating,
  );

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
            widget.icon != null
                ? Icon(
                    widget.icon,
                    size: 35,
                    color: ColorConst.textInputIconColor,
                  )
                : ImageIcon(
                    AssetImage(widget.imageIcon!),
                    size: 35,
                    color: ColorConst.textInputIconColor,
                  ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: VerticalDivider(
                thickness: 2,
                color: isDarkMode
                    ? const Color.fromRGBO(200, 230, 241, 0.6)
                    : Colors.grey.shade300,
              ),
            ),
            TextButton(
              onPressed: () {
                _showCountryPicker();
              },
              child: _selectedCountry == null
                  ? Container()
                  : Row(
                      children: [
                        Image.asset(
                          _selectedCountry!.flag,
                          package: countryCodePackageName,
                          width: 24,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: Text(
                            _selectedCountry!.callingCode,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
            ),
            Expanded(
              child: TextFormField(
                keyboardType: TextInputType.phone,
                onSaved: (value) async {
                  final bool isPhone = await validatePhone(value);
                  if (isPhone) {
                    widget.onSave({
                      'value': value,
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                validator: (value) {
                  if (widget.isRequired && (value == null || value.isEmpty)) {
                    return 'هذا الحقل مطلوب';
                  }
                  return null;
                },
                textAlignVertical: TextAlignVertical.center,
                cursorColor: isDarkMode ? Colors.white : Colors.grey,
                autocorrect: false,
                maxLength: widget.maxLine,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 3.h),
                  hintText: widget.hintText,
                  hintStyle: TextStyle(
                      color: ColorConst.textInputHintColor, fontSize: 16),
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
