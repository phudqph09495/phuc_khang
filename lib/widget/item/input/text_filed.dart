import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../styles/init_style.dart';

class InputText1 extends StatefulWidget {
  IconData? iconData;
  IconData? suffix;
  bool obscureText;
  bool hasSuffix;
  bool hasLeading;
  String label;
  Function(String)? onChanged;
  Function(String)? validator;
Widget? iconPreFix;
  Function()? onTap;
  TextEditingController? controller;
  TextInputType? keyboardType;
  double width;
  double radius;
  Color colorBg;
  double height;
  Color borderColor;
  Function()? search;
  bool readOnly;
  double colorLabel;
  String? initVal;
Color suffixColor;
  Function()? onComplete;
  List<TextInputFormatter>? inputformater;

  InputText1(
      {this.obscureText = false,
      required this.label,
      this.keyboardType,
      this.controller,
      this.onChanged,
      this.iconData,
      this.suffix,
        this.suffixColor=Colors.black12,
      this.hasSuffix = false,
      this.hasLeading = false,
      this.validator,this.iconPreFix,
      this.radius = 20,
      this.width = double.infinity,
      this.borderColor = ColorApp.orangeF8,
      this.colorBg = Colors.white,
      this.colorLabel = 0.5,
      this.height = 50,
        this.initVal,
      this.readOnly = false,
      this.inputformater,
      this.onComplete,
        this.search,
      this.onTap});

  @override
  State<InputText1> createState() => _InputText1State();
}

class _InputText1State extends State<InputText1> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return PhysicalModel(
      borderRadius: BorderRadius.circular(
        widget.radius,
      ),
      color: Colors.transparent,
      elevation: 5.0,
      shadowColor: ColorApp.grey4F.withOpacity(0.3),
      child: TextFormField(

        initialValue:widget.initVal ,
        onEditingComplete: widget.onComplete,
        inputFormatters: widget.inputformater,
        readOnly: widget.readOnly,
        onTap: widget.onTap,
        obscureText: widget.obscureText,
        onChanged: widget.onChanged,
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        textAlign: TextAlign.left,
        style: StyleApp.textStyle400(),
        decoration: InputDecoration(
          errorStyle: StyleApp.textStyle500(color: Colors.red, fontSize: 14),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.radius),
            // borderSide:
            // const BorderSide(color: ColorApp.black, width: 1),
            borderSide: BorderSide(color: widget.borderColor, width: 0.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.radius),
            borderSide:
                BorderSide(color: Colors.black.withOpacity(0.2), width: 0.5),
            // borderSide:
            // const BorderSide(color: ColorApp.black, width: 1),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.radius),
            borderSide: const BorderSide(color: Colors.red, width: 0.5),
            // borderSide:
            // const BorderSide(color: ColorApp.black, width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.radius),
            borderSide: BorderSide(color: Colors.red, width: 0.5),
            // borderSide:
            // const BorderSide(color: ColorApp.black, width: 1),
          ),
          filled: true,
          fillColor: widget.colorBg,
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          prefixIcon: widget.hasLeading
              ? widget.iconPreFix
              : null,
          hintText: widget.label,
          hintStyle: StyleApp.textStyle400(
              fontSize: 16, color: Colors.black.withOpacity(widget.colorLabel)),
          suffixIcon: widget.hasSuffix
              ? InkWell(
                  onTap: widget.search,
                  child: Icon(
                    widget.suffix,
                    color: widget.suffixColor,
                  ),
                )
              : null,
          errorText: null,
        ),
        validator: (val) {
          if (val != null && widget.validator != null) {
            return widget.validator!(val);
          }
          return null;
        },
      ),
    );
  }
}
