import 'package:cuida_pet/app/core/ui/extensions/size_screen_extension.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final GestureTapCallback onTap;
  final double width;
  final Color color;
  final IconData icon;
  final String text;

  const RoundedButton(
      {Key? key,
      required this.onTap,
      required this.width,
      required this.color,
      required this.icon,
      required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: 45.h,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 20.w,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: VerticalDivider(
                thickness: 2,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: EdgeInsets.zero,
              child: Text(
                text,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.sp),
              ),
            )
          ],
        ),
      ),
    );
  }
}
