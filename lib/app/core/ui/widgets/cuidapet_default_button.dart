// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cuida_pet/app/core/ui/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class CuidapetDefaultButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final double borderRadius;
  final Color? colors;
  final String label;
  final Color? labelColor;
  final double? labelSize;
  final double padding;
  final double width;
  final double height;
  const CuidapetDefaultButton({
    Key? key,
    this.onPressed,
    this.borderRadius = 10,
    this.colors,
    required this.label,
    this.labelColor,
    this.labelSize,
    this.padding = 10,
    this.width = double.infinity,
    this.height = 66,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: colors ?? context.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: TextStyle(
              fontSize: labelSize ?? 20, color: labelColor ?? Colors.white),
        ),
      ),
    );
  }
}
