import 'dart:convert';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

String resolveImageUrl(String path) {
  if (path.contains('i.pinimg.com') && !path.startsWith('https://wsrv.nl/?url=')) {
    return 'https://wsrv.nl/?url=${Uri.encodeFull(path)}';
  }
  return path;
}

ImageProvider getAppImageProvider(String path) {
  if (path.startsWith('data:image')) {
    final base64String = path.split(',').last;
    return MemoryImage(base64Decode(base64String));
  }
  final resolved = resolveImageUrl(path);
  if (resolved.startsWith('http://') || resolved.startsWith('https://')) {
    return NetworkImage(resolved);
  }
  return AssetImage(resolved);
}

class AppImage extends StatelessWidget {
  final String imagePath;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Alignment alignment;
  final Widget? errorWidget;

  const AppImage({
    super.key,
    required this.imagePath,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.alignment = const Alignment(0.0, -0.2),
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    if (imagePath.startsWith('data:image')) {
      final base64String = imagePath.split(',').last;
      return Image.memory(
        base64Decode(base64String),
        width: width,
        height: height,
        fit: fit,
        alignment: alignment,
        errorBuilder: (context, error, stackTrace) =>
            errorWidget ??
            Container(
              width: width,
              height: height,
              color: AppColors.primaryContainer,
              child: const Icon(Icons.person, size: 40, color: AppColors.primary),
            ),
      );
    }

    final resolved = resolveImageUrl(imagePath);

    if (resolved.startsWith('http://') || resolved.startsWith('https://')) {
      return Image.network(
        resolved,
        width: width,
        height: height,
        fit: fit,
        alignment: alignment,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            width: width,
            height: height,
            color: const Color(0xFFFDE8EC),
            child: const Center(
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                ),
              ),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) =>
            errorWidget ??
            Container(
              width: width,
              height: height,
              color: AppColors.primaryContainer,
              child: const Icon(Icons.person, size: 40, color: AppColors.primary),
            ),
      );
    }

    return Image.asset(
      resolved,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      errorBuilder: (context, error, stackTrace) =>
          errorWidget ??
          Container(
            width: width,
            height: height,
            color: AppColors.primaryContainer,
            child: const Icon(Icons.person, size: 40, color: AppColors.primary),
          ),
    );
  }
}
