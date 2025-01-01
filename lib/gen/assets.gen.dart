/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart' as _svg;
import 'package:vector_graphics/vector_graphics.dart' as _vg;

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/arrow.png
  AssetGenImage get arrow => const AssetGenImage('assets/images/arrow.png');

  /// File path: assets/images/arrowright.png
  AssetGenImage get arrowright =>
      const AssetGenImage('assets/images/arrowright.png');

  /// File path: assets/images/assign.png
  AssetGenImage get assign => const AssetGenImage('assets/images/assign.png');

  /// File path: assets/images/backArrow.png
  AssetGenImage get backArrow =>
      const AssetGenImage('assets/images/backArrow.png');

  /// File path: assets/images/development.png
  AssetGenImage get development =>
      const AssetGenImage('assets/images/development.png');

  /// File path: assets/images/down_arrow.png
  AssetGenImage get downArrow =>
      const AssetGenImage('assets/images/down_arrow.png');

  /// File path: assets/images/eSparkBiz.png
  AssetGenImage get eSparkBiz =>
      const AssetGenImage('assets/images/eSparkBiz.png');

  /// File path: assets/images/gadgets.png
  AssetGenImage get gadgets => const AssetGenImage('assets/images/gadgets.png');

  /// File path: assets/images/ipad-10thGen.png
  AssetGenImage get ipad10thGen =>
      const AssetGenImage('assets/images/ipad-10thGen.png');

  /// File path: assets/images/occupied.png
  AssetGenImage get occupied =>
      const AssetGenImage('assets/images/occupied.png');

  /// File path: assets/images/padlock.png
  AssetGenImage get padlock => const AssetGenImage('assets/images/padlock.png');

  /// File path: assets/images/personPlaceholder.jpg
  AssetGenImage get personPlaceholder =>
      const AssetGenImage('assets/images/personPlaceholder.jpg');

  /// File path: assets/images/rotate.png
  AssetGenImage get rotate => const AssetGenImage('assets/images/rotate.png');

  /// File path: assets/images/testing.png
  AssetGenImage get testing => const AssetGenImage('assets/images/testing.png');

  /// File path: assets/images/unassign.png
  AssetGenImage get unassign =>
      const AssetGenImage('assets/images/unassign.png');

  /// File path: assets/images/user.png
  AssetGenImage get user => const AssetGenImage('assets/images/user.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        arrow,
        arrowright,
        assign,
        backArrow,
        development,
        downArrow,
        eSparkBiz,
        gadgets,
        ipad10thGen,
        occupied,
        padlock,
        personPlaceholder,
        rotate,
        testing,
        unassign,
        user
      ];
}

class $AssetsPhonesGen {
  const $AssetsPhonesGen();

  /// File path: assets/phones/ipadair3.png
  AssetGenImage get ipadair3 =>
      const AssetGenImage('assets/phones/ipadair3.png');

  /// File path: assets/phones/iphone12.png
  AssetGenImage get iphone12 =>
      const AssetGenImage('assets/phones/iphone12.png');

  /// File path: assets/phones/iphone15promax.png
  AssetGenImage get iphone15promax =>
      const AssetGenImage('assets/phones/iphone15promax.png');

  /// File path: assets/phones/motog31.png
  AssetGenImage get motog31 => const AssetGenImage('assets/phones/motog31.png');

  /// File path: assets/phones/oneplus9r.png
  AssetGenImage get oneplus9r =>
      const AssetGenImage('assets/phones/oneplus9r.png');

  /// File path: assets/phones/phone.png
  AssetGenImage get phone => const AssetGenImage('assets/phones/phone.png');

  /// File path: assets/phones/readmeNote11.png
  AssetGenImage get readmeNote11 =>
      const AssetGenImage('assets/phones/readmeNote11.png');

  /// File path: assets/phones/samsung.png
  AssetGenImage get samsung => const AssetGenImage('assets/phones/samsung.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        ipadair3,
        iphone12,
        iphone15promax,
        motog31,
        oneplus9r,
        phone,
        readmeNote11,
        samsung
      ];
}

class $AssetsSvgsGen {
  const $AssetsSvgsGen();

  /// File path: assets/svgs/caretDownBold.svg
  SvgGenImage get caretDownBold =>
      const SvgGenImage('assets/svgs/caretDownBold.svg');

  /// File path: assets/svgs/eSpark_logo.svg
  SvgGenImage get eSparkLogo =>
      const SvgGenImage('assets/svgs/eSpark_logo.svg');

  /// File path: assets/svgs/empty_data.svg
  SvgGenImage get emptyData => const SvgGenImage('assets/svgs/empty_data.svg');

  /// List of all assets
  List<SvgGenImage> get values => [caretDownBold, eSparkLogo, emptyData];
}

class Assets {
  Assets._();

  static const String aEnv = '.env';
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsPhonesGen phones = $AssetsPhonesGen();
  static const $AssetsSvgsGen svgs = $AssetsSvgsGen();

  /// List of all assets
  static List<String> get values => [aEnv];
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class SvgGenImage {
  const SvgGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  }) : _isVecFormat = false;

  const SvgGenImage.vec(
    this._assetName, {
    this.size,
    this.flavors = const {},
  }) : _isVecFormat = true;

  final String _assetName;
  final Size? size;
  final Set<String> flavors;
  final bool _isVecFormat;

  _svg.SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    _svg.SvgTheme? theme,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    final _svg.BytesLoader loader;
    if (_isVecFormat) {
      loader = _vg.AssetBytesLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
      );
    } else {
      loader = _svg.SvgAssetLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
        theme: theme,
      );
    }
    return _svg.SvgPicture(
      loader,
      key: key,
      matchTextDirection: matchTextDirection,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      colorFilter: colorFilter ??
          (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
