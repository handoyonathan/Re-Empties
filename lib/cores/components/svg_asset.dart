import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgAsset extends StatelessWidget {
  final String assetName;
  final double? size;
  final Color? color;
  final BoxFit fit;
  final AlignmentGeometry alignment;

  const SvgAsset(
    this.assetName, {
    super.key,
    this.size,
    this.color,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
  });

  @override
  Widget build(BuildContext context) => SvgPicture.asset(
        assetName,
        width: size,
        height: size,
        fit: fit,
        alignment: alignment,
        color: color,
      );
}
