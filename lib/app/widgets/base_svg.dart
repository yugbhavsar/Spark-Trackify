import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BaseSvg extends StatelessWidget {
  const BaseSvg({super.key, required this.iconName, this.iconSize, this.iconColor, this.onClick});

  final String iconName;
  final double? iconSize;
  final Color? iconColor;
  final VoidCallback? onClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: SizedBox(
        width: iconSize ?? 18,
        height: iconSize ?? 18,
        child: SvgPicture.asset(
          iconName,
          colorFilter: ColorFilter.mode(iconColor ?? Colors.grey, BlendMode.srcIn),
        ),
      ),
    );
  }
}
