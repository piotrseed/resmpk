/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// ignore_for_file: directives_ordering

import 'package:flutter/widgets.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  AssetGenImage get appIcon => const AssetGenImage('assets/icons/app_icon.png');
  String get arrowBottom => 'assets/icons/arrow_bottom.svg';
  String get iconApple => 'assets/icons/icon_apple.svg';
  String get iconBack => 'assets/icons/icon_back.svg';
  String get iconBack2 => 'assets/icons/icon_back2.svg';
  String get iconBook => 'assets/icons/icon_book.svg';
  String get iconCamera => 'assets/icons/icon_camera.svg';
  String get iconCheck => 'assets/icons/icon_check.svg';
  String get iconChevronForward => 'assets/icons/icon_chevron_forward.svg';
  String get iconClock => 'assets/icons/icon_clock.svg';
  String get iconComment => 'assets/icons/icon_comment.svg';
  AssetGenImage get iconDiamonds =>
      const AssetGenImage('assets/icons/icon_diamonds.png');
  String get iconFacebook => 'assets/icons/icon_facebook.svg';
  String get iconFlag => 'assets/icons/icon_flag.svg';
  String get iconGoogle => 'assets/icons/icon_google.svg';
  String get iconGreenDot => 'assets/icons/icon_green_dot.svg';
  String get iconImage => 'assets/icons/icon_image.svg';
  String get iconLike => 'assets/icons/icon_like.svg';
  String get iconLock => 'assets/icons/icon_lock.svg';
  String get iconSettings => 'assets/icons/icon_settings.svg';
  String get iconSettingsFill => 'assets/icons/icon_settings_fill.svg';
  AssetGenImage get iconShowMore =>
      const AssetGenImage('assets/icons/icon_show_more.png');
  AssetGenImage get iconStreak =>
      const AssetGenImage('assets/icons/icon_streak.png');
  AssetGenImage get kidPlaceholder =>
      const AssetGenImage('assets/icons/kid_placeholder.png');
  AssetGenImage get kidPlaceholder2 =>
      const AssetGenImage('assets/icons/kid_placeholder2.png');
  String get pencil => 'assets/icons/pencil.svg';
  String get pogaduszki => 'assets/icons/pogaduszki.svg';
  AssetGenImage get pogaduszkiSplash =>
      const AssetGenImage('assets/icons/pogaduszki_splash.png');
}

class Assets {
  Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
}

class AssetGenImage extends AssetImage {
  const AssetGenImage(String assetName) : super(assetName);

  Image image({
    Key? key,
    ImageFrameBuilder? frameBuilder,
    ImageLoadingBuilder? loadingBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? width,
    double? height,
    Color? color,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    FilterQuality filterQuality = FilterQuality.low,
  }) {
    return Image(
      key: key,
      image: this,
      frameBuilder: frameBuilder,
      loadingBuilder: loadingBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      width: width,
      height: height,
      color: color,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      filterQuality: filterQuality,
    );
  }

  String get path => assetName;
}
