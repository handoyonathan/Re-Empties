import 'package:flutter/material.dart';

class ImageAsset extends StatelessWidget {
  final String imagePath;
  final double? width;
  final double? height;
  final BoxFit fit;
  const ImageAsset({
    super.key,
    required this.imagePath,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) => Image(
        image: AssetImage(imagePath),
        width: width,
        height: height,
        fit: fit,
      );
}