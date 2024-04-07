import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resmpk/helpers/app_style.dart';

class AppImage extends StatelessWidget {
  const AppImage({
    super.key,
    required this.asset,
    this.width,
    this.height,
    this.colorFilter,
    this.color,
    this.fit = BoxFit.contain,
  });

  final String asset;
  final double? height;
  final double? width;
  final ColorFilter? colorFilter;
  final Color? color;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    final isNetwork = asset.endsWith('https://');
    return SizedBox(
      width: width,
      height: height,
      child: isNetwork ? _buildNetwork() : _buildLoacal(),
    );
  }

  Widget _buildNetwork() {
    return Hero(
      tag: asset,
      child: CachedNetworkImage(
        imageUrl: asset,
        placeholder: (context, url) => _placeholder(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
        fit: fit,
      ),
    );
  }

  Widget _buildLoacal() {
    final isSvg = asset.endsWith('.svg');

    if (isSvg) {
      return SvgPicture.asset(
        asset,
        fit: fit,
        color: color,
        colorFilter: colorFilter,
        placeholderBuilder: (BuildContext context) => _placeholder(),
      );
    } else {
      return Image.asset(asset);
    }
  }

  Widget _placeholder() {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
