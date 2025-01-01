import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:spark_trackify/gen/assets.gen.dart';

import '../core/common/ThemeColors.dart';

class BaseImageView extends StatelessWidget {
  const BaseImageView(
      {super.key,
      required this.imageUrl,
      this.width,
      this.height,
      this.errorWidget,
      required this.nameLetters,
      this.circleColor,
      this.fontSize = 24.0});

  final String imageUrl;
  final double? width;
  final double? height;
  final Widget? errorWidget;
  final String nameLetters;
  final Color? circleColor;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return imageUrl.isNotEmpty && imageUrl != dotenv.get("IMAGE_URL", fallback: "")
        ? CachedNetworkImage(
            imageUrl: dotenv.get("IMAGE_URL", fallback: "") + imageUrl,
            width: width ?? 80,
            height: height ?? 80,
            placeholder: (context, url) {
              return Assets.images.personPlaceholder.image(
                width: width ?? 80,
                height: height ?? 80,
              );
            },
            errorWidget: (context, url, error) {
              if (errorWidget == null) {
                return Container(
                  color: circleColor ?? Colors.blue,
                  child: Center(
                    child: Text(
                      nameLetters ?? "",
                      style: appTextStyle(textColor: Colors.white, fontSize: fontSize ?? 24, style: FontStyle.semibold),
                    ),
                  ),
                );
              } else {
                return errorWidget!;
              }
            },
            fit: BoxFit.contain,
          )
        : Container(
            width: width ?? 80,
            height: height ?? 80,
            color: circleColor ?? Colors.blue,
            child: Center(
              child: Text(
                nameLetters ?? "",
                style: appTextStyle(textColor: Colors.white, fontSize: fontSize ?? 24, style: FontStyle.semibold),
              ),
            ),
          );
  }
}
